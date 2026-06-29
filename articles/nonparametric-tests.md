# Nonparametric Tests

Nonparametric tests use asymptotic relative efficiency (ARE) to map
rank-test planning to equivalent t-test noncentrality:

``` math
d_{\text{eff}} = d \cdot \sqrt{\text{ARE}}
```

See [approximation
catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.md).

## Wilcoxon Signed-Rank

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

## Wilcoxon-Mann-Whitney

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

Use a smaller ARE for conservative planning and a larger ARE when the
parent distribution makes the rank test more efficient than the t-test.
