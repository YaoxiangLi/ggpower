# Cox Prognostic Models

Power for a single covariate Cox proportional hazards model.

## Formula

``` math
z \approx |\log(\text{HR})| \sqrt{E}
```

where $`E`$ is the expected number of events.

## Post hoc

``` r
power_compute("cox_regression", "post_hoc", hazard_ratio = 0.65,
              events = 100, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Cox proportional hazards (single covariate)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   events: 100
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   z_statistic: 4.307829
#>   power: 0.9905593
#> 
#> 
#> Notes
#> - Wald test power from expected number of events.
```

## A priori events

``` r
power_compute("cox_regression", "a_priori", hazard_ratio = 0.7,
              alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Biomarker: Cox proportional hazards (single covariate)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.7
#>   events: 62
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   z_statistic: 2.808461
#>   actual_power: 0.8019204
#> 
#> 
#> Notes
#> - Wald test power from expected number of events.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [Biomarker
  survival](https://yaoxiangli.github.io/ggpower/articles/biomarker-survival.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
