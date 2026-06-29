# Biomarker Differential Expression

Two-group mean difference for expression biomarkers (wrapper around
`t_two_sample`).

## Formula

``` math
d = \frac{\mu_1 - \mu_2}{\sigma}, \quad \delta = d\sqrt{\frac{n_1 n_2}{n_1+n_2}}
```

## Post hoc power

``` r

power_compute("ttest_biomarker", "post_hoc", d = 0.6, n1 = 40, n2 = 40,
              alpha = 0.05, tails = "two")
#> ggpower result
#> Test: Biomarker: Two-group differential expression (t test)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: two
#>   alpha: 0.05
#>   sample_size_group_1: 40
#>   sample_size_group_2: 40
#>   log_fold_change_sd: 0.6
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.683282
#>   critical_t: -1.990847,  1.990847
#>   df: 78
#>   total_sample_size: 80
#>   power: 0.7549516
```

## A priori sample size

``` r

power_compute("ttest_biomarker", "a_priori", d = 0.5, alpha = 0.05,
              power = 0.8, allocation_ratio = 1)
#> ggpower result
#> Test: Biomarker: Two-group differential expression (t test)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   alpha: 0.05
#>   sample_size_group_1: 64
#>   sample_size_group_2: 64
#>   log_fold_change_sd: 0.5
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.828427
#>   critical_t: -1.978971,  1.978971
#>   df: 126
#>   total_sample_size: 128
#>   actual_power: 0.8014596
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [t Tests](https://yaoxiangli.github.io/ggpower/articles/t-tests.md)
- [Multiplicity and
  FDR](https://yaoxiangli.github.io/ggpower/articles/biomarker-multiplicity-fdr.md)
