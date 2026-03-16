#' Euro short-term rate (ESTR)
#'
#' Returns the euro short-term rate, the ECB's benchmark overnight interest
#' rate that replaced EONIA.
#'
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{value}{Numeric. Rate in percent.}
#' }
#'
#' @family interest rates
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_estr(from = "2024-01")
#' options(op)
#' }
ecb_estr <- function(from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching ESTR data")
  df <- ecb_fetch(
    "EST", "B.EU000A2X2A25.WT",
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
