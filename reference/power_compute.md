# Compute statistical power analyses

Runs a power analysis using the shared ggpower compute engine. The
function supports classical test families and analysis modes.

## Usage

``` r
power_compute(test, analysis = "post_hoc", ...)
```

## Arguments

- test:

  Character test id. Use
  [`ggpower_tests()`](https://yaoxiangli.github.io/ggpower/reference/ggpower_tests.md)
  to list available ids.

- analysis:

  One of `"a_priori"`, `"compromise"`, `"criterion"`, `"post_hoc"`, or
  `"sensitivity"`.

- ...:

  Test-specific input parameters.

## Value

A `ggpower_result` object.

## Examples

``` r
power_compute("t_one_sample", "a_priori", d = 0.625, alpha = 0.05,
  power = 0.95, tails = "one")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.625
#>   alpha: 0.05
#>   total_sample_size: 30
#>   target_power: 0.95
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.423266
#>   critical_t: 1.699127
#>   df: 29
#>   actual_power: 0.9551444
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
#> 
```
