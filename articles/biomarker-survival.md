# Biomarker Survival

Log-rank power for biomarker-stratified survival endpoints.

## Formula

``` math
z \approx \frac{|\log(\text{HR})|}{\sqrt{1/D}} \cdot \sqrt{D \cdot p(1-p)}
```

## Post hoc

``` r
power_compute("survival_logrank", "post_hoc", hazard_ratio = 0.65,
              total_n = 200, event_rate = 0.5, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Survival log-rank test
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   event_rate: 0.5
#>   allocation_ratio: 1
#>   total_sample_size: 200
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   expected_events: 100
#>   z_statistic: 2.153915
#>   power: 0.5769122
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
```

## A priori

``` r
power_compute("survival_logrank", "a_priori", hazard_ratio = 0.7,
              event_rate = 0.5, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Biomarker: Survival log-rank test
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.7
#>   event_rate: 0.5
#>   allocation_ratio: 1
#>   total_sample_size: 494
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   expected_events: 247
#>   z_statistic: 2.802793
#>   actual_power: 0.800339
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [Survival endpoints
  (clinical)](https://yaoxiangli.github.io/ggpower/articles/pharma-survival-endpoints.md)
- [Cox prognostic
  models](https://yaoxiangli.github.io/ggpower/articles/biomarker-cox-prognostic.md)
