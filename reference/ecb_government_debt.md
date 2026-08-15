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
ecb_government_debt(from = "2000")
#> ℹ Fetching government debt-to-GDP ratio
#> ✔ Fetching government debt-to-GDP ratio [295ms]
#> 
#>          date   value
#> 1  2000-01-01 69.2452
#> 2  2001-01-01 68.2047
#> 3  2002-01-01 68.1292
#> 4  2003-01-01 69.3940
#> 5  2004-01-01 69.6865
#> 6  2005-01-01 70.3002
#> 7  2006-01-01 68.2519
#> 8  2007-01-01 65.9070
#> 9  2008-01-01 69.5719
#> 10 2009-01-01 80.0309
#> 11 2010-01-01 85.4456
#> 12 2011-01-01 87.2681
#> 13 2012-01-01 90.7719
#> 14 2013-01-01 92.7642
#> 15 2014-01-01 92.9404
#> 16 2015-01-01 91.0153
#> 17 2016-01-01 89.9407
#> 18 2017-01-01 87.4810
#> 19 2018-01-01 85.5433
#> 20 2019-01-01 83.5975
#> 21 2020-01-01 96.5233
#> 22 2021-01-01 93.8152
#> 23 2022-01-01 89.3087
#> 24 2023-01-01 86.9154
#> 25 2024-01-01 86.9866
#> 26 2025-01-01 87.8062
options(op)
# }
```
