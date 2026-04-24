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
ecb_exchange_rate("USD", from = "2024-01")
#> ℹ Fetching ECB exchange rates
#> ✔ Fetching ECB exchange rates [5.6s]
#> 
#>          date currency    value
#> 1  2024-01-01      USD 1.090514
#> 2  2024-02-01      USD 1.079471
#> 3  2024-03-01      USD 1.087220
#> 4  2024-04-01      USD 1.072776
#> 5  2024-05-01      USD 1.081223
#> 6  2024-06-01      USD 1.075900
#> 7  2024-07-01      USD 1.084409
#> 8  2024-08-01      USD 1.101218
#> 9  2024-09-01      USD 1.110600
#> 10 2024-10-01      USD 1.090435
#> 11 2024-11-01      USD 1.063014
#> 12 2024-12-01      USD 1.047875
#> 13 2025-01-01      USD 1.035373
#> 14 2025-02-01      USD 1.041250
#> 15 2025-03-01      USD 1.080681
#> 16 2025-04-01      USD 1.121395
#> 17 2025-05-01      USD 1.127805
#> 18 2025-06-01      USD 1.151619
#> 19 2025-07-01      USD 1.167687
#> 20 2025-08-01      USD 1.163143
#> 21 2025-09-01      USD 1.173223
#> 22 2025-10-01      USD 1.163043
#> 23 2025-11-01      USD 1.156020
#> 24 2025-12-01      USD 1.170871
#> 25 2026-01-01      USD 1.173824
#> 26 2026-02-01      USD 1.182395
#> 27 2026-03-01      USD 1.155832
ecb_exchange_rate(c("USD", "GBP", "JPY"), from = "2024-01")
#> ℹ Fetching ECB exchange rates
#> ✔ Fetching ECB exchange rates [3.1s]
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
#> 28 2024-01-01      JPY 159.4581818
#> 29 2024-02-01      JPY 161.3771429
#> 30 2024-03-01      JPY 162.7725000
#> 31 2024-04-01      JPY 165.0295238
#> 32 2024-05-01      JPY 168.5363636
#> 33 2024-06-01      JPY 169.8130000
#> 34 2024-07-01      JPY 171.1708696
#> 35 2024-08-01      JPY 161.0554545
#> 36 2024-09-01      JPY 159.0809524
#> 37 2024-10-01      JPY 163.1969565
#> 38 2024-11-01      JPY 163.2338095
#> 39 2024-12-01      JPY 161.0835000
#> 40 2025-01-01      JPY 161.9213636
#> 41 2025-02-01      JPY 158.0870000
#> 42 2025-03-01      JPY 161.1666667
#> 43 2025-04-01      JPY 161.6705000
#> 44 2025-05-01      JPY 163.1442857
#> 45 2025-06-01      JPY 166.5233333
#> 46 2025-07-01      JPY 171.5313043
#> 47 2025-08-01      JPY 171.7895238
#> 48 2025-09-01      JPY 173.5486364
#> 49 2025-10-01      JPY 176.1526087
#> 50 2025-11-01      JPY 179.3160000
#> 51 2025-12-01      JPY 182.4971429
#> 52 2026-01-01      JPY 183.9385714
#> 53 2026-02-01      JPY 183.4515000
#> 54 2026-03-01      JPY 183.3990909
#> 55 2024-01-01      USD   1.0905136
#> 56 2024-02-01      USD   1.0794714
#> 57 2024-03-01      USD   1.0872200
#> 58 2024-04-01      USD   1.0727762
#> 59 2024-05-01      USD   1.0812227
#> 60 2024-06-01      USD   1.0759000
#> 61 2024-07-01      USD   1.0844087
#> 62 2024-08-01      USD   1.1012182
#> 63 2024-09-01      USD   1.1106000
#> 64 2024-10-01      USD   1.0904348
#> 65 2024-11-01      USD   1.0630143
#> 66 2024-12-01      USD   1.0478750
#> 67 2025-01-01      USD   1.0353727
#> 68 2025-02-01      USD   1.0412500
#> 69 2025-03-01      USD   1.0806810
#> 70 2025-04-01      USD   1.1213950
#> 71 2025-05-01      USD   1.1278048
#> 72 2025-06-01      USD   1.1516190
#> 73 2025-07-01      USD   1.1676870
#> 74 2025-08-01      USD   1.1631429
#> 75 2025-09-01      USD   1.1732227
#> 76 2025-10-01      USD   1.1630435
#> 77 2025-11-01      USD   1.1560200
#> 78 2025-12-01      USD   1.1708714
#> 79 2026-01-01      USD   1.1738238
#> 80 2026-02-01      USD   1.1823950
#> 81 2026-03-01      USD   1.1558318
options(op)
# }
```
