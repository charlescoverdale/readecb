#' Clear the readecb cache
#'
#' Deletes all locally cached ECB data files. The next call to any data
#' function will re-download from the ECB Data Portal.
#'
#' @return Invisible `NULL`.
#'
#' @export
#' @examples
#' \donttest{
#' clear_cache()
#' }
clear_cache <- function() {
  cache_dir <- tools::R_user_dir("readecb", "cache")
  if (dir.exists(cache_dir)) {
    unlink(cache_dir, recursive = TRUE)
    cli::cli_alert_success("Cache cleared.")
  } else {
    cli::cli_alert_info("No cache to clear.")
  }
  invisible(NULL)
}
