# Approximation Catalog

Every registered test includes `parity` and `method` metadata from
[`ggpower_tests()`](https://yaoxiangli.github.io/ggpower/reference/ggpower_tests.md).
Tests marked `approximation` use large-sample or proxy formulas. Result
objects include `notes` explaining the kernel used.

``` r
tests <- ggpower_tests()
approx <- tests[tests$parity == "approximation", c("id", "method", "module")]
knitr::kable(approx, row.names = FALSE)
```

| id                | method                                   | module    |
|:------------------|:-----------------------------------------|:----------|
| exact_correlation | Fisher Z with exact-kernel TODO          | workspace |
| z_tetrachoric     | large-sample tetrachoric z approximation | workspace |

## Workspace approximations

| Test | Limitation |
|----|----|
| `exact_correlation` | Fisher-Z; exact small-sample kernel planned |
| `z_tetrachoric` | Large-sample Fisher-Z on tetrachoric $`\rho`$ |
| `exact_mcnemar` | Discordant-pair binomial proxy |
| `z_logistic`, `z_poisson` | Wald normal approximation |
| `wilcoxon_signed`, `wilcoxon_mann_whitney` | ARE-scaled t tests |

## Biomarker approximations

| Test | Limitation |
|----|----|
| `roc_auc_one`, `roc_auc_two` | Hanley-McNeil / DeLong-style normal |
| `diagnostic_acc` | Binomial normal; power = min(sens, spec) |
| `survival_logrank`, `cox_regression` | Equal follow-up / events simplification |
| `discovery_fdr` | Independent tests + simplified BH |

## Clinical approximations

| Test | Limitation |
|----|----|
| `rct_noninferiority_binary`, `rct_equivalence_proportion` | Normal proportion approximation |
| `simon_two_stage` | Fixed design; no optimal design search |

## When exact enumeration is used

`exact_fisher` and `exact_binomial` use enumeration when the outcome
grid is small enough; large tables fall back to normal approximations.

## Related

- [Reference
  validation](https://yaoxiangli.github.io/ggpower/articles/reference-validation.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
