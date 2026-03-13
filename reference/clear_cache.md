# Clear the readecb cache

Deletes all locally cached ECB data files. The next call to any data
function will re-download from the ECB Data Portal.

## Usage

``` r
clear_cache()
```

## Value

Invisible `NULL`.

## Examples

``` r
# \donttest{
clear_cache()
#> ℹ No cache to clear.
# }
```
