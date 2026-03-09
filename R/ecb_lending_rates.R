#' Lending interest rates to non-financial corporations
#'
#' Returns the composite cost-of-borrowing indicator for loans to
#' non-financial corporations in the euro area or a specific country.
#'
#' @param country Character. Country code: `"U2"` for the euro area aggregate
#'   (default), or an ISO 2-letter code such as `"DE"`, `"FR"`, `"IT"`,
#'   `"ES"`.
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{country}{Character. Country or area code.}
#'   \item{value}{Numeric. Interest rate in percent per annum.}
#' }
#'
#' @export
#' @examples
#' \donttest{
#' ecb_lending_rates(from = "2015-01")
#' }
ecb_lending_rates <- function(country = "U2", from = NULL, to = NULL,
                              cache = TRUE) {
  cli::cli_progress_step("Fetching lending rate data")
  key <- paste0("M.", country, ".B.A2B.F.R.A.2250.EUR.N")
  df <- ecb_fetch("MIR", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  out <- data.frame(
    date    = parse_ecb_date(df$TIME_PERIOD),
    country = df$REF_AREA,
    value   = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$date), ]
  rownames(out) <- NULL
  out
}
