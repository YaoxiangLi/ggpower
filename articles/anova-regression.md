# ANOVA and Regression

F tests cover ANOVA effects and fixed-model multiple regression.

## One-way ANOVA

``` math
f = \sqrt{\eta^2/(1-\eta^2)}, \quad \lambda = f^2 N
```

``` r
power_compute("f_anova_one_way", "a_priori", f = 0.25, alpha = 0.05,
              power = 0.8, groups = 4)
#> ggpower result
#> Test: F test: Fixed effects ANOVA - one way
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_f: 0.25
#>   alpha: 0.05
#>   total_sample_size: 179
#>   groups: 4
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 11.1875
#>   critical_f: 2.656234
#>   numerator_df: 3
#>   denominator_df: 175
#>   actual_power: 0.8015073
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Factorial effects

``` r
power_compute("f_anova_special", "post_hoc", f = 0.2450722,
              total_n = 108, df1 = 4, groups = 36)
#> ggpower result
#> Test: F test: Fixed effects ANOVA - special, main effects and interactions
#> Analysis: post_hoc
#> 
#> Input parameters
#>   effect_size_f: 0.2450722
#>   alpha: 0.05
#>   total_sample_size: 108
#>   numerator_df: 4
#>   groups: 36
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 6.486521
#>   critical_f: 2.498919
#>   denominator_df: 72
#>   power: 0.4756346
```

## Multiple regression omnibus

``` r
f2 <- effect_size_f2(0.10)
power_compute("f_mreg_omnibus", "post_hoc", f2 = f2,
              total_n = 95, predictors = 5)
#> ggpower result
#> Test: F test: Multiple Regression - omnibus (deviation of R2 from zero), fixed model
#> Analysis: post_hoc
#> 
#> Input parameters
#>   effect_size_f2: 0.1111111
#>   alpha: 0.05
#>   total_sample_size: 95
#>   predictors: 5
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 10.55556
#>   critical_f: 2.316858
#>   numerator_df: 5
#>   denominator_df: 89
#>   power: 0.6735858
```

## Multiple regression $`R^2`$ increase

``` r
f2 <- effect_size_f2_increase(r2_full = 0.15, r2_reduced = 0.05)
power_compute("f_mreg_increase", "post_hoc", f2 = f2, total_n = 100,
              predictors = 5, tested_predictors = 1)
#> ggpower result
#> Test: F test: Multiple Regression - special (increase of R2), fixed model
#> Analysis: post_hoc
#> 
#> Input parameters
#>   effect_size_f2: 0.1176471
#>   alpha: 0.05
#>   total_sample_size: 100
#>   tested_predictors: 1
#>   total_predictors: 5
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 11.76471
#>   critical_f: 3.942303
#>   numerator_df: 1
#>   denominator_df: 94
#>   power: 0.924322
```

## Two variances

``` r
power_compute("f_variance_two", "sensitivity", alpha = 0.05, power = 0.8,
              n1 = 30, n2 = 30)
#> ggpower result
#> Test: F test: Inequality of two variances
#> Analysis: sensitivity
#> 
#> Input parameters
#>   tails: two
#>   ratio_var1_var0: 2.881558
#>   alpha: 0.05
#>   sample_size_group_1: 30
#>   sample_size_group_2: 30
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   critical_f: 0.4759648, 2.1009958
#>   numerator_df: 29
#>   denominator_df: 29
#>   total_sample_size: 60
#>   power: 0.8
#>   variance_ratio: 2.881558
#> 
#> 
#> Notes
#> - Two-variance power uses the scaled central F distribution.
```

## Chi-square variance

``` r
power_compute("chisq_variance_one", "post_hoc", variance_ratio = 1.5,
              n = 40, alpha = 0.05)
#> ggpower result
#> Test: chi-square test: Variance - difference from constant (one sample case)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   ratio_var1_var0: 1.5
#>   alpha: 0.05
#>   total_sample_size: 40
#> 
#> 
#> Output parameters
#>   critical_chisq: 23.65432, 58.12006
#>   df: 39
#>   power: 0.4816487
```

## Goodness of fit

``` r
w <- effect_size_w(c(0.25, 0.25, 0.25, 0.25), c(0.35, 0.15, 0.30, 0.20))
power_compute("chisq_gof", "a_priori", w = w, alpha = 0.05, power = 0.8,
              groups = 4)
#> ggpower result
#> Test: chi-square test: Goodness-of-fit tests: Contingency tables
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_w: 0.3162278
#>   alpha: 0.05
#>   total_sample_size: 79
#>   df: 1
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 7.9
#>   critical_chisq: 3.841459
#>   actual_power: 0.8025412
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Contingency table

``` r
w <- effect_size_w(c(0.5, 0.5), c(0.6, 0.4))
power_compute("chisq_contingency", "post_hoc", w = w, total_n = 100, groups = 2)
#> ggpower result
#> Test: chi-square test: Contingency tables
#> Analysis: post_hoc
#> 
#> Input parameters
#>   effect_size_w: 0.2
#>   alpha: 0.05
#>   total_sample_size: 100
#>   df: 1
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 4
#>   critical_chisq: 3.841459
#>   power: 0.5160053
```

## Related

- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
