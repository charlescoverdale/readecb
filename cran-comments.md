# CRAN submission comments — readecb 0.1.2

## Resubmission

This is a resubmission addressing CRAN review feedback (Konstanze Lauseker).
Changes since readecb 0.1.0:

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(readecb.cache_dir = ...)`.
* Removed non-existent pkgdown URL from DESCRIPTION (was returning 404).

## R CMD check results

0 errors | 0 warnings | 0 notes

## Test suite

42 tests across 16 test files. All network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

This package downloads data from the ECB Data Portal API
<https://data.ecb.europa.eu> on first use and caches it locally using
`tools::R_user_dir()`. No data is bundled. All examples that make network
calls are wrapped in `\donttest{}`, with caching redirected to `tempdir()`
so that no files are written to the user's home filespace.

## Relationship to existing 'ecb' package

This package provides a different interface to the same data source. The
existing 'ecb' package is a low-level SDMX wrapper requiring users to supply
raw series keys. 'readecb' provides named convenience functions (e.g.
`ecb_policy_rates()`, `ecb_hicp()`), uses CSV rather than XML, has a lighter
dependency stack (httr2 + cli vs httr + rsdmx + xml2 + curl), and caches
results locally.

## Downstream dependencies

None — this is a new package.
