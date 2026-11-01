# List available ECB dataflows

Fetches the full list of dataflows from the ECB Data Portal. Each
dataflow corresponds to a dataset that can be queried with
[`ecb_get()`](https://charlescoverdale.github.io/readecb/reference/ecb_get.md).

## Usage

``` r
list_ecb_dataflows(cache = TRUE)
```

## Arguments

- cache:

  Logical. Use cached data if available (default `TRUE`).

## Value

A data frame with columns:

- dataflow_id:

  Character. The dataflow identifier.

- name:

  Character. Human-readable name.

## See also

Other data access:
[`clear_cache()`](https://charlescoverdale.github.io/readecb/reference/clear_cache.md),
[`ecb_get()`](https://charlescoverdale.github.io/readecb/reference/ecb_get.md),
[`ecb_yield_curve()`](https://charlescoverdale.github.io/readecb/reference/ecb_yield_curve.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
try({
  list_ecb_dataflows()
})
#> ℹ Fetching ECB dataflow list
#> ✔ Fetching ECB dataflow list [254ms]
#> 
#>     dataflow_id name
#> 1           AGR <NA>
#> 2           AME <NA>
#> 3           BKN <NA>
#> 4           BLS <NA>
#> 5           BNT <NA>
#> 6           BOP <NA>
#> 7           BSI <NA>
#> 8           BSP <NA>
#> 9           CAR <NA>
#> 10          CBD <NA>
#> 11         CBD2 <NA>
#> 12          CCP <NA>
#> 13          CES <NA>
#> 14         CISS <NA>
#> 15        CLIFS <NA>
#> 16          CMT <NA>
#> 17          CPP <NA>
#> 18         CSEC <NA>
#> 19          DCM <NA>
#> 20           DD <NA>
#> 21          DWA <NA>
#> 22          ECS <NA>
#> 23          EFS <NA>
#> 24         EMMS <NA>
#> 25          EON <NA>
#> 26          ESA <NA>
#> 27          ESB <NA>
#> 28          EST <NA>
#> 29          EWT <NA>
#> 30          EXR <NA>
#> 31           FM <NA>
#> 32          FVC <NA>
#> 33          FXI <NA>
#> 34          GST <NA>
#> 35         HICP <NA>
#> 36          ICB <NA>
#> 37          ICO <NA>
#> 38          ICP <NA>
#> 39          IFI <NA>
#> 40          ILM <NA>
#> 41          INW <NA>
#> 42          IRS <NA>
#> 43          IVF <NA>
#> 44          KRI <NA>
#> 45          LIG <NA>
#> 46          MFI <NA>
#> 47          MIR <NA>
#> 48          MMS <NA>
#> 49         MMSR <NA>
#> 50          MPD <NA>
#> 51          NEC <NA>
#> 52          OFI <NA>
#> 53          OMO <NA>
#> 54          PAY <NA>
#> 55          PCN <NA>
#> 56          PCP <NA>
#> 57          PCT <NA>
#> 58          PDD <NA>
#> 59          PEM <NA>
#> 60          PFB <NA>
#> 61         PFBM <NA>
#> 62         PFBR <NA>
#> 63          PIS <NA>
#> 64          PLB <NA>
#> 65          PMC <NA>
#> 66          PPC <NA>
#> 67          PSN <NA>
#> 68          PSS <NA>
#> 69          PST <NA>
#> 70          PTN <NA>
#> 71          PTT <NA>
#> 72           RA <NA>
#> 73          RAI <NA>
#> 74          RDE <NA>
#> 75          RDF <NA>
#> 76         RESC <NA>
#> 77         RESH <NA>
#> 78         RESR <NA>
#> 79         RESV <NA>
#> 80          RIR <NA>
#> 81          RPP <NA>
#> 82          RPV <NA>
#> 83          RTD <NA>
#> 84         SAFE <NA>
#> 85          SEC <NA>
#> 86          SEE <NA>
#> 87       SESFOD <NA>
#> 88          SHI <NA>
#> 89          SHS <NA>
#> 90         SHSS <NA>
#> 91          SPF <NA>
#> 92          SSI <NA>
#> 93          SSP <NA>
#> 94          SST <NA>
#> 95          ST1 <NA>
#> 96          ST3 <NA>
#> 97         STBS <NA>
#> 98          STP <NA>
#> 99          STS <NA>
#> 100         SUP <NA>
#> 101         SUR <NA>
#> 102         TGB <NA>
#> 103         TRD <NA>
#> 104         WTS <NA>
#> 105          YC <NA>
options(op)
# }
```
