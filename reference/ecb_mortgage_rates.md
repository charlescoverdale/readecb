# Mortgage interest rates

Returns the composite cost-of-borrowing indicator for house purchase
loans in the euro area or a specific country.

## Usage

``` r
ecb_mortgage_rates(country = "U2", from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- country:

  Character. Country code: `"U2"` for the euro area aggregate (default),
  or an ISO 2-letter code such as `"DE"`, `"FR"`, `"IT"`, `"ES"`.

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

- country:

  Character. Country or area code.

- value:

  Numeric. Interest rate in percent per annum.

## See also

Other credit:
[`ecb_lending_rates()`](https://charlescoverdale.github.io/readecb/reference/ecb_lending_rates.md),
[`ecb_money_supply()`](https://charlescoverdale.github.io/readecb/reference/ecb_money_supply.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_mortgage_rates(from = "2015-01")
})
#> ℹ Fetching mortgage rate data
#> ✖ Fetching mortgage rate data [30.1s]
#> 
#> Error in ecb_fetch("MIR", key, from = from, to = to, cache = cache) : 
#>   The ECB Data Portal returned a web page rather than data (HTTP 504).
#> ℹ This usually means the service is temporarily unavailable or under
#>   maintenance, rather than that the query is wrong.
#> ℹ Dataflow "MIR", key "M.U2.B.A2C.AM.R.A.2250.EUR.N".
options(op)
# }
```
