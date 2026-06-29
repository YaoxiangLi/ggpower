# Logistic and Poisson Regression

GLM power for binary and count outcomes (Wald normal approximation).

## Logistic regression

``` math
z = \frac{\log(\text{OR})}{\text{SE}(\log(\text{OR}))}
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

## Poisson regression

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

## Clinical count endpoint

Same kernel via clinical module wrapper:

``` r

power_compute("count_endpoint_poisson", "post_hoc", exp_beta1 = 1.3,
              base_rate = 0.85, exposure = 1, alpha = 0.05, total_n = 200)
#> ggpower result
#> Test: Clinical: Count endpoint (Poisson regression)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   exp_beta1: 1.3
#>   base_rate: 0.85
#>   exposure: 1
#>   alpha: 0.05
#>   total_sample_size: 200
#>   r2_other_x: 0
#>   x_variance: 1
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   beta1: 0.2623643
#>   power: 0.9279714
#> 
#> 
#> Notes
#> - Poisson regression support uses a large-sample Wald approximation; exact enumeration is a future refinement.
```

## Related

- [Binary and count
  endpoints](https://yaoxiangli.github.io/ggpower/articles/pharma-binary-and-count-endpoints.md)
- [Approximation
  catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.md)
