# Euro area government bond yield curve

Returns AAA-rated euro area government bond yields for one or more
tenors.

## Usage

``` r
ecb_yield_curve(tenor = "10Y", from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- tenor:

  Character vector of tenors. Common values: `"3M"`, `"6M"`, `"1Y"`,
  `"2Y"`, `"3Y"`, `"5Y"`, `"7Y"`, `"10Y"`, `"15Y"`, `"20Y"`, `"30Y"`.
  Default is `"10Y"`.

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

  Character. Bond maturity.

- value:

  Numeric. Yield in percent per annum.

## See also

Other data access:
[`clear_cache()`](https://charlescoverdale.github.io/readecb/reference/clear_cache.md),
[`ecb_get()`](https://charlescoverdale.github.io/readecb/reference/ecb_get.md),
[`list_ecb_dataflows()`](https://charlescoverdale.github.io/readecb/reference/list_ecb_dataflows.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_yield_curve("10Y", from = "2023-01")
  ecb_yield_curve(c("2Y", "10Y"), from = "2022-01")
})
#> ℹ Fetching yield curve data
#> ✖ Fetching yield curve data [30.1s]
#> 
#> Error in ecb_fetch("YC", key, from = from, to = to, cache = cache) : 
#>   The ECB Data Portal returned a web page rather than data (HTTP 504).
#> ℹ This usually means the service is temporarily unavailable or under
#>   maintenance, rather than that the query is wrong.
#> ℹ Dataflow "YC", key "B.U2.EUR.4F.G_N_A.SV_C_YM.SR_10Y".
options(op)
# }
```
