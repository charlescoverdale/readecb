#' Harmonised Index of Consumer Prices (HICP)
#'
#' Returns HICP inflation data for one or more euro area countries or country
#' groups. The default is the euro area aggregate (`"U2"`, the euro area in
#' its changing composition: 21 members since Bulgaria joined on 1 January
#' 2026).
#'
#' Data come from the ECB's `HICP` dataflow, which replaced the `ICP`
#' dataflow when Eurostat moved the HICP to the ECOICOP 2 classification in
#' 2026. The `ICP` series stop at December 2025.
#'
#' @param country Character vector of country codes. Use `"U2"` for the euro
#'   area aggregate, or ISO 2-letter codes such as `"DE"` (Germany), `"FR"`
#'   (France), `"IT"` (Italy), `"ES"` (Spain).
#' @param measure One of:
#'   * `"annual_rate"` (default) -- year-on-year percentage change
#'   * `"index"` -- index level (2025 = 100)
#'   * `"monthly_rate"` -- month-on-month percentage change. The ECB does
#'     not publish this series, so it is computed from the index; the first
#'     month of the requested range is therefore dropped.
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
#' try({
#'   ecb_hicp(from = "2020-01")
#'   ecb_hicp(c("DE", "FR", "IT"), from = "2023-01")
#'   ecb_hicp(measure = "monthly_rate", from = "2025-01")
#' })
#' options(op)
#' }
ecb_hicp <- function(country = "U2",
                     measure = c("annual_rate", "index", "monthly_rate"),
                     from = NULL, to = NULL, cache = TRUE) {
  if (!is.character(country) || length(country) == 0L) {
    cli::cli_abort("{.arg country} must be a non-empty character vector.")
  }
  country <- toupper(country)

  measure <- match.arg(measure)
  suffix <- if (measure == "annual_rate") "ANR" else "INX"

  country_key <- paste(country, collapse = "+")

  cli::cli_progress_step("Fetching HICP data")
  key <- paste0("M.", country_key, ".N.000000.4D0.", suffix)
  df <- ecb_fetch("HICP", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  out <- data.frame(
    date    = parse_ecb_date(df$TIME_PERIOD),
    country = df$REF_AREA,
    value   = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$country, out$date), ]

  if (measure == "monthly_rate") {
    out <- hicp_monthly_rate(out)
  }

  rownames(out) <- NULL
  out
}

# Month-on-month percentage change of an index, within each country. A
# change is only computed between consecutive calendar months, so a gap in
# the index gives NA rather than a multi-month change.
#' @noRd
hicp_monthly_rate <- function(idx) {
  month_no <- function(d) {
    12L * as.integer(format(d, "%Y")) + as.integer(format(d, "%m"))
  }
  pieces <- lapply(split(idx, idx$country), function(d) {
    d <- d[order(d$date), , drop = FALSE]
    n <- nrow(d)
    if (n < 2L) return(d[0, , drop = FALSE])
    consecutive <- diff(month_no(d$date)) == 1L
    rate <- 100 * (d$value[-1] / d$value[-n] - 1)
    rate[!consecutive] <- NA_real_
    data.frame(date = d$date[-1], country = d$country[-1],
               value = round(rate, 1), stringsAsFactors = FALSE)
  })
  out <- do.call(rbind, pieces)
  out[order(out$country, out$date), , drop = FALSE]
}
