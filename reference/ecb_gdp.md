# Euro area GDP

Returns quarterly real GDP for the euro area from the ECB's national
accounts dataset (MNA).

## Usage

``` r
ecb_gdp(from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- from:

  Optional start date.

- to:

  Optional end date.

- cache:

  Logical. Use cached data if available (default `TRUE`).

## Value

A data frame with columns:

- date:

  Date. First day of the quarter.

- value:

  Numeric. GDP in millions of euros (chain-linked volumes).

## See also

Other macro:
[`ecb_government_debt()`](https://charlescoverdale.github.io/readecb/reference/ecb_government_debt.md),
[`ecb_unemployment()`](https://charlescoverdale.github.io/readecb/reference/ecb_unemployment.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
ecb_gdp(from = "2020")
#> ℹ Fetching euro area GDP
#> ✔ Fetching euro area GDP [2.7s]
#> 
#>          date   value
#> 1  2020-01-01 2995346
#> 2  2020-04-01 2662313
#> 3  2020-07-01 2969660
#> 4  2020-10-01 2980601
#> 5  2021-01-01 3004297
#> 6  2021-04-01 3069207
#> 7  2021-07-01 3123112
#> 8  2021-10-01 3148326
#> 9  2022-01-01 3171886
#> 10 2022-04-01 3201158
#> 11 2022-07-01 3215700
#> 12 2022-10-01 3213847
#> 13 2023-01-01 3213042
#> 14 2023-04-01 3218853
#> 15 2023-07-01 3218696
#> 16 2023-10-01 3221111
#> 17 2024-01-01 3230449
#> 18 2024-04-01 3236907
#> 19 2024-07-01 3251260
#> 20 2024-10-01 3263759
#> 21 2025-01-01 3283121
#> 22 2025-04-01 3287844
#> 23 2025-07-01 3297684
#> 24 2025-10-01 3304260
options(op)
# }
```
