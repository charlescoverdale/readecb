#' Euro area government debt-to-GDP ratio
#'
#' Returns the annual general government consolidated gross debt as a
#' percentage of GDP for the euro area, from the ECB's government finance
#' statistics dataset (GFS).
#'
#' @param from Optional start date (year, e.g. `"2000"`).
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date. 1 January of each year.}
#'   \item{value}{Numeric. Government debt as a percentage of GDP.}
#' }
#'
#' @family macro
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_government_debt(from = "2000")
#' options(op)
#' }
ecb_government_debt <- function(from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching government debt-to-GDP ratio")
  df <- ecb_fetch(
    "GFS", "A.N.I9.W0.S13.S1.C.L.LE.GD.T._Z.XDC_R_B1GQ._T.F.V.N._T",
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
