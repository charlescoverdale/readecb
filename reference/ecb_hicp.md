# Harmonised Index of Consumer Prices (HICP)

Returns HICP inflation data for one or more euro area countries or
country groups. The default is the euro area aggregate (`"U2"`, the euro
area in its changing composition: 21 members since Bulgaria joined on 1
January 2026).

## Usage

``` r
ecb_hicp(
  country = "U2",
  measure = c("annual_rate", "index", "monthly_rate"),
  from = NULL,
  to = NULL,
  cache = TRUE
)
```

## Arguments

- country:

  Character vector of country codes. Use `"U2"` for the euro area
  aggregate, or ISO 2-letter codes such as `"DE"` (Germany), `"FR"`
  (France), `"IT"` (Italy), `"ES"` (Spain).

- measure:

  One of:

  - `"annual_rate"` (default) – year-on-year percentage change

  - `"index"` – index level (2025 = 100)

  - `"monthly_rate"` – month-on-month percentage change. The ECB does
    not publish this series, so it is computed from the index; the first
    month of the requested range is therefore dropped.

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

- country:

  Character. Country or area code.

- value:

  Numeric. Inflation rate or index level.

## Details

Data come from the ECB's `HICP` dataflow, which replaced the `ICP`
dataflow when Eurostat moved the HICP to the ECOICOP 2 classification in
2026. The `ICP` series stop at December 2025.

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  ecb_hicp(from = "2020-01")
  ecb_hicp(c("DE", "FR", "IT"), from = "2023-01")
  ecb_hicp(measure = "monthly_rate", from = "2025-01")
})
#> ℹ Fetching HICP data
#> ✔ Fetching HICP data [161ms]
#> 
#> ℹ Fetching HICP data
#> ✔ Fetching HICP data [190ms]
#> 
#> ℹ Fetching HICP data
#> ✔ Fetching HICP data [174ms]
#> 
#>          date country value
#> 1  2025-02-01      U2   0.4
#> 2  2025-03-01      U2   0.6
#> 3  2025-04-01      U2   0.6
#> 4  2025-05-01      U2   0.0
#> 5  2025-06-01      U2   0.3
#> 6  2025-07-01      U2   0.0
#> 7  2025-08-01      U2   0.1
#> 8  2025-09-01      U2   0.1
#> 9  2025-10-01      U2   0.2
#> 10 2025-11-01      U2  -0.3
#> 11 2025-12-01      U2   0.2
#> 12 2026-01-01      U2  -0.6
#> 13 2026-02-01      U2   0.6
#> 14 2026-03-01      U2   1.3
#> 15 2026-04-01      U2   1.0
#> 16 2026-05-01      U2   0.1
#> 17 2026-06-01      U2  -0.1
#> 18 2026-07-01      U2   0.2
#> 19 2026-08-01      U2   0.4
#> 20 2026-09-01      U2   0.6
options(op)
# }
```
