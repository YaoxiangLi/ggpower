# ggpower 0.1.3

## Reliability and installation

- Moved GUI-only `bs4Dash`, `config`, and `golem` dependencies to Suggests so
  the scriptable power-analysis API has a smaller installation footprint.
- Added a clear dependency check before launching the optional application.
- Registered the `format.ggpower_result()` S3 method and completed
  effect-size helper documentation.
- Added permanent R-devel checks to the cross-platform CI matrix.

# ggpower 0.1.2

## CRAN resubmission

- DESCRIPTION: removed quotes around `power_compute()`.
- Added `\value` to `run_app()` documentation.
- Expanded `power_compute()` return-value documentation.

# ggpower 0.1.1

## CRAN resubmission

- Quoted software names in DESCRIPTION ('ggplot2', 'Shiny').
- Fixed invalid relative vignette links in `reference-validation.Rmd`.

# ggpower 0.1.0

## Features

- 48 registered power tests across Power Workspace, Biomarker Discovery, and Clinical Trials modules.
- Five analysis modes: a priori, post hoc, criterion, sensitivity, and compromise.
- Shiny application with sidebar navigation, distribution plots, X-Y power curves, calculator, protocol log, and help articles.
- Publication-ready plotting via `theme_ggpower()` and `plot_power_curve()`.
- Formula reference, support matrix, scenario guide, and reference validation vignettes.

## Documentation

- pkgdown site at https://yaoxiangli.github.io/ggpower/
- Per-test vignettes with worked `power_compute()` examples and LaTeX formulas.
