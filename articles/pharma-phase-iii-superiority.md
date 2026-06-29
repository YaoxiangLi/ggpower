# Phase III Superiority Trials

Superiority trials test whether the new treatment is better than
control.

## Continuous endpoint (one-sided)

``` r

power_compute(
  "rct_superiority_continuous",
  analysis = "post_hoc",
  d = 0.4,
  alpha = 0.025,
  n1 = 120,
  n2 = 120
)
#> ggpower result
#> Test: Clinical: RCT superiority (continuous endpoint)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.4
#>   alpha: 0.025
#>   sample_size_group_1: 120
#>   sample_size_group_2: 120
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.098387
#>   critical_t: 1.969982
#>   df: 238
#>   total_sample_size: 240
#>   power: 0.8698953
```

## Binary endpoint

``` r

power_compute(
  "rct_superiority_binary",
  analysis = "a_priori",
  p0 = 0.3,
  p1 = 0.45,
  alpha = 0.025,
  power = 0.9,
  n1 = 50,
  n2 = 50
)
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> ggpower result
#> Test: Clinical: RCT superiority (binary endpoint)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: less
#>   p_group_1: 0.3
#>   p_group_2: 0.45
#>   alpha: 0.025
#>   sample_size_group_1: 217
#>   sample_size_group_2: 217
#>   target_power: 0.9
#> 
#> 
#> Output parameters
#>   effect_size_h: 0.3113494
#>   total_sample_size: 434
#>   actual_power: 0.9002812
#> 
#> 
#> Notes
#> - Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Multi-arm superiority (ANOVA wrapper)

``` r

power_compute("multi_arm_superiority", "a_priori", f = 0.25, groups = 3,
              alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Multi-arm superiority (ANOVA)
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_f: 0.25
#>   alpha: 0.05
#>   total_sample_size: 158
#>   groups: 3
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 9.875
#>   critical_f: 3.054385
#>   numerator_df: 2
#>   denominator_df: 155
#>   actual_power: 0.8021998
#> 
#> 
#> Notes
#> - Consider Dunnett adjustment for pairwise comparisons.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [Non-inferiority](https://yaoxiangli.github.io/ggpower/articles/pharma-non-inferiority.md)
- [Survival
  endpoints](https://yaoxiangli.github.io/ggpower/articles/pharma-survival-endpoints.md)
