# ggpower

[![R-CMD-check](https://github.com/YaoxiangLi/ggpower/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/YaoxiangLi/ggpower/actions/workflows/R-CMD-check.yaml)

Documentation: <https://yaoxiangli.github.io/ggpower/>

`ggpower` is an R package and Shiny application for statistical power
analysis. It provides a scriptable API through
[`power_compute()`](https://yaoxiangli.github.io/ggpower/reference/power_compute.md)
and a wide-screen GUI with six modules:

1.  Choose a test family and statistical test.
2.  Choose a power-analysis type.
3.  Enter input parameters.
4.  Calculate output parameters.
5.  Inspect distribution plots, X-Y power plots, and protocol history.

## Supported Analysis Modes

- A priori: compute required sample size.
- Compromise: compute alpha and beta from beta / alpha.
- Criterion: compute alpha for a target power.
- Post hoc: compute achieved power.
- Sensitivity: compute the effect size required for target power.

## Supported Test Families

- t tests: one-sample, paired, two independent means, point-biserial,
  generic t.
- F tests: one-way ANOVA, special ANOVA effects, multiple-regression
  omnibus, multiple-regression R2 increase, two variances.
- Chi-square tests: variance, goodness-of-fit, contingency tables.
- Exact/proportion tests: binomial, one proportion, sign test,
  McNemar-style discordant-pair binomial planning, Fisher-style
  two-proportion planning.
- z tests: independent correlations, logistic regression, Poisson
  regression.
- Nonparametric tests: Wilcoxon signed-rank and Wilcoxon-Mann-Whitney
  using asymptotic relative efficiency planning.
- Biomarker: ROC/AUC, diagnostic accuracy, survival, Cox, FDR screening.
- Clinical: superiority, non-inferiority, equivalence, Simon two-stage,
  cluster RCT.

Some advanced procedures use documented approximations. The result
object includes method notes so these cases are visible in the GUI and
protocol. See the [approximation
catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.html).

## Examples

``` r

power_compute(
  "t_one_sample",
  "a_priori",
  d = 0.625,
  alpha = 0.05,
  power = 0.95,
  tails = "one"
)

power_compute(
  "f_mreg_omnibus",
  "post_hoc",
  f2 = 0.1111111,
  alpha = 0.05,
  total_n = 95,
  predictors = 5
)
```

Run the app with:

``` r

ggpower::run_app()
```

## Validation

The test suite includes golden reference examples, solver tests for the
five analysis modes, registry checks, and Shiny module smoke tests.
