# readecb 0.1.4

## A rate-limited or unavailable portal no longer reports as a bad query

`ecb_fetch()` aborted with "Invalid query. Check the dataflow and key"
whenever the response body was HTML. That was never the right diagnosis: an
unknown dataflow or series key returns HTTP 404 with
`application/problem+json`, which is handled separately. HTML means the
request never reached the data service at all, which in practice is the
portal's rate limiter, a gateway timeout, or maintenance.

The effect was that a user whose key was perfectly correct got told to go
and check it. The message now distinguishes rate limiting (HTTP 400 with an
HTML body, which is how the portal signals it) from a service that is
temporarily unavailable, and says in both cases that the key is probably
fine.

## Transient server errors are retried

`is_transient` only recognised the rate-limit signal. Supplying it replaced
httr2's default, which silently stopped 429 and 5xx from being retried at
all, so a gateway timeout failed on first sight. Those are now retried, and
the total retry wait is capped with `max_seconds` so a refused host costs
seconds rather than half a minute.

## Tests skip rather than fail when the portal is down

The ECB Data Portal intermittently returns 504s, taking about 30 seconds to
do so. The network tests now skip on exactly the conditions the package
classifies as transient, via a new `expect_ecb()` helper. A real bug still
fails: this only skips server-side conditions, so the suite stays a useful
signal instead of going red whenever the upstream service has a wobble.

# readecb 0.1.3

## Examples now fail gracefully when the ECB Data Portal is unreachable

Every `\donttest{}` example that reaches the ECB Data Portal is wrapped in `try()`.
14 blocks were affected. CRAN runs these in its additional-issues
donttest check, on build machines the upstream host routinely refuses or
rate-limits, and an example that could not reach it was an ERROR rather
than a printed condition. The `options(op)` cache restore stays outside the
`try()` so it runs either way.

This is the CRAN Repository Policy requirement that a package using an
internet resource fail gracefully when the resource is unavailable. It is
the rule obr was archived under on 2026-08-22.

* `ecb_fetch()` now checks for empty API responses and throws an informative
  error instead of returning a malformed data frame.
* `ecb_exchange_rate()` now validates currency codes upfront, with a helpful
  error pointing to `list_exchange_rates()`.
* `ecb_hicp()` now validates the `country` argument is a non-empty character
  vector.

# readecb 0.1.2

* Removed non-existent pkgdown URL from DESCRIPTION.

# readecb 0.1.1

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(readecb.cache_dir = ...)`.

# readecb 0.1.0

* Initial release.
* `ecb_policy_rates()`, `ecb_estr()`, `ecb_mortgage_rates()`, `ecb_lending_rates()` for ECB interest rate data.
* `ecb_euribor()` for EURIBOR interbank lending rates at 1M, 3M, 6M, and 12M tenors.
* `ecb_hicp()` for harmonised consumer price inflation.
* `ecb_exchange_rate()` and `list_exchange_rates()` for euro reference exchange rates.
* `ecb_yield_curve()` for euro area government bond yields.
* `ecb_money_supply()` for M1, M2, M3 monetary aggregates.
* `ecb_gdp()` for quarterly euro area real GDP.
* `ecb_unemployment()` for the monthly euro area unemployment rate.
* `ecb_government_debt()` for the annual government debt-to-GDP ratio.
* `ecb_get()` and `list_ecb_dataflows()` for direct access to any ECB dataflow.
* `clear_cache()` to remove locally cached files.
* Data sourced from the ECB Data Portal API <https://data.ecb.europa.eu>.
