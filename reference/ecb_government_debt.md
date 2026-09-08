# Euro area government debt-to-GDP ratio

Returns the annual general government consolidated gross debt as a
percentage of GDP for the euro area, from the ECB's government finance
statistics dataset (GFS).

## Usage

``` r
ecb_government_debt(from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- from:

  Optional start date (year, e.g. `"2000"`).

- to:

  Optional end date.

- cache:

  Logical. Use cached data if available (default `TRUE`).

## Value

A data frame with columns:

- date:

  Date. 1 January of each year.

- value:

  Numeric. Government debt as a percentage of GDP.

## See also

Other macro:
[`ecb_gdp()`](https://charlescoverdale.github.io/readecb/reference/ecb_gdp.md),
[`ecb_unemployment()`](https://charlescoverdale.github.io/readecb/reference/ecb_unemployment.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_government_debt(from = "2000")
})
#> ℹ Fetching government debt-to-GDP ratio
#> ✖ Fetching government debt-to-GDP ratio [30.1s]
#> 
#> Error in ecb_fetch("GFS", "A.N.I9.W0.S13.S1.C.L.LE.GD.T._Z.XDC_R_B1GQ._T.F.V.N._T",  : 
#>   The ECB Data Portal returned a web page rather than data (HTTP 504).
#> ℹ This usually means the service is temporarily unavailable or under
#>   maintenance, rather than that the query is wrong.
#> ℹ Dataflow "GFS", key "A.N.I9.W0.S13.S1.C.L.LE.GD.T._Z.XDC_R_B1GQ._T.F.V.N._T".
options(op)
# }
```
