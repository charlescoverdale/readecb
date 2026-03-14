#' List available exchange rate currencies
#'
#' Returns a data frame of ISO 4217 currency codes for which the ECB publishes
#' reference exchange rates. No network call is made.
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{code}{Character. ISO 4217 currency code.}
#'   \item{currency}{Character. Currency name.}
#' }
#'
#' @family exchange rates
#' @export
#' @examples
#' list_exchange_rates()
list_exchange_rates <- function() {
  data.frame(
    code = c(
      "USD", "JPY", "GBP", "CHF", "AUD", "CAD", "SEK", "NOK", "DKK",
      "NZD", "CNY", "HKD", "SGD", "KRW", "THB", "MYR", "PHP", "IDR",
      "INR", "BRL", "MXN", "ZAR", "TRY", "PLN", "CZK", "HUF", "BGN",
      "RON", "HRK", "ISK", "ILS", "RUB"
    ),
    currency = c(
      "US dollar", "Japanese yen", "Pound sterling", "Swiss franc",
      "Australian dollar", "Canadian dollar", "Swedish krona",
      "Norwegian krone", "Danish krone", "New Zealand dollar",
      "Chinese yuan renminbi", "Hong Kong dollar", "Singapore dollar",
      "South Korean won", "Thai baht", "Malaysian ringgit",
      "Philippine peso", "Indonesian rupiah", "Indian rupee",
      "Brazilian real", "Mexican peso", "South African rand",
      "Turkish lira", "Polish zloty", "Czech koruna",
      "Hungarian forint", "Bulgarian lev", "Romanian leu",
      "Croatian kuna", "Icelandic krona", "Israeli shekel",
      "Russian rouble"
    ),
    stringsAsFactors = FALSE
  )
}


#' List available ECB dataflows
#'
#' Fetches the full list of dataflows from the ECB Data Portal. Each dataflow
#' corresponds to a dataset that can be queried with [ecb_get()].
#'
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{dataflow_id}{Character. The dataflow identifier.}
#'   \item{name}{Character. Human-readable name.}
#' }
#'
#' @family data access
#' @export
#' @examples
#' \donttest{
#' list_ecb_dataflows()
#' }
list_ecb_dataflows <- function(cache = TRUE) {
  cache_dir  <- tools::R_user_dir("readecb", "cache")
  cache_file <- file.path(cache_dir, "dataflows.rds")

  if (cache && file.exists(cache_file)) {
    return(readRDS(cache_file))
  }

  cli::cli_progress_step("Fetching ECB dataflow list")
  url <- "https://data-api.ecb.europa.eu/service/dataflow/ECB"
  req <- httr2::request(url)
  req <- httr2::req_headers(req, Accept = "application/xml")
  req <- httr2::req_retry(req, max_tries = 3L, backoff = ~ 2)
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
  cli::cli_progress_done()

  body <- httr2::resp_body_string(resp)

  # Extract dataflow IDs and names from XML without xml2 dependency
  # Pattern: <Dataflow id="XXX" ...>...<Name ...>YYY</Name>
  id_matches <- regmatches(
    body,
    gregexpr('Dataflow[^>]*id="([^"]+)"', body)
  )[[1]]
  ids <- sub('.*id="([^"]+)".*', "\\1", id_matches)

  name_matches <- regmatches(
    body,
    gregexpr("<Name[^>]*>[^<]+</Name>", body)
  )[[1]]
  names_clean <- sub("<Name[^>]*>([^<]+)</Name>", "\\1", name_matches)

  # The first Name element is typically for the structure, skip it if lengths

  # don't match
  if (length(names_clean) > length(ids)) {
    names_clean <- names_clean[seq_along(ids)]
  }

  out <- data.frame(
    dataflow_id = ids,
    name        = names_clean[seq_along(ids)],
    stringsAsFactors = FALSE
  )

  if (cache) {
    dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
    saveRDS(out, cache_file)
  }

  out
}
