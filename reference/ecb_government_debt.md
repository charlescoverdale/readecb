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
#> ✔ Fetching government debt-to-GDP ratio [320ms]
#> 
#>          date   value
#> 1  2000-01-01 69.2487
#> 2  2001-01-01 68.1974
#> 3  2002-01-01 68.0903
#> 4  2003-01-01 69.3323
#> 5  2004-01-01 69.6007
#> 6  2005-01-01 70.1783
#> 7  2006-01-01 68.1089
#> 8  2007-01-01 65.7387
#> 9  2008-01-01 69.3570
#> 10 2009-01-01 79.7681
#> 11 2010-01-01 85.1890
#> 12 2011-01-01 86.9837
#> 13 2012-01-01 90.4663
#> 14 2013-01-01 92.4443
#> 15 2014-01-01 92.6581
#> 16 2015-01-01 90.7027
#> 17 2016-01-01 89.6189
#> 18 2017-01-01 87.1238
#> 19 2018-01-01 85.1498
#> 20 2019-01-01 83.1637
#> 21 2020-01-01 95.9503
#> 22 2021-01-01 93.2209
#> 23 2022-01-01 88.7501
#> 24 2023-01-01 86.2977
#> 25 2024-01-01 86.1242
#> 26 2025-01-01 87.2649
options(op)
# }
```
