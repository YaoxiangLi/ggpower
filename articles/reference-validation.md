# Reference Validation

ggpower validates core kernels against published reference examples.
Direct noncentral t, F, normal, and chi-square procedures use tight
tolerances. Exact enumeration is used where the grid is computationally
feasible. Approximation-backed procedures report method notes in the
result object.

## Example 1: One-sample t, a priori

Target: $`d = 0.625`$, $`\alpha = 0.05`$ (one-tailed), power $`= 0.95`$.

**Expected:** $`n = 30`$, actual power $`\approx 0.955144`$,
$`df = 29`$.

``` r

r1 <- power_compute("t_one_sample", "a_priori", d = 0.625, alpha = 0.05,
                      power = 0.95, tails = "one")
r1$outputs[c("total_sample_size", "actual_power", "df")]
#> $<NA>
#> NULL
#> 
#> $actual_power
#> [1] 0.9551444
#> 
#> $df
#> [1] 29
```

## Example 2: Multiple regression omnibus, post hoc

$`f^2 = 0.1111111`$, $`\alpha = 0.05`$, $`N = 95`$, 5 predictors.

**Expected:** $`\lambda \approx 10.556`$, critical $`F \approx 2.317`$,
$`df_2 = 89`$, power $`\approx 0.674`$.

``` r

r2 <- power_compute("f_mreg_omnibus", "post_hoc", f2 = 0.1111111,
                      alpha = 0.05, total_n = 95, predictors = 5)
r2$outputs[c("noncentrality_parameter", "critical_f", "denominator_df", "power")]
#> $noncentrality_parameter
#> [1] 10.55555
#> 
#> $critical_f
#> [1] 2.316858
#> 
#> $denominator_df
#> [1] 89
#> 
#> $power
#> [1] 0.6735857
```

## Example 3: ANOVA special, post hoc

$`f = 0.2450722`$, $`N = 108`$, $`df_1 = 4`$, 36 groups.

**Expected:** $`\lambda \approx 6.487`$, $`df_2 = 72`$, power
$`\approx 0.476`$.

``` r

r3 <- power_compute("f_anova_special", "post_hoc", f = 0.2450722,
                      alpha = 0.05, total_n = 108, df1 = 4, groups = 36)
r3$outputs[c("noncentrality_parameter", "denominator_df", "power")]
#> $noncentrality_parameter
#> [1] 6.486521
#> 
#> $denominator_df
#> [1] 72
#> 
#> $power
#> [1] 0.4756346
```

## Example 4: Two-sample t, unequal n, post hoc

$`d = 0.5`$, $`n_1 = 4`$, $`n_2 = 8`$, one-tailed $`\alpha = 0.05`$.

**Expected:** $`\delta \approx 0.816`$, $`df = 10`$, power
$`\approx 0.189`$.

``` r

r4 <- power_compute("t_two_sample", "post_hoc", d = 0.5, n1 = 4, n2 = 8,
                      alpha = 0.05, tails = "one")
r4$outputs[c("noncentrality_parameter", "df", "power")]
#> $noncentrality_parameter
#> [1] 0.8164966
#> 
#> $df
#> [1] 10
#> 
#> $power
#> [1] 0.1886663
```

## Recommended tolerances

| Kernel type | Tolerance |
|----|----|
| Direct distribution (t, F, z, $`\chi^2`$) | $`10^{-5}`$ to $`10^{-4}`$ |
| Integer a priori solvers | Sample size exact; actual power $`\geq`$ target |
| Approximation-backed | Document method; validate with sensitivity plots |

## Related

- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
- [Approximation
  catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.html)
  (pkgdown only)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.html)
  (pkgdown only)
