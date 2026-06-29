# Biomarker Diagnostic Accuracy

Power for validating sensitivity and specificity of a diagnostic
classifier.

## Formula

Separate binomial tests; reported power is
$`\min(\text{Power}_{\text{sens}}, \text{Power}_{\text{spec}})`$.

## Post hoc

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

## A priori

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

## Related

- [ROC /
  AUC](https://yaoxiangli.github.io/ggpower/articles/biomarker-roc-auc.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
