# List available exchange rate currencies

Returns a data frame of ISO 4217 currency codes for which the ECB
publishes reference exchange rates. No network call is made.

## Usage

``` r
list_exchange_rates()
```

## Value

A data frame with columns:

- code:

  Character. ISO 4217 currency code.

- currency:

  Character. Currency name.

## Examples

``` r
list_exchange_rates()
#>    code              currency
#> 1   USD             US dollar
#> 2   JPY          Japanese yen
#> 3   GBP        Pound sterling
#> 4   CHF           Swiss franc
#> 5   AUD     Australian dollar
#> 6   CAD       Canadian dollar
#> 7   SEK         Swedish krona
#> 8   NOK       Norwegian krone
#> 9   DKK          Danish krone
#> 10  NZD    New Zealand dollar
#> 11  CNY Chinese yuan renminbi
#> 12  HKD      Hong Kong dollar
#> 13  SGD      Singapore dollar
#> 14  KRW      South Korean won
#> 15  THB             Thai baht
#> 16  MYR     Malaysian ringgit
#> 17  PHP       Philippine peso
#> 18  IDR     Indonesian rupiah
#> 19  INR          Indian rupee
#> 20  BRL        Brazilian real
#> 21  MXN          Mexican peso
#> 22  ZAR    South African rand
#> 23  TRY          Turkish lira
#> 24  PLN          Polish zloty
#> 25  CZK          Czech koruna
#> 26  HUF      Hungarian forint
#> 27  BGN         Bulgarian lev
#> 28  RON          Romanian leu
#> 29  HRK         Croatian kuna
#> 30  ISK       Icelandic krona
#> 31  ILS        Israeli shekel
#> 32  RUB        Russian rouble
```
