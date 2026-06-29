# Biomarker ROC and AUC Power

## In plain English

You have a continuous biomarker and want to know whether it can
**discriminate** diseased from non-diseased subjects. ROC AUC summarizes
that discrimination. This vignette covers one-sample AUC vs chance (0.5)
and two-sample AUC comparison.

## One-sample AUC vs null

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

## Compare two biomarkers

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

## Formula

Hanley-McNeil SE for one AUC; DeLong-style variance for two independent
AUCs. See [formula
reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md).

## Plot

Run the calculation in the **Biomarker Discovery** module to see the
distribution and sample-size curve.

## Related analyses

- [Diagnostic
  accuracy](https://yaoxiangli.github.io/ggpower/articles/biomarker-diagnostic-accuracy.md)
- [Differential
  expression](https://yaoxiangli.github.io/ggpower/articles/biomarker-differential-expression.md)
