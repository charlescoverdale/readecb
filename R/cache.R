#' Clear the readecb cache
#'
#' Deletes all locally cached ECB data files. The next call to any data
#' function will re-download from the ECB Data Portal.
#'
#' @return Invisible `NULL`.
#'
#' @family data access
#' @export
#' @examples
#' \donttest{
#' op <- options(readecb.cache_dir = tempdir())
#' clear_cache()
#' options(op)
#' }
clear_cache <- function() {
  cache_dir <- ecb_cache_dir()
  if (dir.exists(cache_dir)) {
    unlink(cache_dir, recursive = TRUE)
    cli::cli_alert_success("Cache cleared.")
  } else {
    cli::cli_alert_info("No cache to clear.")
  }
  invisible(NULL)
}
