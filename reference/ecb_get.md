# Fetch any ECB dataflow

A generic fetcher for direct access to any of the ECB's dataflows. Use
[`list_ecb_dataflows()`](https://charlescoverdale.github.io/readecb/reference/list_ecb_dataflows.md)
to discover available dataflows.

## Usage

``` r
ecb_get(dataflow, key, from = NULL, to = NULL, cache = TRUE)
```

## Arguments

- dataflow:

  Character. The dataflow identifier (e.g. `"EXR"`, `"FM"`).

- key:

  Character. The SDMX dimension key (e.g. `"M.USD.EUR.SP00.A"`).

- from:

  Optional start date.

- to:

  Optional end date.

- cache:

  Logical. Use cached data if available (default `TRUE`).

## Value

A data frame. Columns vary by dataflow but always include `TIME_PERIOD`
and `OBS_VALUE`.

## Examples

``` r
# \donttest{
# Fetch EUR/USD monthly exchange rate
ecb_get("EXR", "M.USD.EUR.SP00.A", from = "2024-01")
#> ℹ Fetching EXR data
#> ✔ Fetching EXR data [8ms]
#> 
#>                     KEY FREQ CURRENCY CURRENCY_DENOM EXR_TYPE EXR_SUFFIX
#> 1  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 2  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 3  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 4  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 5  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 6  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 7  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 8  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 9  EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 10 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 11 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 12 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 13 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 14 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 15 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 16 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 17 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 18 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 19 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 20 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 21 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 22 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 23 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 24 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 25 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#> 26 EXR.M.USD.EUR.SP00.A    M      USD            EUR     SP00          A
#>    TIME_PERIOD OBS_VALUE
#> 1   2024-01-01  1.090514
#> 2   2024-02-01  1.079471
#> 3   2024-03-01  1.087220
#> 4   2024-04-01  1.072776
#> 5   2024-05-01  1.081223
#> 6   2024-06-01  1.075900
#> 7   2024-07-01  1.084409
#> 8   2024-08-01  1.101218
#> 9   2024-09-01  1.110600
#> 10  2024-10-01  1.090435
#> 11  2024-11-01  1.063014
#> 12  2024-12-01  1.047875
#> 13  2025-01-01  1.035373
#> 14  2025-02-01  1.041250
#> 15  2025-03-01  1.080681
#> 16  2025-04-01  1.121395
#> 17  2025-05-01  1.127805
#> 18  2025-06-01  1.151619
#> 19  2025-07-01  1.167687
#> 20  2025-08-01  1.163143
#> 21  2025-09-01  1.173223
#> 22  2025-10-01  1.163043
#> 23  2025-11-01  1.156020
#> 24  2025-12-01  1.170871
#> 25  2026-01-01  1.173824
#> 26  2026-02-01  1.182395
# }
```
