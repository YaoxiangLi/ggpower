# Analysis Modes

ggpower supports five analysis modes. Each mode solves for a different
unknown given the others.

| Mode | Solves for | When to use |
|----|----|----|
| `a_priori` | Sample size | Planning before data collection |
| `post_hoc` | Power | Fixed sample size, retrospective |
| `criterion` | Alpha | Choose significance level |
| `sensitivity` | Effect size | Minimum detectable effect |
| `compromise` | Alpha and beta | Balance $`\alpha`$ and $`\beta`$ via ratio $`q = \beta/\alpha`$ |

**Restrictions:** `t_generic` has no `a_priori`. `simon_two_stage`
supports only `post_hoc` and `sensitivity`.

## A priori — sample size

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

## Post hoc — achieved power

``` r
power_compute("t_one_sample", "post_hoc", d = 0.625, n = 30,
              alpha = 0.05, tails = "one")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.625
#>   alpha: 0.05
#>   total_sample_size: 30
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.423266
#>   critical_t: 1.699127
#>   df: 29
#>   power: 0.9551444
```

## Criterion — alpha

``` r
power_compute("t_one_sample", "criterion", d = 0.5, n = 40,
              power = 0.8, tails = "two")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: criterion
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.02642633
#>   total_sample_size: 40
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.162278
#>   critical_t: -2.307422,  2.307422
#>   df: 39
#>   power: 0.8
#>   alpha: 0.02642633
#>   beta: 0.2
```

## Sensitivity — effect size

``` r
power_compute("f_mreg_omnibus", "sensitivity", alpha = 0.05, power = 0.8,
              total_n = 100, predictors = 3)
#> ggpower result
#> Test: F test: Multiple Regression - omnibus (deviation of R2 from zero), fixed model
#> Analysis: sensitivity
#> 
#> Input parameters
#>   effect_size_f2: 0.1135624
#>   alpha: 0.05
#>   total_sample_size: 100
#>   predictors: 3
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 11.35624
#>   critical_f: 2.699393
#>   numerator_df: 3
#>   denominator_df: 96
#>   power: 0.8
#>   f2: 0.1135624
```

## Compromise — alpha and beta ratio

``` r
power_compute("t_one_sample", "compromise", d = 0.5, n = 40, q = 1, tails = "two")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: compromise
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.0844535
#>   total_sample_size: 40
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.162278
#>   critical_t: -1.770542,  1.770542
#>   df: 39
#>   power: 0.9155465
#>   alpha: 0.0844535
#>   beta: 0.08445349
#>   beta_alpha_ratio: 1
#> 
#> 
#> Notes
#> - Compromise analysis solves alpha so beta / alpha matches the requested ratio as closely as possible.
```

## Effect size conversions

Helper functions convert study parameters into effect sizes used by
[`power_compute()`](https://yaoxiangli.github.io/ggpower/reference/power_compute.md).

``` r
effect_size_d(mean_h1 = 15, mean_h0 = 10, sd = 8)
#> [1] 0.625
```

``` r
effect_size_f2(r2 = 0.1)
#> [1] 0.1111111
```

``` r
effect_size_w(p0 = c(0.25, 0.25, 0.25, 0.25), p1 = c(0.4, 0.3, 0.2, 0.1))
#> [1] 0.4472136
```

See the pkgdown site for the full [effect size
conversions](https://yaoxiangli.github.io/ggpower/articles/effect-size-conversions.html)
article.

## Calculator

The **Calculator** module evaluates distribution-function scripts via
[`ggpower_calculator()`](https://yaoxiangli.github.io/ggpower/reference/ggpower_calculator.md).

``` r
ggpower_calculator("zinv(0.975)")
#> [1] 1.959964
```

See the pkgdown site for the full
[calculator](https://yaoxiangli.github.io/ggpower/articles/calculator.html)
article.

## Related

- [Choosing a power
  analysis](https://yaoxiangli.github.io/ggpower/articles/choosing-a-power-analysis.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
