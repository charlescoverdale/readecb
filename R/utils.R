# Internal helpers for readecb

ecb_base_url <- "https://data-api.ecb.europa.eu/service/data/"

#' Get the cache directory, respecting the readecb.cache_dir option
#' @noRd
ecb_cache_dir <- function() {
  getOption("readecb.cache_dir", default = tools::R_user_dir("readecb", "cache"))
}

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

  cache_dir <- ecb_cache_dir()
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
    # Cap the total retry wait. Four tries at a flat 8s, on top of the
    # throttle above, cost a throttled host over 30 seconds per call before
    # failing. Bounding it keeps a refused host cheap rather than slow.
    max_seconds = 20,
    is_transient = function(resp) {
      status <- httr2::resp_status(resp)
      ct <- httr2::resp_content_type(resp)
      # ECB returns 400 with text/html when rate-limited.
      rate_limited <- status == 400L && grepl("text/html", ct, fixed = TRUE)
      # Supplying is_transient replaces httr2's default, which would otherwise
      # have retried 429 and 5xx. Gateway timeouts and 503s from the portal are
      # transient and worth a retry; without this they failed on first sight.
      server_side <- status == 429L || status >= 500L
      rate_limited || server_side
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

  # An HTML body is never how the ECB reports a bad query: an unknown dataflow
  # or series key returns 404 with application/problem+json, handled above.
  # HTML means the request never reached the data service, which in practice
  # is the portal's rate limiter, a gateway timeout, or maintenance. Reporting
  # that as "invalid query" sent users to check a key that was correct.
  ct <- httr2::resp_content_type(resp)
  if (grepl("text/html", ct, fixed = TRUE)) {
    if (status == 400L) {
      cli::cli_abort(c(
        "The ECB Data Portal is rate-limiting this connection.",
        "i" = "The dataflow and key are almost certainly fine: an unknown one
               returns a 404, not this.",
        "i" = "Retries were already attempted. Wait a little before trying
               again, or space out repeated calls.",
        "i" = "Dataflow {.val {dataflow}}, key {.val {key}}."
      ))
    }
    cli::cli_abort(c(
      "The ECB Data Portal returned a web page rather than data (HTTP {status}).",
      "i" = "This usually means the service is temporarily unavailable or under
             maintenance, rather than that the query is wrong.",
      "i" = "Dataflow {.val {dataflow}}, key {.val {key}}."
    ))
  }

  if (status >= 400L) {
    cli::cli_abort("ECB API returned HTTP {status}.")
  }

  csv_text <- httr2::resp_body_string(resp)

  if (cache) {
    dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
    writeLines(csv_text, cache_file)
  }

  df <- utils::read.csv(text = csv_text, stringsAsFactors = FALSE)

  if (nrow(df) == 0L) {
    cli::cli_abort(c(
      "ECB API returned no data for dataflow {.val {dataflow}}.",
      "i" = "Check that the series key and date range are valid.",
      "i" = "Key used: {.val {key}}"
    ))
  }

  df
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
