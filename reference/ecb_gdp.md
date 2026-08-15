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
#> ✔ Fetching euro area GDP [265ms]
#> 
#>          date   value
#> 1  2020-01-01 2996366
#> 2  2020-04-01 2662371
#> 3  2020-07-01 2969541
#> 4  2020-10-01 2978874
#> 5  2021-01-01 3003980
#> 6  2021-04-01 3068812
#> 7  2021-07-01 3124570
#> 8  2021-10-01 3147599
#> 9  2022-01-01 3170557
#> 10 2022-04-01 3200731
#> 11 2022-07-01 3217798
#> 12 2022-10-01 3215698
#> 13 2023-01-01 3211546
#> 14 2023-04-01 3218435
#> 15 2023-07-01 3222771
#> 16 2023-10-01 3223109
#> 17 2024-01-01 3234142
#> 18 2024-04-01 3240995
#> 19 2024-07-01 3257252
#> 20 2024-10-01 3266893
#> 21 2025-01-01 3285475
#> 22 2025-04-01 3285055
#> 23 2025-07-01 3295317
#> 24 2025-10-01 3301714
#> 25 2026-01-01 3301539
options(op)
# }
```
