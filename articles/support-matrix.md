# Support Matrix

## Coverage table

Every registered test with domain, module, parity, method, and supported
modes:

``` r

tests <- ggpower_tests()
knitr::kable(
  tests[, c("id", "module", "domain", "family", "parity", "method", "modes")],
  row.names = FALSE
)
```

| id | module | domain | family | parity | method | modes |
|:---|:---|:---|:---|:---|:---|:---|
| t_one_sample | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_paired | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_two_sample | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_point_biserial | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_linear_regression | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_linear_regression_two_groups | workspace | general | t tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| t_generic | workspace | general | t tests | supported | distribution kernel | post_hoc, criterion, sensitivity, compromise |
| f_anova_one_way | workspace | general | F tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| f_anova_special | workspace | general | F tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| f_mreg_omnibus | workspace | general | F tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| f_mreg_increase | workspace | general | F tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| f_variance_two | workspace | general | F tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| chisq_variance_one | workspace | general | chi-square tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| chisq_gof | workspace | general | chi-square tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| chisq_contingency | workspace | general | chi-square tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_binomial | workspace | general | Exact | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_one_proportion | workspace | general | Exact | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_sign | workspace | general | Exact | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_fisher | workspace | general | Exact | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_mcnemar | workspace | general | Exact | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_correlation | workspace | general | Exact | approximation | Fisher Z with exact-kernel TODO | a_priori, compromise, criterion, post_hoc, sensitivity |
| exact_mreg_random | workspace | general | Exact | supported | exact R2 distribution approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_corr_independent | workspace | general | z tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_corr_dependent_common | workspace | general | z tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_corr_dependent_no_common | workspace | general | z tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_logistic | workspace | general | z tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_poisson | workspace | general | z tests | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| z_tetrachoric | workspace | general | z tests | approximation | large-sample tetrachoric z approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| wilcoxon_signed | workspace | general | nonparametric | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| wilcoxon_mann_whitney | workspace | general | nonparametric | supported | distribution kernel | a_priori, compromise, criterion, post_hoc, sensitivity |
| roc_auc_one | biomarker | biomarker | biomarker | supported | Hanley-McNeil AUC variance approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| roc_auc_two | biomarker | biomarker | biomarker | supported | DeLong-style AUC difference approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| diagnostic_acc | biomarker | biomarker | biomarker | supported | Binomial normal approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| survival_logrank | biomarker | biomarker | biomarker | supported | Schoenfeld/Freedman log-rank approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| cox_regression | biomarker | biomarker | biomarker | supported | Cox Wald z approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| discovery_fdr | biomarker | biomarker | biomarker | supported | Benjamini-Hochberg FDR framework | a_priori, compromise, criterion, post_hoc, sensitivity |
| ttest_biomarker | biomarker | biomarker | biomarker | supported | Two-sample t test (biomarker wrapper) | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_superiority_continuous | clinical | pharma | clinical | supported | One-sided two-sample t test | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_superiority_binary | clinical | pharma | clinical | supported | One-sided Fisher exact / proportions | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_noninferiority_continuous | clinical | pharma | clinical | supported | One-sided NI t test | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_noninferiority_binary | clinical | pharma | clinical | supported | One-sided NI proportions test | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_equivalence_continuous | clinical | pharma | clinical | supported | Two one-sided t tests (TOST) | a_priori, compromise, criterion, post_hoc, sensitivity |
| rct_equivalence_proportion | clinical | pharma | clinical | supported | Two one-sided proportion tests (TOST) | a_priori, compromise, criterion, post_hoc, sensitivity |
| simon_two_stage | clinical | pharma | clinical | supported | Simon 1989 two-stage binomial design | post_hoc, sensitivity |
| cluster_rct | clinical | pharma | clinical | supported | Design effect from ICC | a_priori, compromise, criterion, post_hoc, sensitivity |
| multi_arm_superiority | clinical | pharma | clinical | supported | One-way ANOVA F test | a_priori, compromise, criterion, post_hoc, sensitivity |
| count_endpoint_poisson | clinical | pharma | clinical | supported | Poisson regression z approximation | a_priori, compromise, criterion, post_hoc, sensitivity |
| survival_pmu | clinical | pharma | clinical | supported | Schoenfeld/Freedman log-rank approximation | a_priori, compromise, criterion, post_hoc, sensitivity |

## Counts by module

``` r

as.data.frame(table(tests$module))
#>        Var1 Freq
#> 1 biomarker    7
#> 2  clinical   11
#> 3 workspace   30
```

## Mode restrictions

| Test | Supported modes |
|----|----|
| `t_generic` | `post_hoc`, `criterion`, `sensitivity`, `compromise` (no `a_priori`) |
| `simon_two_stage` | `post_hoc`, `sensitivity` only |

## Vignette index

CRAN ships consolidated vignettes; the pkgdown site adds per-test deep
dives.

| Module area     | Vignette slug             |
|:----------------|:--------------------------|
| getting started | choosing-a-power-analysis |
| getting started | getting-started-gui       |
| getting started | scenario-guide            |
| workspace       | t-tests                   |
| workspace       | workspace-test-families   |
| biomarker       | biomarker-endpoints       |
| clinical        | clinical-trials           |
| reference       | analysis-modes            |
| reference       | support-matrix            |
| reference       | reference-validation      |

Approximation limits and method notes: [approximation
catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.html)
(pkgdown only).

## Related analyses

- [Reference
  validation](https://yaoxiangli.github.io/ggpower/articles/reference-validation.md)
- [Scenario
  guide](https://yaoxiangli.github.io/ggpower/articles/scenario-guide.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.html)
  (pkgdown only)
