#' Fetch any ECB dataflow
#'
#' A generic fetcher for direct access to any of the ECB's dataflows. Use
#' [list_ecb_dataflows()] to discover available dataflows.
#'
#' @param dataflow Character. The dataflow identifier (e.g. `"EXR"`, `"FM"`).
#' @param key Character. The SDMX dimension key (e.g.
#'   `"M.USD.EUR.SP00.A"`).
#' @param from Optional start date.
#' @param to Optional end date.
#' @param cache Logical. Use cached data if available (default `TRUE`).
#'
#' @return A data frame. Columns vary by dataflow but always include
#'   `TIME_PERIOD` and `OBS_VALUE`.
#'
#' @family data access
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' # Fetch EUR/USD monthly exchange rate
#' ecb_get("EXR", "M.USD.EUR.SP00.A", from = "2024-01")
#' options(op)
#' }
ecb_get <- function(dataflow, key, from = NULL, to = NULL, cache = TRUE) {
  cli::cli_progress_step("Fetching {dataflow} data")
  df <- ecb_fetch(dataflow, key, from = from, to = to, cache = cache)
  cli::cli_progress_done()

  df$TIME_PERIOD <- parse_ecb_date(df$TIME_PERIOD)
  df$OBS_VALUE   <- as.numeric(df$OBS_VALUE)
  df
}
