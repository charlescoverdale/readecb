# readecb

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

An R package for accessing data published by the [European Central Bank](https://www.ecb.europa.eu/) (ECB) via the [ECB Data Portal API](https://data.ecb.europa.eu).

## What is the ECB?

The European Central Bank is the central bank for the euro area. It sets monetary policy for the 20 countries that use the euro — most importantly, the key interest rates that determine the cost of borrowing across the eurozone. It also publishes a vast quantity of statistical data covering exchange rates, inflation, money supply, lending conditions, and government bond yields.

All of this data is freely available through the ECB's Statistical Data Warehouse. The problem is that accessing it programmatically requires knowledge of SDMX series keys — opaque strings like `FM/D.U2.EUR.4F.KR.MRR_RT.LEV` that encode dataflow, frequency, area, currency, and instrument dimensions. This package abstracts that away entirely.

---

## How is readecb different from the `ecb` package?

The existing [`ecb`](https://cran.r-project.org/package=ecb) package provides a general-purpose interface to the same ECB data, and works well if you already know the SDMX series key you need. `readecb` complements it by providing named convenience functions for the most commonly used datasets — so you can call `ecb_policy_rates()` or `ecb_hicp()` without needing to look up key structures. It also caches results locally and uses a lightweight dependency stack (httr2 + cli).

---

## Installation

```r
# Install from CRAN (when available)
install.packages("readecb")

# Or install the development version from GitHub
devtools::install_github("charlescoverdale/readecb")
```

---

## Functions

### Interest rates

| Function | Returns |
|---|---|
| `ecb_policy_rates()` | Main refinancing rate, deposit facility rate, and marginal lending rate (daily) |
| `ecb_euribor(tenor)` | EURIBOR interbank lending rates at 1M, 3M, 6M, or 12M tenors (monthly) |
| `ecb_estr()` | Euro short-term rate — the ECB's benchmark overnight rate that replaced EONIA (daily) |
| `ecb_mortgage_rates(country)` | Composite cost of borrowing for house purchase loans (monthly) |
| `ecb_lending_rates(country)` | Composite cost of borrowing for loans to non-financial corporations (monthly) |

### Prices and exchange rates

| Function | Returns |
|---|---|
| `ecb_hicp(country, measure)` | Harmonised Index of Consumer Prices — annual rate, index level, or monthly rate |
| `ecb_exchange_rate(currency, frequency)` | ECB reference exchange rates against the euro (monthly or daily) |
| `list_exchange_rates()` | Available currency codes (no download needed) |

### Macro indicators

| Function | Returns |
|---|---|
| `ecb_gdp()` | Quarterly euro area real GDP in EUR millions (chain-linked volumes) |
| `ecb_unemployment()` | Monthly euro area harmonised unemployment rate (%) |
| `ecb_government_debt()` | Annual government debt-to-GDP ratio (%) |

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

# Returns daily data with one row per rate per day
rates <- ecb_policy_rates(from = "2022-01")
head(rates)
#>         date                     rate value
#>   2022-01-03  Deposit facility rate  -0.50
#>   2022-01-03  Main refinancing rate   0.00
#>   2022-01-03  Marginal lending rate   0.25
#>   2022-01-04  Deposit facility rate  -0.50
#>   2022-01-04  Main refinancing rate   0.00
#>   2022-01-04  Marginal lending rate   0.25
```

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
# Euro area aggregate (U2) by default
hicp <- ecb_hicp(from = "2020-01")
tail(hicp, 3)
#>         date country value
#>   2025-06-01      U2   2.0
#>   2025-07-01      U2   2.2
#>   2025-08-01      U2   2.2

# Compare across countries
hicp_countries <- ecb_hicp(c("DE", "FR", "IT", "ES"), from = "2024-01")
head(hicp_countries)
#>         date country value
#>   2024-01-01      DE   3.1
#>   2024-01-01      ES   3.5
#>   2024-01-01      FR   3.4
#>   2024-01-01      IT   0.9
#>   2024-02-01      DE   2.7
#>   2024-02-01      ES   2.9
```

---

### 4. What are eurozone mortgage rates?

```r
# Euro area aggregate by default
mortgages <- ecb_mortgage_rates(from = "2020-01")
head(mortgages)
#>         date country value
#>   2020-01-01      I9  1.41
#>   2020-02-01      I9  1.41
#>   2020-03-01      I9  1.39
#>   2020-04-01      I9  1.38
#>   2020-05-01      I9  1.36
#>   2020-06-01      I9  1.39

# Mortgage rates roughly doubled between 2022 and 2024 as the ECB raised
# policy rates, squeezing household purchasing power across the euro area.
```

---

### 5. Plot the euro area yield curve

```r
# Fetch yields across the full maturity spectrum
tenors <- c("3M", "1Y", "2Y", "5Y", "10Y", "20Y", "30Y")
yields <- ecb_yield_curve(tenors, from = "2025-03-01", to = "2025-03-01")

# Plot the yield curve
plot(seq_along(tenors), yields$value,
     type = "b", pch = 19, col = "#003299",
     xaxt = "n", xlab = "Maturity", ylab = "Yield (%)",
     main = "Euro Area AAA Government Bond Yield Curve")
axis(1, at = seq_along(tenors), labels = tenors)
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
