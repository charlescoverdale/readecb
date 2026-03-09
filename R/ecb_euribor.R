#' EURIBOR interbank lending rates
#'
#' Returns EURIBOR (Euro Interbank Offered Rate) at one or more tenors.
#' EURIBOR is the benchmark rate at which euro area banks lend to each other,
#' widely used as a reference rate for mortgages, loans, and derivatives.
#'
#' @param tenor One or more of `"1M"` (1 month), `"3M"` (default), `"6M"`,
#'   or `"12M"`.
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{date}{Date.}
#'   \item{tenor}{Character. EURIBOR maturity.}
#'   \item{value}{Numeric. Rate in percent per annum.}
#' }
#'
#' @export
#' @examples
#' \donttest{
#' ecb_euribor("3M", from = "2022-01")
#' ecb_euribor(c("1M", "3M", "6M", "12M"), from = "2024-01")
#' }
ecb_euribor <- function(tenor = "3M", from = NULL, to = NULL, cache = TRUE) {
  tenor_map <- c(
    "1M"  = "EURIBOR1MD_",
    "3M"  = "EURIBOR3MD_",
    "6M"  = "EURIBOR6MD_",
    "12M" = "EURIBOR1YD_"
  )

  valid <- names(tenor_map)
  bad <- setdiff(tenor, valid)
  if (length(bad) > 0) {
    cli::cli_abort(
      "Invalid tenor{?s}: {.val {bad}}. Must be one of {.val {valid}}."
    )
  }

  fm_ids <- unname(tenor_map[tenor])
  fm_key <- paste(fm_ids, collapse = "+")

  cli::cli_progress_step("Fetching EURIBOR data")
  key <- paste0("M.U2.EUR.RT.MM.", fm_key, ".HSTA")
  df <- ecb_fetch("FM", key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  # Reverse map PROVIDER_FM_ID back to tenor labels
  reverse_map <- stats::setNames(names(tenor_map), tenor_map)
  tenor_labels <- unname(reverse_map[df$PROVIDER_FM_ID])

  out <- data.frame(
    date  = parse_ecb_date(df$TIME_PERIOD),
    tenor = tenor_labels,
    value = as.numeric(df$OBS_VALUE),
    stringsAsFactors = FALSE
  )
  out <- out[order(out$tenor, out$date), ]
  rownames(out) <- NULL
  out
}
