# Exact and Proportion Tests

Exact and proportion tests for binary outcomes.

## Generic binomial

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

## One proportion vs constant

``` r

power_compute("exact_one_proportion", "a_priori", p0 = 0.5, p1 = 0.7,
              alpha = 0.05, power = 0.8, tails = "two")
#> ggpower result
#> Test: Exact: Proportion: Difference from constant
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two.sided
#>   p_h0: 0.5
#>   p_h1: 0.7
#>   alpha: 0.05
#>   total_sample_size: 54
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   actual_power: 0.8367644
#> 
#> 
#> Notes
#> - Exact binomial power sums probabilities for outcomes whose exact binomial-test p-value is at or below alpha.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Sign test

``` r

power_compute("exact_sign", "post_hoc", p0 = 0.5, p1 = 0.65, n = 50, alpha = 0.05)
#> ggpower result
#> Test: Exact: Proportion: Sign test
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two.sided
#>   p_h0: 0.5
#>   p_h1: 0.65
#>   alpha: 0.05
#>   total_sample_size: 50
#> 
#> 
#> Output parameters
#>   power: 0.5059799
#> 
#> 
#> Notes
#> - Exact binomial power sums probabilities for outcomes whose exact binomial-test p-value is at or below alpha.
```

## Fisher exact (two proportions)

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

## McNemar (approximation)

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

## Chi-square contingency (Cohen’s w)

``` r

w <- effect_size_w(c(.25, .25, .25, .25), c(.35, .15, .30, .20))
power_compute("chisq_contingency", "a_priori", w = w, alpha = 0.05, power = 0.8,
              groups = 4)
#> ggpower result
#> Test: chi-square test: Contingency tables
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

## Related

- [Approximation
  catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.md)
