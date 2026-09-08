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
#> ✔ Fetching ECB dataflow list [210ms]
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
#> 22          EFS <NA>
#> 23         EMMS <NA>
#> 24          EON <NA>
#> 25          ESA <NA>
#> 26          ESB <NA>
#> 27          EST <NA>
#> 28          EWT <NA>
#> 29          EXR <NA>
#> 30           FM <NA>
#> 31          FVC <NA>
#> 32          FXI <NA>
#> 33          GST <NA>
#> 34         HICP <NA>
#> 35          ICB <NA>
#> 36          ICO <NA>
#> 37          ICP <NA>
#> 38          IFI <NA>
#> 39          ILM <NA>
#> 40          INW <NA>
#> 41          IRS <NA>
#> 42          IVF <NA>
#> 43          KRI <NA>
#> 44          LIG <NA>
#> 45          MFI <NA>
#> 46          MIR <NA>
#> 47          MMS <NA>
#> 48         MMSR <NA>
#> 49          MPD <NA>
#> 50          NEC <NA>
#> 51          OFI <NA>
#> 52          OMO <NA>
#> 53          PAY <NA>
#> 54          PCN <NA>
#> 55          PCP <NA>
#> 56          PCT <NA>
#> 57          PDD <NA>
#> 58          PEM <NA>
#> 59          PFB <NA>
#> 60         PFBM <NA>
#> 61         PFBR <NA>
#> 62          PIS <NA>
#> 63          PLB <NA>
#> 64          PMC <NA>
#> 65          PPC <NA>
#> 66          PSN <NA>
#> 67          PSS <NA>
#> 68          PST <NA>
#> 69          PTN <NA>
#> 70          PTT <NA>
#> 71           RA <NA>
#> 72          RAI <NA>
#> 73          RDE <NA>
#> 74          RDF <NA>
#> 75         RESC <NA>
#> 76         RESH <NA>
#> 77         RESR <NA>
#> 78         RESV <NA>
#> 79          RIR <NA>
#> 80          RPP <NA>
#> 81          RPV <NA>
#> 82          RTD <NA>
#> 83         SAFE <NA>
#> 84          SEC <NA>
#> 85          SEE <NA>
#> 86       SESFOD <NA>
#> 87          SHI <NA>
#> 88          SHS <NA>
#> 89         SHSS <NA>
#> 90          SPF <NA>
#> 91          SSI <NA>
#> 92          SSP <NA>
#> 93          SST <NA>
#> 94          ST1 <NA>
#> 95          ST3 <NA>
#> 96         STBS <NA>
#> 97          STP <NA>
#> 98          STS <NA>
#> 99          SUP <NA>
#> 100         SUR <NA>
#> 101         TGB <NA>
#> 102         TRD <NA>
#> 103         WTS <NA>
#> 104          YC <NA>
options(op)
# }
```
