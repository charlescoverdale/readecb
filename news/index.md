# Changelog

## readecb 0.1.3

- `ecb_fetch()` now checks for empty API responses and throws an
  informative error instead of returning a malformed data frame.
- [`ecb_exchange_rate()`](https://charlescoverdale.github.io/readecb/reference/ecb_exchange_rate.md)
  now validates currency codes upfront, with a helpful error pointing to
  [`list_exchange_rates()`](https://charlescoverdale.github.io/readecb/reference/list_exchange_rates.md).
- [`ecb_hicp()`](https://charlescoverdale.github.io/readecb/reference/ecb_hicp.md)
  now validates the `country` argument is a non-empty character vector.

## readecb 0.1.2

CRAN release: 2026-03-19

- Removed non-existent pkgdown URL from DESCRIPTION.

## readecb 0.1.1

- Examples now cache to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) instead of the
  user’s home directory, fixing CRAN policy compliance for `\donttest`
  examples.
- Cache directory is now configurable via
  `options(readecb.cache_dir = ...)`.

## readecb 0.1.0

- Initial release.
- [`ecb_policy_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_policy_rates.md),
  [`ecb_estr()`](https://charlescoverdale.github.io/readecb/reference/ecb_estr.md),
  [`ecb_mortgage_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_mortgage_rates.md),
  [`ecb_lending_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_lending_rates.md)
  for ECB interest rate data.
- [`ecb_euribor()`](https://charlescoverdale.github.io/readecb/reference/ecb_euribor.md)
  for EURIBOR interbank lending rates at 1M, 3M, 6M, and 12M tenors.
- [`ecb_hicp()`](https://charlescoverdale.github.io/readecb/reference/ecb_hicp.md)
  for harmonised consumer price inflation.
- [`ecb_exchange_rate()`](https://charlescoverdale.github.io/readecb/reference/ecb_exchange_rate.md)
  and
  [`list_exchange_rates()`](https://charlescoverdale.github.io/readecb/reference/list_exchange_rates.md)
  for euro reference exchange rates.
- [`ecb_yield_curve()`](https://charlescoverdale.github.io/readecb/reference/ecb_yield_curve.md)
  for euro area government bond yields.
- [`ecb_money_supply()`](https://charlescoverdale.github.io/readecb/reference/ecb_money_supply.md)
  for M1, M2, M3 monetary aggregates.
- [`ecb_gdp()`](https://charlescoverdale.github.io/readecb/reference/ecb_gdp.md)
  for quarterly euro area real GDP.
- [`ecb_unemployment()`](https://charlescoverdale.github.io/readecb/reference/ecb_unemployment.md)
  for the monthly euro area unemployment rate.
- [`ecb_government_debt()`](https://charlescoverdale.github.io/readecb/reference/ecb_government_debt.md)
  for the annual government debt-to-GDP ratio.
- [`ecb_get()`](https://charlescoverdale.github.io/readecb/reference/ecb_get.md)
  and
  [`list_ecb_dataflows()`](https://charlescoverdale.github.io/readecb/reference/list_ecb_dataflows.md)
  for direct access to any ECB dataflow.
- [`clear_cache()`](https://charlescoverdale.github.io/readecb/reference/clear_cache.md)
  to remove locally cached files.
- Data sourced from the ECB Data Portal API
  <https://data.ecb.europa.eu>.
