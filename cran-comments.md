# CRAN submission comments: readecb 0.1.5

## Reason for this submission

Data-correctness fixes. Following Bulgaria's accession to the euro area
on 1 January 2026 the ECB moved the HICP to a new dataflow and the euro
area aggregates to a new code, so four functions were returning series
that had stopped updating. The local cache also never expired. Details
in NEWS.md.

## R CMD check results

0 errors | 0 warnings | 0 notes (CRAN settings, R 4.5.2, macOS).

All tests that reach the ECB Data Portal are skipped on CRAN, and every
example that does so is wrapped in `try()` inside `\donttest{}`.

## Downstream dependencies

None on CRAN.
