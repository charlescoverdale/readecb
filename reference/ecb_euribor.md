# EURIBOR interbank lending rates

Returns EURIBOR (Euro Interbank Offered Rate) at one or more tenors.
EURIBOR is the benchmark rate at which euro area banks lend to each
other, widely used as a reference rate for mortgages, loans, and
derivatives.

## Usage

``` r
ecb_euribor(tenor = "3M", from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- tenor:

  One or more of `"1M"` (1 month), `"3M"` (default), `"6M"`, or `"12M"`.

- from:

  Optional start date.

- to:

  Optional end date.

- cache:

  Logical. Use cached data if available (default `TRUE`).

## Value

A data frame with columns:

- date:

  Date.

- tenor:

  Character. EURIBOR maturity.

- value:

  Numeric. Rate in percent per annum.

## See also

Other interest rates:
[`ecb_estr()`](https://charlescoverdale.github.io/readecb/reference/ecb_estr.md),
[`ecb_policy_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_policy_rates.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_euribor("3M", from = "2022-01")
  ecb_euribor(c("1M", "3M", "6M", "12M"), from = "2024-01")
})
#> ℹ Fetching EURIBOR data
#> ✖ Fetching EURIBOR data [30.2s]
#> 
#> Error in ecb_fetch("FM", key, from = from, to = to, cache = cache) : 
#>   The ECB Data Portal returned a web page rather than data (HTTP 504).
#> ℹ This usually means the service is temporarily unavailable or under
#>   maintenance, rather than that the query is wrong.
#> ℹ Dataflow "FM", key "M.U2.EUR.RT.MM.EURIBOR3MD_.HSTA".
options(op)
# }
```
