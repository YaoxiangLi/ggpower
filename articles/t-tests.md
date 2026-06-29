# t Tests

t tests cover mean differences, matched pairs, point-biserial
correlations, regression slopes, and generic noncentrality.

## One sample

``` math
d = \frac{\mu_1 - \mu_0}{\sigma}, \quad \delta = d\sqrt{n}
```

``` r

power_compute("t_one_sample", "a_priori", d = 0.625, alpha = 0.05,
              power = 0.95, tails = "one")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.625
#>   alpha: 0.05
#>   total_sample_size: 30
#>   target_power: 0.95
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.423266
#>   critical_t: 1.699127
#>   df: 29
#>   actual_power: 0.9551444
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Two independent means

``` r

power_compute("t_two_sample", "a_priori", d = 0.5, alpha = 0.05,
              power = 0.8, tails = "two", allocation_ratio = 1)
#> ggpower result
#> Test: t test: Means - difference between two independent means (two groups)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.05
#>   sample_size_group_1: 64
#>   sample_size_group_2: 64
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

## Matched pairs

``` r

power_compute("t_paired", "post_hoc", d = 0.42, n = 50, alpha = 0.05)
#> ggpower result
#> Test: t test: Means - difference between two dependent means (matched pairs)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   effect_size_dz: 0.42
#>   alpha: 0.05
#>   total_sample_size: 50
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.969848
#>   critical_t: -2.009575,  2.009575
#>   df: 49
#>   power: 0.8292517
```

## Point-biserial correlation

``` r

power_compute("t_point_biserial", "a_priori", rho = 0.3, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: t test: Correlation - point biserial model
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   effect_size_rho: 0.3
#>   alpha: 0.05
#>   total_sample_size: 82
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.847787
#>   critical_t: -1.990063,  1.990063
#>   df: 80
#>   actual_power: 0.8033045
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Linear regression slope

``` r

power_compute("t_linear_regression", "post_hoc", slope_h1 = -0.0667,
              slope_h0 = 0, sd_x = 7.5, sd_y = 4, n = 100)
#> ggpower result
#> Test: t test: Linear Regression (size of slope, one group)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   slope_h1: -0.0667
#>   slope_h0: 0
#>   sd_x: 7.5
#>   sd_y: 4
#>   alpha: 0.05
#>   total_sample_size: 100
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: -1.250625
#>   critical_t: -1.984467,  1.984467
#>   df: 98
#>   power: 0.2359684
```

## Two-group slope difference

``` r

power_compute("t_linear_regression_two_groups", "a_priori", delta_slope = 0.1,
              sd_x1 = 1, sd_x2 = 1, residual_sd = 1, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: t test: Linear Regression (two groups)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   delta_slope: 0.1
#>   residual_sd: 1
#>   sd_x1: 1
#>   sd_x2: 1
#>   alpha: 0.05
#>   sample_size_group_1: 1571
#>   sample_size_group_2: 1571
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.802677
#>   critical_t: -1.96072,  1.96072
#>   df: 3138
#>   total_sample_size: 3142
#>   actual_power: 0.8000665
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Generic t (direct NCP)

No `a_priori` mode — supply NCP and df directly.

``` r

power_compute("t_generic", "post_hoc", ncp = 3, df = 29, alpha = 0.05, tails = "two")
#> ggpower result
#> Test: t test: Generic case
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   noncentrality_parameter: 3
#>   alpha: 0.05
#>   df: 29
#> 
#> 
#> Output parameters
#>   critical_t: -2.04523,  2.04523
#>   power: 0.8262306
#> 
#> 
#> Notes
#> - Generic t tests do not have a unique sample-size definition, so a priori mode is not available.
```

## Related

- [Analysis
  modes](https://yaoxiangli.github.io/ggpower/articles/analysis-modes.md)
- [Workspace test
  families](https://yaoxiangli.github.io/ggpower/articles/workspace-test-families.md)
