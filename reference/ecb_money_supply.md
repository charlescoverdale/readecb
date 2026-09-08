# Euro area monetary aggregates

Returns outstanding amounts for M1, M2, or M3 monetary aggregates in the
euro area.

## Usage

``` r
ecb_money_supply(
  aggregate = c("M3", "M2", "M1"),
  from = NULL,
  to = NULL,
  cache = TRUE
)
```

## Arguments

- aggregate:

  One of `"M3"` (default), `"M2"`, or `"M1"`.

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

- value:

  Numeric. Outstanding amount in millions of euros.

## See also

Other credit:
[`ecb_lending_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_lending_rates.md),
[`ecb_mortgage_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_mortgage_rates.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_money_supply("M3", from = "2020-01")
})
#> ℹ Fetching M3 data
#> ✖ Fetching M3 data [30.1s]
#> 
#> Error in ecb_fetch("BSI", key, from = from, to = to, cache = cache) : 
#>   The ECB Data Portal returned a web page rather than data (HTTP 504).
#> ℹ This usually means the service is temporarily unavailable or under
#>   maintenance, rather than that the query is wrong.
#> ℹ Dataflow "BSI", key "M.U2.N.V.M30.X.1.U2.2300.Z01.E".
options(op)
# }
```
