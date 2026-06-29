# Cluster RCT

Cluster-randomized trials with design effect from intraclass
correlation.

## Formula

``` math
\text{DE} = 1 + (m - 1) \cdot \text{ICC}
```

``` r

power_compute("cluster_rct", "a_priori", d = 0.4, icc = 0.05,
              cluster_size = 10, n_clusters = 20, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Cluster-randomized trial
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.4
#>   icc: 0.05
#>   cluster_size: 10
#>   n_clusters_per_arm: 16
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   design_effect: 1.45
#>   effective_n_per_arm: 110.3448
#>   noncentrality_parameter: 2.971125
#>   total_sample_size: 320
#>   actual_power: 0.8198668
#> 
#> 
#> Notes
#> - Design effect DE = 1 + (m-1)*ICC applied to two-arm cluster RCT.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Post hoc

``` r

power_compute("cluster_rct", "post_hoc", d = 0.35, icc = 0.05,
              cluster_size = 12, n_clusters = 25, alpha = 0.05)
#> ggpower result
#> Test: Clinical: Cluster-randomized trial
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.35
#>   icc: 0.05
#>   cluster_size: 12
#>   n_clusters_per_arm: 25
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   design_effect: 1.55
#>   effective_n_per_arm: 193.5484
#>   noncentrality_parameter: 3.443086
#>   power: 0.9212387
#>   total_sample_size: 600
#> 
#> 
#> Notes
#> - Design effect DE = 1 + (m-1)*ICC applied to two-arm cluster RCT.
```

## Related

- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
- [Phase III
  superiority](https://yaoxiangli.github.io/ggpower/articles/pharma-phase-iii-superiority.md)
