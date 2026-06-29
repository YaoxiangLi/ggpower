# Correlation and z Tests

z tests for correlations and GLM coefficients.

## Independent correlations

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

## Dependent correlations (common index)

``` r

power_compute("z_corr_dependent_common", "a_priori", rho_ab = 0.4,
              rho_ac = 0.2, rho_bc = 0.5, alpha = 0.05,
              power = 0.8, tails = "one")
#> ggpower result
#> Test: z test: Correlation - inequality of two dependent Pearson r's (common index)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: greater
#>   rho_ab: 0.4
#>   rho_ac: 0.2
#>   rho_bc: 0.5
#>   alpha: 0.05
#>   total_sample_size: 144
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   critical_z: 1.644854
#>   actual_power: 0.8011611
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Dependent correlations (no common index)

``` r

power_compute("z_corr_dependent_no_common", "post_hoc", rho_ab = 0.1,
              rho_cd = 0.2, rho_ac = 0.5, rho_ad = 0.4,
              rho_bc = -0.4, rho_bd = 0.8, n = 200)
#> ggpower result
#> Test: z test: Correlation - inequality of two dependent Pearson r's (no common index)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   rho_ab: 0.1
#>   rho_cd: 0.2
#>   rho_ac: 0.5
#>   rho_ad: 0.4
#>   rho_bc: -0.4
#>   rho_bd: 0.8
#>   alpha: 0.05
#>   total_sample_size: 200
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   power: 0.2166397
```

## Exact correlation (Fisher-Z approximation)

``` r

power_compute("exact_correlation", "post_hoc", rho = 0.3, rho0 = 0,
              n = 50, alpha = 0.05, tails = "two")
#> ggpower result
#> Test: Exact: Correlation - difference from constant (one sample case)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   rho_h0: 0
#>   rho_h1: 0.3
#>   alpha: 0.05
#>   total_sample_size: 50
#> 
#> 
#> Output parameters
#>   effect_size_q: 0.3095196
#>   critical_z: -1.959964,  1.959964
#>   power: 0.5643676
#> 
#> 
#> Notes
#> - Correlation support uses Fisher Z approximation; exact small-sample correlation distribution is planned.
```

## Tetrachoric correlation (approximation)

``` r

power_compute("z_tetrachoric", "post_hoc", rho = 0.4, n = 100, alpha = 0.05)
#> ggpower result
#> Test: z test: Tetrachoric correlation
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   rho_h0: 0
#>   rho_h1: 0.4
#>   alpha: 0.05
#>   total_sample_size: 100
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   power: 0.9865337
#> 
#> 
#> Notes
#> - Tetrachoric correlation currently uses the large-sample Fisher-Z style planning approximation.
```

## Logistic regression

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

## Related

- [Logistic and
  Poisson](https://yaoxiangli.github.io/ggpower/articles/logistic-poisson.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
