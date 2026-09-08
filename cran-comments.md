# CRAN submission comments: readecb 0.1.4

## Reason for this submission

An error-reporting fix for 0.1.3. No change to any returned value.

`ecb_fetch()` aborted with "Invalid query. Check the dataflow and key"
whenever the response body was HTML. That diagnosis was always wrong. An
unknown dataflow or key returns HTTP 404 with `application/problem+json`,
which is handled by a separate branch; an HTML body means the request never
reached the data service, which in practice is the portal's rate limiter, a
gateway timeout, or maintenance. Users with a correct key were being sent to
check it.

I verified this against the live portal: an invalid key and an invalid
dataflow both return 404 with `application/problem+json`, and a valid query
returns 200 with `text/csv`. HTML appears only for the throttle and gateway
cases.

## Also in this release

* `is_transient` recognised only the rate-limit signal. Supplying it
  replaced httr2's default, which had the side effect of never retrying 429
  or 5xx, so a gateway timeout failed immediately. Those are now retried,
  with the total retry wait capped by `max_seconds`.

* The network tests now skip, rather than fail, on the conditions the
  package classifies as transient. The portal has been returning
  intermittent 504s while preparing this release, and a suite that goes red
  on upstream flakiness hides the failures that matter. A genuine bug still
  fails.

## R CMD check results

0 errors | 0 warnings | 0 notes

Local check: macOS (aarch64), R 4.5.2, `devtools::check(cran = TRUE)`. The
run emits "checking for future file timestamps: unable to verify current
time", which is the checking machine being unable to reach worldclockapi.com
rather than a package fault.

## Downstream dependencies

None.
