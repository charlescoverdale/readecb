# Internal helpers for readecb

ecb_base_url <- "https://data-api.ecb.europa.eu/service/data/"

#' Fetch data from the ECB Data Portal API
#'
#' @param dataflow Character. The dataflow identifier (e.g. "EXR", "FM").
#' @param key Character. The SDMX series key.
#' @param from Optional start date (character, "YYYY" or "YYYY-MM" or
#'   "YYYY-MM-DD").
#' @param to Optional end date (same format as `from`).
#' @param cache Logical. If `TRUE` (the default), cache the downloaded file
#'   locally.
#' @return A data frame with columns from the CSV response.
#' @noRd
ecb_fetch <- function(dataflow, key, from = NULL, to = NULL, cache = TRUE) {
  url <- paste0(ecb_base_url, dataflow, "/", key)

  cache_dir <- tools::R_user_dir("readecb", "cache")
  cache_key <- paste0(
    dataflow, "_", gsub("[^A-Za-z0-9]", "_", key),
    if (!is.null(from)) paste0("_from_", from),
    if (!is.null(to))   paste0("_to_", to)
  )
  cache_file <- file.path(cache_dir, paste0(cache_key, ".csv"))

  if (cache && file.exists(cache_file)) {
    csv_text <- readLines(cache_file, warn = FALSE)
    csv_text <- paste(csv_text, collapse = "\n")
    df <- utils::read.csv(text = csv_text, stringsAsFactors = FALSE)
    return(df)
  }

  query_string <- paste0(
    "format=csvdata&detail=dataonly",
    if (!is.null(from)) paste0("&startPeriod=", from),
    if (!is.null(to))   paste0("&endPeriod=", to)
  )
  full_url <- paste0(url, "?", query_string)

  req <- httr2::request(full_url)
  req <- httr2::req_throttle(req, rate = 5 / 10)
  req <- httr2::req_retry(
    req, max_tries = 4L, backoff = ~ 8,
    is_transient = function(resp) {
      # ECB returns 400 with text/html when rate-limited
      ct <- httr2::resp_content_type(resp)
      httr2::resp_status(resp) == 400L && grepl("text/html", ct, fixed = TRUE)
    }
  )
  req <- httr2::req_error(req, is_error = function(resp) FALSE)

  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(e) {
      cli::cli_abort(c(
        "Failed to connect to the ECB Data Portal API.",
        "i" = "Check your internet connection or try again later.",
        "i" = "Original error: {conditionMessage(e)}"
      ))
    }
  )
  status <- httr2::resp_status(resp)

  if (status == 404L) {
    cli::cli_abort("No data found. Check the dataflow and key are valid.")
  }

  ct <- httr2::resp_content_type(resp)
  if (grepl("text/html", ct, fixed = TRUE)) {
    cli::cli_abort(
      "Invalid query. Check the dataflow ({.val {dataflow}}) and key ({.val {key}})."
    )
  }

  if (status >= 400L) {
    cli::cli_abort("ECB API returned HTTP {status}.")
  }

  csv_text <- httr2::resp_body_string(resp)

  if (cache) {
    dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
    writeLines(csv_text, cache_file)
  }

  utils::read.csv(text = csv_text, stringsAsFactors = FALSE)
}


#' Parse ECB TIME_PERIOD values to Date
#'
#' Handles daily (`YYYY-MM-DD`), monthly (`YYYY-MM`), quarterly (`YYYY-QN`),
#' and annual (`YYYY`) formats.
#'
#' @param x Character vector of TIME_PERIOD values.
#' @return A Date vector.
#' @noRd
parse_ecb_date <- function(x) {
  x <- as.character(x)
  out <- rep(as.Date(NA), length(x))

  # Daily / business-daily: YYYY-MM-DD

  daily <- grepl("^\\d{4}-\\d{2}-\\d{2}$", x)
  if (any(daily)) {
    out[daily] <- as.Date(x[daily])
  }

  # Monthly: YYYY-MM
  monthly <- grepl("^\\d{4}-\\d{2}$", x) & !daily
  if (any(monthly)) {
    out[monthly] <- as.Date(paste0(x[monthly], "-01"))
  }

  # Quarterly: YYYY-Q1, YYYY-Q2, YYYY-Q3, YYYY-Q4
  quarterly <- grepl("^\\d{4}-Q[1-4]$", x)
  if (any(quarterly)) {
    yr <- substr(x[quarterly], 1, 4)
    q  <- substr(x[quarterly], 7, 7)
    mn <- c("1" = "01", "2" = "04", "3" = "07", "4" = "10")[q]
    out[quarterly] <- as.Date(paste0(yr, "-", mn, "-01"))
  }

  # Annual: YYYY
  annual <- grepl("^\\d{4}$", x)
  if (any(annual)) {
    out[annual] <- as.Date(paste0(x[annual], "-01-01"))
  }

  out
}
