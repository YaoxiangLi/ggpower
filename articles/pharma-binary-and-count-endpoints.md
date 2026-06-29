# Binary and Count Endpoints

Response rates and count endpoints in clinical trials.

## Binary superiority

``` r
power_compute("rct_superiority_binary", "post_hoc", p0 = 0.3, p1 = 0.45,
              alpha = 0.025, n1 = 120, n2 = 120)
#> ggpower result
#> Test: Clinical: RCT superiority (binary endpoint)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: less
#>   p_group_1: 0.3
#>   p_group_2: 0.45
#>   alpha: 0.025
#>   sample_size_group_1: 120
#>   sample_size_group_2: 120
#> 
#> 
#> Output parameters
#>   effect_size_h: 0.3113494
#>   total_sample_size: 240
#>   power: 0.6319254
#> 
#> 
#> Notes
#> - Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.
```

## Poisson count endpoint

``` r
power_compute("count_endpoint_poisson", "a_priori", exp_beta1 = 1.3,
              base_rate = 0.85, exposure = 1, alpha = 0.05, power = 0.9,
              total_n = 250)
#> ggpower result
#> Test: Clinical: Count endpoint (Poisson regression)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   exp_beta1: 1.3
#>   base_rate: 0.85
#>   exposure: 1
#>   alpha: 0.05
#>   total_sample_size: 180
#>   r2_other_x: 0
#>   x_variance: 1
#>   target_power: 0.9
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   beta1: 0.2623643
#>   actual_power: 0.9006568
#> 
#> 
#> Notes
#> - Poisson regression support uses a large-sample Wald approximation; exact enumeration is a future refinement.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [Logistic and
  Poisson](https://yaoxiangli.github.io/ggpower/articles/logistic-poisson.md)
- [Phase III
  superiority](https://yaoxiangli.github.io/ggpower/articles/pharma-phase-iii-superiority.md)
