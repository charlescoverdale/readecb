# CRAN submission comments — readecb 0.1.0

## R CMD check results

0 errors | 0 warnings | 0 notes

## Test suite

30 tests across 12 test files. All network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

This package downloads data from the ECB Data Portal API
<https://data.ecb.europa.eu> on first use and caches it locally using
`tools::R_user_dir()`. No data is bundled. All examples that make network
calls are wrapped in `\donttest{}`.

## Relationship to existing 'ecb' package

This package provides a different interface to the same data source. The
existing 'ecb' package is a low-level SDMX wrapper requiring users to supply
raw series keys. 'readecb' provides named convenience functions (e.g.
`ecb_policy_rates()`, `ecb_hicp()`), uses CSV rather than XML, has a lighter
dependency stack (httr2 + cli vs httr + rsdmx + xml2 + curl), and caches
results locally.

## Downstream dependencies

None — this is a new package.
