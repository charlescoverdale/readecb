# CRAN submission comments — readecb 0.1.3

## Reason for this submission

This is a maintenance update to readecb 0.1.2, currently on CRAN. It
improves error handling in three places where a malformed or empty
response produced a confusing downstream failure rather than a clear
message.

* `ecb_fetch()` now detects an empty API response and raises an
  informative error, instead of returning a malformed data frame that
  failed later and further from the cause.
* `ecb_exchange_rate()` validates currency codes upfront, with an error
  pointing at `list_exchange_rates()`.
* `ecb_hicp()` validates that `country` is a non-empty character vector.

No API changes, no changes to returned data for well-formed calls.

## R CMD check results

0 errors | 0 warnings | 0 notes (CRAN default settings, R 4.5.2, macOS).

## Notes on data access

Unchanged: the package calls the ECB Data Portal on demand and caches
locally using `tools::R_user_dir()`. No data is bundled. Network-using
examples are wrapped in `\donttest{}` and tests in `skip_on_cran()`, so
the check does not depend on the portal being reachable.

## Downstream dependencies

None on CRAN.
