# Workspace Test Families

The **Power Workspace** module registers classical test families. This
vignette summarizes ANOVA/regression, exact proportions, correlations,
GLM, and nonparametric tests. See [t
Tests](https://yaoxiangli.github.io/ggpower/articles/t-tests.md) for the
t-test family.

## ANOVA and regression

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

## Exact and proportion tests

``` r

power_compute("exact_binomial", "post_hoc", p0 = 0.5, p1 = 0.65,
              n = 80, alpha = 0.05, tails = "one")
#> ggpower result
#> Test: Exact: Generic binomial test
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: greater
#>   p_h0: 0.5
#>   p_h1: 0.65
#>   alpha: 0.05
#>   total_sample_size: 80
#> 
#> 
#> Output parameters
#>   power: 0.8540286
#> 
#> 
#> Notes
#> - Exact binomial power sums probabilities for outcomes whose exact binomial-test p-value is at or below alpha.
```

``` r

power_compute("exact_fisher", "post_hoc", p0 = 0.4, p1 = 0.7,
              n1 = 12, n2 = 12, alpha = 0.05, tails = "greater")
#> ggpower result
#> Test: Exact: Proportions - inequality of two independent groups (Fisher exact)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: less
#>   p_group_1: 0.4
#>   p_group_2: 0.7
#>   alpha: 0.05
#>   sample_size_group_1: 12
#>   sample_size_group_2: 12
#> 
#> 
#> Output parameters
#>   effect_size_h: 0.6128748
#>   total_sample_size: 24
#>   power: 0.3571413
#> 
#> 
#> Notes
#> - Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.
```

``` r

power_compute("exact_mcnemar", "post_hoc", p0 = 0.5, p1 = 0.65, n = 60, alpha = 0.05)
#> ggpower result
#> Test: Exact: McNemar test approximation through discordant-pair binomial test
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two.sided
#>   p_h0: 0.5
#>   p_h1: 0.65
#>   alpha: 0.05
#>   total_sample_size: 60
#> 
#> 
#> Output parameters
#>   power: 0.5590343
#> 
#> 
#> Notes
#> - Exact binomial power sums probabilities for outcomes whose exact binomial-test p-value is at or below alpha.
```

## Correlation and z tests

``` r

q <- effect_size_q(0.75, 0.88)
power_compute("z_corr_independent", "post_hoc", q_effect = q,
              n1 = 51, n2 = 260, alpha = 0.05)
#> ggpower result
#> Test: z test: Correlation - inequality of two independent Pearson r's
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   effect_size_q: -0.4028126
#>   alpha: 0.05
#>   sample_size_group_1: 51
#>   sample_size_group_2: 260
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   total_sample_size: 311
#>   power: 0.7263517
```

``` r

power_compute("z_logistic", "a_priori", odds_ratio = 1.5, p0 = 0.5,
              alpha = 0.05, power = 0.95, total_n = 300,
              r2_other = 0, x_variance = 1)
#> ggpower result
#> Test: z test: Multiple logistic regression
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   odds_ratio: 1.5
#>   p_h0: 0.5
#>   alpha: 0.05
#>   total_sample_size: 317
#>   r2_other_x: 0
#>   x_variance: 1
#>   target_power: 0.95
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   beta1: 0.4054651
#>   actual_power: 0.9504862
#> 
#> 
#> Notes
#> - Logistic regression support uses a large-sample Wald approximation suitable for planning; enumeration and Demidenko variants can be added later.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Logistic and Poisson regression

``` r

power_compute("z_poisson", "a_priori", exp_beta1 = 1.3,
              base_rate = 0.85, exposure = 1, alpha = 0.05,
              power = 0.95, r2_other = 0, x_variance = 0.25)
#> ggpower result
#> Test: z test: Poisson regression
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   exp_beta1: 1.3
#>   base_rate: 0.85
#>   exposure: 1
#>   alpha: 0.05
#>   total_sample_size: 889
#>   r2_other_x: 0
#>   x_variance: 0.25
#>   target_power: 0.95
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   beta1: 0.2623643
#>   actual_power: 0.9501298
#> 
#> 
#> Notes
#> - Poisson regression support uses a large-sample Wald approximation; exact enumeration is a future refinement.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Nonparametric tests

Nonparametric tests map rank-test planning to t-test noncentrality via
ARE: $`d_{\text{eff}} = d \cdot \sqrt{\text{ARE}}`$.

``` r

power_compute("wilcoxon_signed", "post_hoc", d = 0.5, n = 40,
              alpha = 0.05, are = 3 / pi)
#> ggpower result
#> Test: Wilcoxon signed-rank test: Means - difference from constant or matched pairs
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.05
#>   total_sample_size: 38
#>   asymptotic_relative_efficiency: 0.9549297
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.082207
#>   critical_t: -2.026192,  2.026192
#>   df: 37
#>   power: 0.8511398
#> 
#> 
#> Notes
#> - Wilcoxon signed-rank support uses the A.R.E. method and reuses the matched/one-sample t-test kernel.
```

``` r

power_compute("wilcoxon_mann_whitney", "post_hoc", d = 0.5,
              n1 = 30, n2 = 30, alpha = 0.05, are = 3 / pi)
#> ggpower result
#> Test: Wilcoxon-Mann-Whitney test of a difference between two independent means
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.05
#>   sample_size_group_1: 28
#>   sample_size_group_2: 28
#>   asymptotic_relative_efficiency: 0.9549297
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 1.870829
#>   critical_t: -2.004879,  2.004879
#>   df: 54
#>   total_sample_size: 56
#>   power: 0.4513506
#> 
#> 
#> Notes
#> - Wilcoxon-Mann-Whitney support uses the A.R.E. method and reuses the two-sample t-test kernel.
```

## Related

- [t Tests](https://yaoxiangli.github.io/ggpower/articles/t-tests.md)
- [Analysis
  modes](https://yaoxiangli.github.io/ggpower/articles/analysis-modes.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
