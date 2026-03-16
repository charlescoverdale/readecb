#' Harmonised Index of Consumer Prices (HICP)
#'
#' Returns HICP inflation data for one or more euro area countries or country
#' groups. The default is the euro area aggregate (`"U2"`).
#'
#' @param country Character vector of country codes. Use `"U2"` for the euro
#'   area aggregate, or ISO 2-letter codes such as `"DE"` (Germany), `"FR"`
#'   (France), `"IT"` (Italy), `"ES"` (Spain).
#' @param measure One of:
#'   * `"annual_rate"` (default) -- year-on-year percentage change
#'   * `"index"` -- index level (2015 = 100)
#'   * `"monthly_rate"` -- month-on-month percentage change
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{country}{Character. Country or area code.}
#'   \item{value}{Numeric. Inflation rate or index level.}
#' }
#'
#' @family prices
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_hicp(from = "2020-01")
#' ecb_hicp(c("DE", "FR", "IT"), from = "2023-01")
#' options(op)
#' }
ecb_hicp <- function(country = "U2",
                     measure = c("annual_rate", "index", "monthly_rate"),
                     from = NULL, to = NULL, cache = TRUE) {
  measure <- match.arg(measure)
  suffix <- switch(measure,
    annual_rate  = "ANR",
    index        = "INX",
    monthly_rate = "MRN"
  )

  country_key <- paste(country, collapse = "+")

  cli::cli_progress_step("Fetching HICP data")
  key <- paste0("M.", country_key, ".N.000000.4.", suffix)
  df <- ecb_fetch("ICP", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  out <- data.frame(
    date    = parse_ecb_date(df$TIME_PERIOD),
    country = df$REF_AREA,
    value   = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$country, out$date), ]
  rownames(out) <- NULL
  out
}
