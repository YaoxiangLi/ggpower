## Resubmission

This is a resubmission of ggpower 0.1.2 (0.1.1 was not accepted).

## Fixes since 0.1.1

* Removed single quotes around power_compute() in DESCRIPTION (per Konstanze Lauseker).
* Added `\value` documentation to `run_app.Rd`.
* Expanded the `power_compute()` return-value description in `power_compute.Rd`.

## References in DESCRIPTION

Standard power-analysis formulas are documented in the package vignettes and
on the pkgdown formula reference page; no single monograph is cited in
DESCRIPTION.

## Test environments

* Local Windows 11, R 4.6.x
* GitHub Actions: ubuntu-latest, windows-latest, macos-latest (R release)
* R CMD check --as-cran: 0 errors | 0 warnings | 0 notes expected aside from CRAN incoming

## Downstream dependencies

* None.
