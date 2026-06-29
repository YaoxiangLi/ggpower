# Simon Two-Stage Design

Simon optimal two-stage design for single-arm Phase II oncology trials.

## Formula

Stage-wise binomial operating characteristics under $`p_0`$ (null) and
$`p_1`$ (target).

**Modes:** `post_hoc` and `sensitivity` only (no sample-size solver).

## Post hoc power

``` r
power_compute("simon_two_stage", "post_hoc", p0 = 0.2, p1 = 0.4,
              r1 = 4, r = 10, n1 = 20, n2 = 20, alpha = 0.05)
#> ggpower result
#> Test: Clinical: Simon two-stage Phase II design
#> Analysis: post_hoc
#> 
#> Input parameters
#>   p0: 0.2
#>   p1: 0.4
#>   alpha: 0.05
#>   target_power: 0.8
#>   stage1_n: 20
#>   stage1_r: 4
#>   stage2_n: 20
#>   total_r: 10
#> 
#> 
#> Output parameters
#>   power: 0.9156202
#>   type_i_error: 0.05954113
#>   total_sample_size: 40
#>   expected_sample_size: 38.98096
#> 
#> 
#> Notes
#> - Simon optimal/minimax design power for specified (n1,r1,n2,r).
```

## Sensitivity — detectable response rate

``` r
power_compute("simon_two_stage", "sensitivity", p0 = 0.2, r1 = 4, r = 10,
              n1 = 20, n2 = 20, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Simon two-stage Phase II design
#> Analysis: sensitivity
#> 
#> Input parameters
#>   p0: 0.2
#>   p1: 0.3567316
#>   alpha: 0.05
#>   target_power: 0.8
#>   stage1_n: 20
#>   stage1_r: 4
#>   stage2_n: 20
#>   total_r: 10
#> 
#> 
#> Output parameters
#>   power: 0.8
#>   type_i_error: 0.05954113
#>   total_sample_size: 40
#>   expected_sample_size: 37.87125
#>   p1: 0.3567316
#> 
#> 
#> Notes
#> - Simon optimal/minimax design power for specified (n1,r1,n2,r).
```

## Related

- [Scenario
  guide](https://yaoxiangli.github.io/ggpower/articles/scenario-guide.md)
  — design search not yet implemented
- [Binary
  endpoints](https://yaoxiangli.github.io/ggpower/articles/pharma-binary-and-count-endpoints.md)
