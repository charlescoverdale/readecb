# readecb 0.1.3

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
