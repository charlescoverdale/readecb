#' Euro area GDP
#'
#' Returns quarterly real GDP for the euro area from the ECB's national
#' accounts dataset (MNA).
#'
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date. First day of the quarter.}
#'   \item{value}{Numeric. GDP in millions of euros (chain-linked volumes).}
#' }
#'
#' @family macro
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_gdp(from = "2020")
#' options(op)
#' }
ecb_gdp <- function(from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching euro area GDP")
  df <- ecb_fetch(
    "MNA", "Q.Y.I9.W2.S1.S1.B.B1GQ._Z._Z._Z.EUR.LR.N",
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
