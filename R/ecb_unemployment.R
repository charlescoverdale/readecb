#' Euro area unemployment rate
#'
#' Returns the monthly harmonised unemployment rate for the euro area from the
#' ECB's labour force statistics dataset (LFSI).
#'
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{value}{Numeric. Unemployment rate as a percentage.}
#' }
#'
#' @export
#' @examples
#' \donttest{
#' ecb_unemployment(from = "2020-01")
#' }
ecb_unemployment <- function(from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching euro area unemployment rate")
  df <- ecb_fetch(
    "LFSI", "M.I9.S.UNEHRT.TOTAL0.15_74.T",
    from = from, to = to, cache = cache
  )
  cli::cli_progress_done()

  out <- data.frame(
    date  = parse_ecb_date(df$TIME_PERIOD),
    value = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$date), ]
  rownames(out) <- NULL
  out
}
