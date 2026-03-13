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

## Examples

``` r
# \donttest{
list_ecb_dataflows()
#> ℹ Fetching ECB dataflow list
#> ✔ Fetching ECB dataflow list [142ms]
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
#> 22          EON <NA>
#> 23          ESA <NA>
#> 24          ESB <NA>
#> 25          EST <NA>
#> 26          EWT <NA>
#> 27          EXR <NA>
#> 28           FM <NA>
#> 29          FVC <NA>
#> 30          FXI <NA>
#> 31          GST <NA>
#> 32         HICP <NA>
#> 33          ICB <NA>
#> 34          ICO <NA>
#> 35          ICP <NA>
#> 36          IFI <NA>
#> 37          ILM <NA>
#> 38          INW <NA>
#> 39          IRS <NA>
#> 40          IVF <NA>
#> 41          KRI <NA>
#> 42          LIG <NA>
#> 43          MFI <NA>
#> 44          MIR <NA>
#> 45          MMS <NA>
#> 46         MMSR <NA>
#> 47          MPD <NA>
#> 48          NEC <NA>
#> 49          OFI <NA>
#> 50          OMO <NA>
#> 51          PAY <NA>
#> 52          PCN <NA>
#> 53          PCP <NA>
#> 54          PCT <NA>
#> 55          PDD <NA>
#> 56          PEM <NA>
#> 57          PFB <NA>
#> 58         PFBM <NA>
#> 59         PFBR <NA>
#> 60          PIS <NA>
#> 61          PLB <NA>
#> 62          PMC <NA>
#> 63          PPC <NA>
#> 64          PSN <NA>
#> 65          PSS <NA>
#> 66          PST <NA>
#> 67          PTN <NA>
#> 68          PTT <NA>
#> 69           RA <NA>
#> 70          RAI <NA>
#> 71          RDE <NA>
#> 72          RDF <NA>
#> 73         RESC <NA>
#> 74         RESH <NA>
#> 75         RESR <NA>
#> 76         RESV <NA>
#> 77          RIR <NA>
#> 78          RPP <NA>
#> 79          RPV <NA>
#> 80          RTD <NA>
#> 81         SAFE <NA>
#> 82          SEC <NA>
#> 83          SEE <NA>
#> 84       SESFOD <NA>
#> 85          SHI <NA>
#> 86          SHS <NA>
#> 87         SHSS <NA>
#> 88          SPF <NA>
#> 89          SSI <NA>
#> 90          SSP <NA>
#> 91          SST <NA>
#> 92          ST1 <NA>
#> 93          ST3 <NA>
#> 94         STBS <NA>
#> 95          STP <NA>
#> 96          STS <NA>
#> 97          SUP <NA>
#> 98          SUR <NA>
#> 99          TGB <NA>
#> 100         TRD <NA>
#> 101         WTS <NA>
#> 102          YC <NA>
# }
```
