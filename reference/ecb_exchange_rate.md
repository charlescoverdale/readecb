# Euro exchange rates

Returns ECB reference exchange rates for one or more currencies against
the euro.

## Usage

``` r
ecb_exchange_rate(
  currency = "USD",
  frequency = c("monthly", "daily"),
  from = NULL,
  to = NULL,
  cache = TRUE
)
```

## Arguments

- currency:

  Character vector of ISO 4217 currency codes (e.g. `"USD"`, `"GBP"`).
  Use
  [`list_exchange_rates()`](https://charlescoverdale.github.io/readecb/reference/list_exchange_rates.md)
  to see available currencies.

- frequency:

  One of `"monthly"` (default) or `"daily"`.

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

- currency:

  Character. ISO currency code.

- value:

  Numeric. Units of foreign currency per euro.

## See also

Other exchange rates:
[`list_exchange_rates()`](https://charlescoverdale.github.io/readecb/reference/list_exchange_rates.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_exchange_rate("USD", from = "2024-01")
  ecb_exchange_rate(c("USD", "GBP", "JPY"), from = "2024-01")
})
#> ℹ Fetching ECB exchange rates
#> ✔ Fetching ECB exchange rates [417ms]
#> 
#> ℹ Fetching ECB exchange rates
#> ✔ Fetching ECB exchange rates [237ms]
#> 
#>          date currency       value
#> 1  2024-01-01      GBP   0.8587309
#> 2  2024-02-01      GBP   0.8546624
#> 3  2024-03-01      GBP   0.8552375
#> 4  2024-04-01      GBP   0.8565767
#> 5  2024-05-01      GBP   0.8556405
#> 6  2024-06-01      GBP   0.8464315
#> 7  2024-07-01      GBP   0.8433178
#> 8  2024-08-01      GBP   0.8515036
#> 9  2024-09-01      GBP   0.8402124
#> 10 2024-10-01      GBP   0.8349587
#> 11 2024-11-01      GBP   0.8337876
#> 12 2024-12-01      GBP   0.8280420
#> 13 2025-01-01      GBP   0.8390809
#> 14 2025-02-01      GBP   0.8307100
#> 15 2025-03-01      GBP   0.8370252
#> 16 2025-04-01      GBP   0.8537865
#> 17 2025-05-01      GBP   0.8434952
#> 18 2025-06-01      GBP   0.8498095
#> 19 2025-07-01      GBP   0.8646870
#> 20 2025-08-01      GBP   0.8652762
#> 21 2025-09-01      GBP   0.8689455
#> 22 2025-10-01      GBP   0.8715522
#> 23 2025-11-01      GBP   0.8799650
#> 24 2025-12-01      GBP   0.8750000
#> 25 2026-01-01      GBP   0.8682810
#> 26 2026-02-01      GBP   0.8703150
#> 27 2026-03-01      GBP   0.8663109
#> 28 2026-04-01      GBP   0.8693330
#> 29 2026-05-01      GBP   0.8656480
#> 30 2026-06-01      GBP   0.8637200
#> 31 2026-07-01      GBP   0.8539152
#> 32 2026-08-01      GBP   0.8560557
#> 33 2024-01-01      JPY 159.4581818
#> 34 2024-02-01      JPY 161.3771429
#> 35 2024-03-01      JPY 162.7725000
#> 36 2024-04-01      JPY 165.0295238
#> 37 2024-05-01      JPY 168.5363636
#> 38 2024-06-01      JPY 169.8130000
#> 39 2024-07-01      JPY 171.1708696
#> 40 2024-08-01      JPY 161.0554545
#> 41 2024-09-01      JPY 159.0809524
#> 42 2024-10-01      JPY 163.1969565
#> 43 2024-11-01      JPY 163.2338095
#> 44 2024-12-01      JPY 161.0835000
#> 45 2025-01-01      JPY 161.9213636
#> 46 2025-02-01      JPY 158.0870000
#> 47 2025-03-01      JPY 161.1666667
#> 48 2025-04-01      JPY 161.6705000
#> 49 2025-05-01      JPY 163.1442857
#> 50 2025-06-01      JPY 166.5233333
#> 51 2025-07-01      JPY 171.5313043
#> 52 2025-08-01      JPY 171.7895238
#> 53 2025-09-01      JPY 173.5486364
#> 54 2025-10-01      JPY 176.1526087
#> 55 2025-11-01      JPY 179.3160000
#> 56 2025-12-01      JPY 182.4971429
#> 57 2026-01-01      JPY 183.9385714
#> 58 2026-02-01      JPY 183.4515000
#> 59 2026-03-01      JPY 183.3990909
#> 60 2026-04-01      JPY 186.2060000
#> 61 2026-05-01      JPY 184.7095000
#> 62 2026-06-01      JPY 185.1140909
#> 63 2026-07-01      JPY 185.5391304
#> 64 2026-08-01      JPY 184.1019048
#> 65 2024-01-01      USD   1.0905136
#> 66 2024-02-01      USD   1.0794714
#> 67 2024-03-01      USD   1.0872200
#> 68 2024-04-01      USD   1.0727762
#> 69 2024-05-01      USD   1.0812227
#> 70 2024-06-01      USD   1.0759000
#> 71 2024-07-01      USD   1.0844087
#> 72 2024-08-01      USD   1.1012182
#> 73 2024-09-01      USD   1.1106000
#> 74 2024-10-01      USD   1.0904348
#> 75 2024-11-01      USD   1.0630143
#> 76 2024-12-01      USD   1.0478750
#> 77 2025-01-01      USD   1.0353727
#> 78 2025-02-01      USD   1.0412500
#> 79 2025-03-01      USD   1.0806810
#> 80 2025-04-01      USD   1.1213950
#> 81 2025-05-01      USD   1.1278048
#> 82 2025-06-01      USD   1.1516190
#> 83 2025-07-01      USD   1.1676870
#> 84 2025-08-01      USD   1.1631429
#> 85 2025-09-01      USD   1.1732227
#> 86 2025-10-01      USD   1.1630435
#> 87 2025-11-01      USD   1.1560200
#> 88 2025-12-01      USD   1.1708714
#> 89 2026-01-01      USD   1.1738238
#> 90 2026-02-01      USD   1.1823950
#> 91 2026-03-01      USD   1.1558318
#> 92 2026-04-01      USD   1.1706400
#> 93 2026-05-01      USD   1.1673200
#> 94 2026-06-01      USD   1.1518000
#> 95 2026-07-01      USD   1.1417478
#> 96 2026-08-01      USD   1.1593095
options(op)
# }
```
