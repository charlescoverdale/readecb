#' Euro exchange rates
#'
#' Returns ECB reference exchange rates for one or more currencies against the
#' euro.
#'
#' @param currency Character vector of ISO 4217 currency codes (e.g. `"USD"`,
#'   `"GBP"`). Use [list_exchange_rates()] to see available currencies.
#' @param frequency One of `"monthly"` (default) or `"daily"`.
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{currency}{Character. ISO currency code.}
#'   \item{value}{Numeric. Units of foreign currency per euro.}
#' }
#'
#' @family exchange rates
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_exchange_rate("USD", from = "2024-01")
#' ecb_exchange_rate(c("USD", "GBP", "JPY"), from = "2024-01")
#' options(op)
#' }
ecb_exchange_rate <- function(currency = "USD",
                              frequency = c("monthly", "daily"),
                              from = NULL, to = NULL, cache = TRUE) {
  frequency <- match.arg(frequency)

  currency <- toupper(currency)
  valid_codes <- list_exchange_rates()$code
  bad <- setdiff(currency, valid_codes)
  if (length(bad) > 0L) {
    cli::cli_abort(c(
      "{.val {bad}} {?is/are} not valid ECB exchange rate currency code{?s}.",
      "i" = "Run {.fn list_exchange_rates} to see available currencies."
    ))
  }

  freq_code <- if (frequency == "monthly") "M" else "D"
  currency_key <- paste(currency, collapse = "+")

  cli::cli_progress_step("Fetching ECB exchange rates")
  key <- paste0(freq_code, ".", currency_key, ".EUR.SP00.A")
  df <- ecb_fetch("EXR", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  out <- data.frame(
    date     = parse_ecb_date(df$TIME_PERIOD),
    currency = df$CURRENCY,
    value    = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$currency, out$date), ]
  rownames(out) <- NULL

  out
}
