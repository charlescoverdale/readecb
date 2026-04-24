# Clear the readecb cache

Deletes all locally cached ECB data files. The next call to any data
function will re-download from the ECB Data Portal.

## Usage

``` r
clear_cache()
```

## Value

Invisible `NULL`.

## See also

Other data access:
[`ecb_get()`](https://charlescoverdale.github.io/readecb/reference/ecb_get.md),
[`ecb_yield_curve()`](https://charlescoverdale.github.io/readecb/reference/ecb_yield_curve.md),
[`list_ecb_dataflows()`](https://charlescoverdale.github.io/readecb/reference/list_ecb_dataflows.md)

## Examples

``` r
# \donttest{
op <- options(readecb.cache_dir = tempdir())
clear_cache()
#> ✔ Cache cleared.
options(op)
# }
```
