#' Euro area monetary aggregates
#'
#' Returns outstanding amounts for M1, M2, or M3 monetary aggregates in the
#' euro area.
#'
#' @param aggregate One of `"M3"` (default), `"M2"`, or `"M1"`.
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{value}{Numeric. Outstanding amount in millions of euros.}
#' }
#'
#' @family credit
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' ecb_money_supply("M3", from = "2020-01")
#' options(op)
#' }
ecb_money_supply <- function(aggregate = c("M3", "M2", "M1"),
                             from = NULL, to = NULL, cache = TRUE) {
  aggregate <- match.arg(aggregate)
  item_code <- switch(aggregate, M1 = "M10", M2 = "M20", M3 = "M30")

  cli::cli_progress_step("Fetching {aggregate} data")
  key <- paste0("M.U2.N.V.", item_code, ".X.1.U2.2300.Z01.E")
  df <- ecb_fetch("BSI", key, from = from, to = to, cache = cache)
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
