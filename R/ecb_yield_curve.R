#' Euro area government bond yield curve
#'
#' Returns AAA-rated euro area government bond yields for one or more tenors.
#'
#' @param tenor Character vector of tenors. Common values: `"3M"`, `"6M"`,
#'   `"1Y"`, `"2Y"`, `"3Y"`, `"5Y"`, `"7Y"`, `"10Y"`, `"15Y"`, `"20Y"`,
#'   `"30Y"`. Default is `"10Y"`.
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{tenor}{Character. Bond maturity.}
#'   \item{value}{Numeric. Yield in percent per annum.}
#' }
#'
#' @family data access
#' @export
#' @examples
#' \donttest{
#' ecb_yield_curve("10Y", from = "2023-01")
#' ecb_yield_curve(c("2Y", "10Y"), from = "2022-01")
#' }
ecb_yield_curve <- function(tenor = "10Y", from = NULL, to = NULL,
                            cache = TRUE) {
  tenor_key <- paste(paste0("SR_", tenor), collapse = "+")

  cli::cli_progress_step("Fetching yield curve data")
  key <- paste0("B.U2.EUR.4F.G_N_A.SV_C_YM.", tenor_key)
  df <- ecb_fetch("YC", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  # Extract tenor from the DATA_TYPE_FM column (e.g. "SR_10Y" -> "10Y")
  raw_tenor <- df$DATA_TYPE_FM
  tenor_clean <- sub("^SR_", "", raw_tenor)

  out <- data.frame(
    date  = parse_ecb_date(df$TIME_PERIOD),
    tenor = tenor_clean,
    value = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$tenor, out$date), ]
  rownames(out) <- NULL
  out
}
