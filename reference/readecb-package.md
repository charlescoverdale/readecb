# readecb: Access 'European Central Bank' Data

Provides clean, tidy access to statistical data published by the
'European Central Bank' ('ECB') via the 'ECB Data Portal' API
<https://data.ecb.europa.eu>. Covers policy interest rates, 'EURIBOR',
euro exchange rates, harmonised consumer price inflation ('HICP'), euro
area yield curves, the euro short-term rate ('ESTR'), monetary
aggregates (M1, M2, M3), mortgage and lending rates, GDP, unemployment,
and government debt-to-GDP. Each dataset has a dedicated function that
abstracts away the underlying 'SDMX' key structure, so users do not need
to know series codes. A generic fetcher is also provided for direct
access to any of the 'ECB' 100-plus dataflows. Data is downloaded on
first use and cached locally for subsequent calls.

## See also

Useful links:

- <https://charlescoverdale.github.io/readecb/>

- <https://github.com/charlescoverdale/readecb>

- Report bugs at <https://github.com/charlescoverdale/readecb/issues>

## Author

**Maintainer**: Charles Coverdale <charlesfcoverdale@gmail.com>
