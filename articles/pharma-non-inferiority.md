# Non-Inferiority Trials

Non-inferiority tests whether a new treatment is not worse than control
by more than a pre-specified margin $`\Delta`$.

## Continuous NI

``` math
H_0: \mu_T - \mu_C \le -\Delta \quad \text{vs} \quad H_1: \mu_T - \mu_C > -\Delta
```

``` r

power_compute("rct_noninferiority_continuous", "a_priori", d = 0.1,
              ni_margin = 0.2, alpha = 0.025, power = 0.8, n1 = 100, n2 = 100)
#> ggpower result
#> Test: Clinical: Non-inferiority trial (continuous)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: one
#>   effect_size_d: 0.1
#>   ni_margin: 0.2
#>   sample_size_group_1: 175
#>   sample_size_group_2: 176
#>   alpha: 0.025
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.810238
#>   critical_t: 1.966785
#>   df: 349
#>   total_sample_size: 351
#>   actual_power: 0.800255
#> 
#> 
#> Notes
#> - One-sided NI test: H0 difference <= -margin vs H1 difference > -margin.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Binary NI (normal approximation)

``` r

power_compute("rct_noninferiority_binary", "post_hoc", p0 = 0.5, p1 = 0.55,
              ni_margin = 0.1, alpha = 0.025, n1 = 200, n2 = 200)
#> ggpower result
#> Test: Clinical: Non-inferiority trial (binary)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: one
#>   p_treatment: 0.55
#>   p_control: 0.5
#>   ni_margin: 0.1
#>   sample_size_group_1: 200
#>   sample_size_group_2: 200
#>   alpha: 0.025
#> 
#> 
#> Output parameters
#>   z_statistic: 3.007528
#>   total_sample_size: 400
#>   power: 0.8525803
#> 
#> 
#> Notes
#> - Normal approximation for NI on proportions (one-sided).
```

## Related

- [Equivalence
  (TOST)](https://yaoxiangli.github.io/ggpower/articles/pharma-equivalence-tost.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
