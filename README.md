# readecb

[![CRAN status](https://www.r-pkg.org/badges/version/readecb)](https://cran.r-project.org/package=readecb) [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) [![R-CMD-check](https://github.com/charlescoverdale/readecb/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/charlescoverdale/readecb/actions/workflows/R-CMD-check.yaml)

An R package for accessing data published by the [European Central Bank](https://www.ecb.europa.eu/) (ECB) via the [ECB Data Portal API](https://data.ecb.europa.eu).

## What is the ECB?

The European Central Bank is the central bank for the euro area. It sets monetary policy for the 20 countries that use the euro — most importantly, the key interest rates that determine the cost of borrowing across the eurozone. It also publishes a vast quantity of statistical data covering exchange rates, inflation, money supply, lending conditions, and government bond yields.

All of this data is freely available through the ECB's Statistical Data Warehouse. The problem is that accessing it programmatically requires knowledge of SDMX series keys — opaque strings like `FM/D.U2.EUR.4F.KR.MRR_RT.LEV` that encode dataflow, frequency, area, currency, and instrument dimensions. This package abstracts that away entirely.

---

## How is this different from the `ecb` package?

The existing [`ecb`](https://cran.r-project.org/package=ecb) package provides a general-purpose interface to the same ECB data, and works well if you already know the SDMX series key you need. `readecb` complements it by providing named convenience functions for the most commonly used datasets — so you can call `ecb_policy_rates()` or `ecb_hicp()` without needing to look up key structures. It also caches results locally and uses a lightweight dependency stack (httr2 + cli).

---

## Functions

### Interest rates

| Function | Returns |
|---|---|
| `ecb_policy_rates()` | Main refinancing rate, deposit facility rate, and marginal lending rate (daily) |
| `ecb_estr()` | Euro short-term rate — the ECB's benchmark overnight rate that replaced EONIA (daily) |
| `ecb_mortgage_rates(country)` | Composite cost of borrowing for house purchase loans (monthly) |
| `ecb_lending_rates(country)` | Composite cost of borrowing for loans to non-financial corporations (monthly) |

### Prices and exchange rates

| Function | Returns |
|---|---|
| `ecb_hicp(country, measure)` | Harmonised Index of Consumer Prices — annual rate, index level, or monthly rate |
| `ecb_exchange_rate(currency, frequency)` | ECB reference exchange rates against the euro (monthly or daily) |
| `list_exchange_rates()` | Available currency codes (no download needed) |

### Financial markets

| Function | Returns |
|---|---|
| `ecb_yield_curve(tenor)` | AAA-rated euro area government bond yields by maturity (daily) |
| `ecb_money_supply(aggregate)` | M1, M2, or M3 monetary aggregates in EUR millions (monthly) |

### Generic access

| Function | Returns |
|---|---|
| `ecb_get(dataflow, key)` | Any ECB dataflow — for power users who know the series key |
| `list_ecb_dataflows()` | All available dataflows (~100) |

### Cache management

| Function | What it does |
|---|---|
| `clear_cache()` | Deletes all locally cached ECB files |

All download functions accept `from` and `to` date parameters and `cache = TRUE` by default.

---

## Examples

### 1. What has the ECB done to interest rates since the inflation shock?

```r
library(readecb)

rates <- ecb_policy_rates(from = "2022-01")
rates[rates$rate == "Deposit facility rate" & format(rates$date, "%d") == "01", ]
#>          date                    rate value
#>    2022-07-27  Deposit facility rate  0.00
#>    2022-09-14  Deposit facility rate  0.75
#>    2022-11-02  Deposit facility rate  1.50
#>    2023-02-08  Deposit facility rate  2.50
#>    2023-05-10  Deposit facility rate  3.25
#>    2023-06-21  Deposit facility rate  3.50
#>    2023-08-02  Deposit facility rate  3.75
#>    2023-09-20  Deposit facility rate  4.00
#>    2024-06-12  Deposit facility rate  3.75
#>    ...
```

The ECB raised rates from 0% to 4% in just over a year — the fastest tightening cycle in its history.

---

### 2. How has the euro moved against the dollar?

```r
fx <- ecb_exchange_rate("USD", from = "2020-01")
head(fx)
#>         date currency    value
#>   2020-01-01      USD 1.121500
#>   2020-02-01      USD 1.091400
#>   ...

# Compare multiple currencies
fx_multi <- ecb_exchange_rate(c("USD", "GBP", "JPY"), from = "2024-01")
```

---

### 3. Is eurozone inflation back to 2%?

```r
hicp <- ecb_hicp(from = "2020-01")
tail(hicp, 6)
#>         date country value
#>   2025-07-01      U2   2.2
#>   2025-08-01      U2   2.2
#>   ...

# Compare across countries
hicp_countries <- ecb_hicp(c("DE", "FR", "IT", "ES"), from = "2023-01")
```

---

### 4. What are eurozone mortgage rates?

```r
mortgages <- ecb_mortgage_rates(from = "2010-01")
tail(mortgages, 6)
#>         date country value
#>   ...

# Mortgage rates roughly doubled between 2022 and 2024 as the ECB raised
# policy rates, squeezing household purchasing power across the euro area.
```

---

### 5. Is the yield curve inverted?

```r
yields <- ecb_yield_curve(c("2Y", "10Y"), from = "2022-01")

# Calculate the 2s10s spread
library(readecb)
y2  <- yields[yields$tenor == "2Y", c("date", "value")]
y10 <- yields[yields$tenor == "10Y", c("date", "value")]
spread <- merge(y2, y10, by = "date", suffixes = c("_2y", "_10y"))
spread$spread <- spread$value_10y - spread$value_2y
# Negative spread = inverted curve = recession signal
```

---

### 6. How fast is the money supply growing?

```r
m3 <- ecb_money_supply("M3", from = "2019-01")
head(m3)
#>         date       value
#>   2019-01-01  12785041.4
#>   ...

# M3 surged during the pandemic as the ECB expanded its balance sheet,
# then growth slowed sharply as quantitative tightening began.
```

---

### 7. Access any ECB dataset directly

```r
# If you know the SDMX key, use ecb_get() for any dataflow
df <- ecb_get("EXR", "M.USD.EUR.SP00.A", from = "2024-01")

# Discover available dataflows
flows <- list_ecb_dataflows()
head(flows)
```

---

## Caching

Data is cached locally in `tools::R_user_dir("readecb", "cache")` on first download. Subsequent calls with the same parameters return instantly from the cache.

To force a fresh download, pass `cache = FALSE`. To clear the entire cache, call `clear_cache()`.

---

## Installation

```r
# Install from CRAN (when available)
install.packages("readecb")

# Or install the development version from GitHub
# install.packages("pak")
pak::pak("charlescoverdale/readecb")
```

---

## Related packages

This package is part of a family of R packages for economic and fiscal data. They share a consistent interface — named functions, tidy data frames, local caching — and are designed to work together.

| Package | What it covers |
|---|---|
| [`ons`](https://github.com/charlescoverdale/ons) | ONS data (GDP, inflation, unemployment, wages, trade, house prices, population) |
| [`boe`](https://github.com/charlescoverdale/boe) | Bank of England data (Bank Rate, SONIA, gilt yields, exchange rates, mortgage rates) |
| [`hmrc`](https://github.com/charlescoverdale/hmrc) | HMRC tax receipts, corporation tax, stamp duty, R&D credits, and tax gap data |
| [`obr`](https://github.com/charlescoverdale/obr) | OBR data (Public Finances Databank, forecasts, EFO, welfare trends, fiscal sustainability) |
| [`inflateR`](https://github.com/charlescoverdale/inflateR) | Adjust values for inflation using CPI or GDP deflator data |

---

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/readecb/issues>.
