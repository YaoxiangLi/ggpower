# Equivalence Trials (TOST)

Two one-sided tests (TOST) for bioequivalence and similarity trials.

## Formula

``` math
\text{Power}_{\text{TOST}} \approx \text{Power}_{\text{upper}} \times \text{Power}_{\text{lower}}
```

## Continuous equivalence

``` r

power_compute("rct_equivalence_continuous", "a_priori", d = 0,
              eq_margin = 0.2, alpha = 0.05, power = 0.8, n1 = 80, n2 = 80)
#> ggpower result
#> Test: Clinical: Equivalence trial (continuous, TOST)
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_d: 0
#>   eq_margin: 0.2
#>   sample_size_group_1: 420
#>   sample_size_group_2: 420
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   power_upper: 0.8945475
#>   power_lower: 0.8945475
#>   total_sample_size: 840
#>   actual_power: 0.8002153
#> 
#> 
#> Notes
#> - Two one-sided t tests (TOST); overall power is the product of both one-sided powers.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Proportion equivalence

``` r

power_compute("rct_equivalence_proportion", "post_hoc", p0 = 0.5, p1 = 0.52,
              eq_margin = 0.1, alpha = 0.05, n1 = 150, n2 = 150)
#> ggpower result
#> Test: Clinical: Equivalence trial (proportions, TOST)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   p_treatment: 0.52
#>   p_control: 0.5
#>   eq_margin: 0.1
#>   sample_size_group_1: 150
#>   sample_size_group_2: 150
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   power_upper: 0.3979494
#>   power_lower: 0.6680152
#>   total_sample_size: 300
#>   power: 0.2658363
#> 
#> 
#> Notes
#> - TOST on proportion difference using normal approximation.
```

## Related

- [Non-inferiority](https://yaoxiangli.github.io/ggpower/articles/pharma-non-inferiority.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
