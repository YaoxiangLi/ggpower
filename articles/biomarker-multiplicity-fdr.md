# Multiplicity and FDR

Screening power under Benjamini-Hochberg FDR control for omics panels.

## Formula

Independent two-sample $`t`$ tests with proportion $`\pi_0`$ true nulls;
BH at level $`q`$.

## Post hoc (recommended)

``` r

power_compute("discovery_fdr", "post_hoc", effect_d = 0.5, m_tests = 1000,
              pi0 = 0.9, fdr_level = 0.05, n = 40, alpha = 0.05)
#> ggpower result
#> Test: Biomarker: Discovery power under FDR control
#> Analysis: post_hoc
#> 
#> Input parameters
#>   m_tests: 1000
#>   proportion_null: 0.9
#>   effect_size_d: 0.5
#>   n_per_comparison: 40
#>   fdr_level: 0.05
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   alternative_hypotheses: 100
#>   single_test_power: 0.8693981
#>   expected_discoveries: 86.93981
#>   expected_fdr: 0.5175995
#>   power: 0.08398368
#> 
#> 
#> Notes
#> - BH-FDR framework with independent t-test approximations per biomarker.
```

For `a_priori` and `sensitivity` modes, use smaller `m_tests` or higher
`effect_d` — large panels may not reach target power within the solver
search range.

## Related

- [Differential
  expression](https://yaoxiangli.github.io/ggpower/articles/biomarker-differential-expression.md)
- [Approximation
  catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.md)
