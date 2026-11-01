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
try({
  ecb_gdp(from = "2020")
})
#> ℹ Fetching euro area GDP
#> ✔ Fetching euro area GDP [179ms]
#> 
#>          date   value
#> 1  2020-01-01 3018728
#> 2  2020-04-01 2681997
#> 3  2020-07-01 2991407
#> 4  2020-10-01 3000856
#> 5  2021-01-01 3027104
#> 6  2021-04-01 3091528
#> 7  2021-07-01 3150113
#> 8  2021-10-01 3172489
#> 9  2022-01-01 3196161
#> 10 2022-04-01 3226221
#> 11 2022-07-01 3243699
#> 12 2022-10-01 3241675
#> 13 2023-01-01 3235520
#> 14 2023-04-01 3242398
#> 15 2023-07-01 3249132
#> 16 2023-10-01 3250962
#> 17 2024-01-01 3266318
#> 18 2024-04-01 3274490
#> 19 2024-07-01 3292707
#> 20 2024-10-01 3302555
#> 21 2025-01-01 3318714
#> 22 2025-04-01 3319586
#> 23 2025-07-01 3330128
#> 24 2025-10-01 3337914
#> 25 2026-01-01 3337959
#> 26 2026-04-01 3359489
#> 27 2026-07-01 3373440
options(op)
# }
```
