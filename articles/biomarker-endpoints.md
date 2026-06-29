# Biomarker Endpoints

The **Biomarker Discovery** module covers expression, classification,
survival, and screening endpoints. Detailed per-topic articles remain on
the pkgdown site.

## Differential expression

Two-group mean difference for expression biomarkers (wrapper around
`t_two_sample`).

``` r

power_compute("ttest_biomarker", "post_hoc", d = 0.6, n1 = 40, n2 = 40,
              alpha = 0.05, tails = "two")
#> ggpower result
#> Test: Biomarker: Two-group differential expression (t test)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   alpha: 0.05
#>   sample_size_group_1: 40
#>   sample_size_group_2: 40
#>   log_fold_change_sd: 0.6
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.683282
#>   critical_t: -1.990847,  1.990847
#>   df: 78
#>   total_sample_size: 80
#>   power: 0.7549516
```

``` r

power_compute("ttest_biomarker", "a_priori", d = 0.5, alpha = 0.05,
              power = 0.8, allocation_ratio = 1)
#> ggpower result
#> Test: Biomarker: Two-group differential expression (t test)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   alpha: 0.05
#>   sample_size_group_1: 64
#>   sample_size_group_2: 64
#>   log_fold_change_sd: 0.5
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.828427
#>   critical_t: -1.978971,  1.978971
#>   df: 126
#>   total_sample_size: 128
#>   actual_power: 0.8014596
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## ROC and AUC

``` r

power_compute(
  "roc_auc_one",
  analysis = "a_priori",
  auc = 0.75,
  auc0 = 0.5,
  n_pos = 50,
  n_neg = 50,
  alpha = 0.05,
  power = 0.8,
  tails = "two"
)
#> ggpower result
#> Test: Biomarker: One-sample ROC AUC vs null
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   auc_h1: 0.75
#>   auc_h0: 0.5
#>   n_positive: 16
#>   n_negative: 16
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   z_statistic: 2.860533
#>   se_auc: 0.0873963
#>   total_sample_size: 32
#>   actual_power: 0.8160919
#> 
#> 
#> Notes
#> - Hanley-McNeil normal approximation for AUC variance.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

``` r

power_compute(
  "roc_auc_two",
  analysis = "post_hoc",
  auc1 = 0.78,
  auc2 = 0.62,
  n1 = 80,
  n2 = 80,
  alpha = 0.05,
  tails = "two"
)
#> ggpower result
#> Test: Biomarker: Two-sample ROC AUC comparison
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   auc_group_1: 0.78
#>   auc_group_2: 0.62
#>   sample_size_group_1: 80
#>   sample_size_group_2: 80
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   z_statistic: 2.790489
#>   se_difference: 0.05733762
#>   total_sample_size: 160
#>   power: 0.79688
#> 
#> 
#> Notes
#> - DeLong-style normal approximation for AUC difference.
```

## Diagnostic accuracy

``` r

power_compute("diagnostic_acc", "post_hoc", sensitivity = 0.85, specificity = 0.85,
              n_pos = 50, n_neg = 50, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Diagnostic accuracy (sensitivity and specificity)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   sensitivity_h1: 0.85
#>   specificity_h1: 0.85
#>   n_positive: 50
#>   n_negative: 50
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   z_sensitivity: 16.83251
#>   z_specificity: 16.83251
#>   power_sensitivity: 1
#>   power_specificity: 1
#>   power: 1
#>   total_sample_size: 100
#> 
#> 
#> Notes
#> - Joint power uses the minimum of sensitivity and specificity power (Bonferroni-style).
```

``` r

power_compute("diagnostic_acc", "a_priori", sensitivity = 0.9, specificity = 0.9,
              alpha = 0.05, power = 0.8, allocation_ratio = 1)
#> ggpower result
#> Test: Biomarker: Diagnostic accuracy (sensitivity and specificity)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   sensitivity_h1: 0.9
#>   specificity_h1: 0.9
#>   n_positive: 2
#>   n_negative: 2
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   z_sensitivity: 4.242641
#>   z_specificity: 4.242641
#>   power_sensitivity: 0.9887753
#>   power_specificity: 0.9887753
#>   total_sample_size: 4
#>   actual_power: 0.9887753
#> 
#> 
#> Notes
#> - Joint power uses the minimum of sensitivity and specificity power (Bonferroni-style).
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Survival (log-rank)

``` r

power_compute("survival_logrank", "post_hoc", hazard_ratio = 0.65,
              total_n = 200, event_rate = 0.5, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Survival log-rank test
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   event_rate: 0.5
#>   allocation_ratio: 1
#>   total_sample_size: 200
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   expected_events: 100
#>   z_statistic: 2.153915
#>   power: 0.5769122
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
```

## Cox prognostic models

``` r

power_compute("cox_regression", "post_hoc", hazard_ratio = 0.65,
              events = 100, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Cox proportional hazards (single covariate)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   events: 100
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   z_statistic: 4.307829
#>   power: 0.9905593
#> 
#> 
#> Notes
#> - Wald test power from expected number of events.
```

``` r

power_compute("cox_regression", "a_priori", hazard_ratio = 0.7,
              alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Biomarker: Cox proportional hazards (single covariate)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.7
#>   events: 62
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   z_statistic: 2.808461
#>   actual_power: 0.8019204
#> 
#> 
#> Notes
#> - Wald test power from expected number of events.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Multiplicity and FDR

``` r

power_compute("discovery_fdr", "post_hoc", effect_d = 0.5, m_tests = 1000,
              pi0 = 0.9, fdr_level = 0.05, n = 40, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Discovery power under FDR control
#> Analysis: post_hoc
#> 
#> Input parameters
#>   m_tests: 1000
#>   proportion_null: 0.9
#>   effect_size_d: 0.5
#>   n_per_comparison: 40
#>   fdr_level: 0.05
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   alternative_hypotheses: 100
#>   single_test_power: 0.8693981
#>   expected_discoveries: 86.93981
#>   expected_fdr: 0.5175995
#>   power: 0.08398368
#> 
#> 
#> Notes
#> - BH-FDR framework with independent t-test approximations per biomarker.
```

## Related

- [Clinical
  trials](https://yaoxiangli.github.io/ggpower/articles/clinical-trials.md)
- [Scenario
  guide](https://yaoxiangli.github.io/ggpower/articles/scenario-guide.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
