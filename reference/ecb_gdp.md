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

## Examples

``` r
# \donttest{
ecb_gdp(from = "2020")
#> ℹ Fetching euro area GDP
#> ✔ Fetching euro area GDP [120ms]
#> 
#>          date   value
#> 1  2020-01-01 2995342
#> 2  2020-04-01 2662314
#> 3  2020-07-01 2969661
#> 4  2020-10-01 2980603
#> 5  2021-01-01 3004292
#> 6  2021-04-01 3069219
#> 7  2021-07-01 3123112
#> 8  2021-10-01 3148318
#> 9  2022-01-01 3171779
#> 10 2022-04-01 3201012
#> 11 2022-07-01 3215575
#> 12 2022-10-01 3213768
#> 13 2023-01-01 3213034
#> 14 2023-04-01 3218927
#> 15 2023-07-01 3218830
#> 16 2023-10-01 3221248
#> 17 2024-01-01 3230466
#> 18 2024-04-01 3236980
#> 19 2024-07-01 3251313
#> 20 2024-10-01 3263878
#> 21 2025-01-01 3283230
#> 22 2025-04-01 3287888
#> 23 2025-07-01 3297741
#> 24 2025-10-01 3304191
# }
```
