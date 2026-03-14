#' ECB policy interest rates
#'
#' Returns the three main ECB policy rates: the main refinancing operations
#' rate, the deposit facility rate, and the marginal lending facility rate.
#'
#' @param from Optional start date (e.g. `"2020"` or `"2020-01"`).
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{rate}{Character. One of `"Main refinancing rate"`,
#'     `"Deposit facility rate"`, or `"Marginal lending rate"`.}
#'   \item{value}{Numeric. Rate in percent per annum.}
#' }
#'
#' @family interest rates
#' @export
#' @examples
#' \donttest{
#' ecb_policy_rates(from = "2022-01")
#' }
ecb_policy_rates <- function(from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching ECB policy rates")
  df <- ecb_fetch(
    "FM", "D.U2.EUR.4F.KR.MRR_RT+DFR+MLFR.LEV",
    from = from, to = to, cache = cache
  )
  cli::cli_progress_done()

  rate_labels <- c(
    MRR_RT = "Main refinancing rate",
    DFR    = "Deposit facility rate",
    MLFR   = "Marginal lending rate"
  )

  out <- data.frame(
    date  = parse_ecb_date(df$TIME_PERIOD),
    rate  = unname(rate_labels[df$PROVIDER_FM_ID]),
    value = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$date, out$rate), ]
  rownames(out) <- NULL
  out
}
