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

## Examples

``` r
# \donttest{
ecb_government_debt(from = "2000")
#> ℹ Fetching government debt-to-GDP ratio
#> ✔ Fetching government debt-to-GDP ratio [121ms]
#> 
#>          date  value
#> 1  2000-01-01 69.245
#> 2  2001-01-01 68.205
#> 3  2002-01-01 68.129
#> 4  2003-01-01 69.394
#> 5  2004-01-01 69.686
#> 6  2005-01-01 70.300
#> 7  2006-01-01 68.252
#> 8  2007-01-01 65.907
#> 9  2008-01-01 69.572
#> 10 2009-01-01 80.031
#> 11 2010-01-01 85.445
#> 12 2011-01-01 87.268
#> 13 2012-01-01 90.772
#> 14 2013-01-01 92.764
#> 15 2014-01-01 92.940
#> 16 2015-01-01 91.015
#> 17 2016-01-01 89.941
#> 18 2017-01-01 87.481
#> 19 2018-01-01 85.543
#> 20 2019-01-01 83.598
#> 21 2020-01-01 96.523
#> 22 2021-01-01 93.815
#> 23 2022-01-01 89.308
#> 24 2023-01-01 86.953
#> 25 2024-01-01 87.079
# }
```
