# Survival Endpoints

Event-driven sample size for OS, PFS, and other time-to-event primary
endpoints.

## Formula

Log-rank approximation — see [formula
reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md).

## Clinical survival module

``` r

power_compute("survival_pmu", "a_priori", hazard_ratio = 0.65,
              event_rate = 0.5, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Survival endpoint (log-rank / Cox framework)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   event_rate: 0.5
#>   allocation_ratio: 1
#>   total_sample_size: 339
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   expected_events: 169.5
#>   z_statistic: 2.804228
#>   actual_power: 0.80074
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Post hoc

``` r

power_compute("survival_pmu", "post_hoc", hazard_ratio = 0.7,
              total_n = 300, event_rate = 0.45, alpha = 0.05)
#> ggpower result
#> Test: Clinical: Survival endpoint (log-rank / Cox framework)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.7
#>   event_rate: 0.45
#>   allocation_ratio: 1
#>   total_sample_size: 300
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   expected_events: 135
#>   z_statistic: 2.072094
#>   power: 0.5446676
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
```

## Related

- [Biomarker
  survival](https://yaoxiangli.github.io/ggpower/articles/biomarker-survival.md)
- [Cox
  prognostic](https://yaoxiangli.github.io/ggpower/articles/biomarker-cox-prognostic.md)
