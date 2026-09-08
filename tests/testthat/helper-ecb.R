# Skip a test when the failure is the ECB Data Portal rather than the package.
#
# The portal intermittently returns HTTP 504 gateway timeouts, and takes about
# 30 seconds to do so. That is not a defect in readecb, and a test suite that
# goes red whenever the upstream service has a wobble stops being a useful
# signal: the failures that matter get lost among the ones that do not.
#
# A genuine bug still fails. This only skips on the specific server-side
# conditions the package already classifies as transient.
expect_ecb <- function(expr) {
  tryCatch(
    force(expr),
    error = function(e) {
      msg <- conditionMessage(e)
      transient <- grepl(
        "temporarily unavailable|under\\s+maintenance|rate-limiting|HTTP 5[0-9][0-9]|Failed to connect",
        msg
      )
      if (transient) {
        testthat::skip(paste("ECB Data Portal unavailable:", substr(msg, 1, 80)))
      }
      stop(e)
    }
  )
}
