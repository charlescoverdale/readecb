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
list_ecb_dataflows()
#> ℹ Fetching ECB dataflow list
#> ✔ Fetching ECB dataflow list [177ms]
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
#> 16          CPP <NA>
#> 17         CSEC <NA>
#> 18          DCM <NA>
#> 19           DD <NA>
#> 20          DWA <NA>
#> 21          ECS <NA>
#> 22         EMMS <NA>
#> 23          EON <NA>
#> 24          ESA <NA>
#> 25          ESB <NA>
#> 26          EST <NA>
#> 27          EWT <NA>
#> 28          EXR <NA>
#> 29           FM <NA>
#> 30          FVC <NA>
#> 31          FXI <NA>
#> 32          GST <NA>
#> 33         HICP <NA>
#> 34          ICB <NA>
#> 35          ICO <NA>
#> 36          ICP <NA>
#> 37          IFI <NA>
#> 38          ILM <NA>
#> 39          INW <NA>
#> 40          IRS <NA>
#> 41          IVF <NA>
#> 42          KRI <NA>
#> 43          LIG <NA>
#> 44          MFI <NA>
#> 45          MIR <NA>
#> 46          MMS <NA>
#> 47         MMSR <NA>
#> 48          MPD <NA>
#> 49          NEC <NA>
#> 50          OFI <NA>
#> 51          OMO <NA>
#> 52          PAY <NA>
#> 53          PCN <NA>
#> 54          PCP <NA>
#> 55          PCT <NA>
#> 56          PDD <NA>
#> 57          PEM <NA>
#> 58          PFB <NA>
#> 59         PFBM <NA>
#> 60         PFBR <NA>
#> 61          PIS <NA>
#> 62          PLB <NA>
#> 63          PMC <NA>
#> 64          PPC <NA>
#> 65          PSN <NA>
#> 66          PSS <NA>
#> 67          PST <NA>
#> 68          PTN <NA>
#> 69          PTT <NA>
#> 70           RA <NA>
#> 71          RAI <NA>
#> 72          RDE <NA>
#> 73          RDF <NA>
#> 74         RESC <NA>
#> 75         RESH <NA>
#> 76         RESR <NA>
#> 77         RESV <NA>
#> 78          RIR <NA>
#> 79          RPP <NA>
#> 80          RPV <NA>
#> 81          RTD <NA>
#> 82         SAFE <NA>
#> 83          SEC <NA>
#> 84          SEE <NA>
#> 85       SESFOD <NA>
#> 86          SHI <NA>
#> 87          SHS <NA>
#> 88         SHSS <NA>
#> 89          SPF <NA>
#> 90          SSI <NA>
#> 91          SSP <NA>
#> 92          SST <NA>
#> 93          ST1 <NA>
#> 94          ST3 <NA>
#> 95         STBS <NA>
#> 96          STP <NA>
#> 97          STS <NA>
#> 98          SUP <NA>
#> 99          SUR <NA>
#> 100         TGB <NA>
#> 101         TRD <NA>
#> 102         WTS <NA>
#> 103          YC <NA>
options(op)
# }
```
