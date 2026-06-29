# Effect Size Conversions

Helper functions convert study parameters into effect sizes used by
[`power_compute()`](https://yaoxiangli.github.io/ggpower/reference/power_compute.md).

## Cohen’s d

``` math
d = \frac{\mu_1 - \mu_0}{\sigma}
```

``` r
effect_size_d(mean_h1 = 15, mean_h0 = 10, sd = 8)
#> [1] 0.625
```

## Cohen’s f from $`\eta^2`$

``` math
f = \sqrt{\frac{\eta^2}{1-\eta^2}}
```

``` r
effect_size_f(eta2 = 0.06)
#> [1] 0.2526456
eta2_from_f(0.25)
#> [1] 0.05882353
```

## Cohen’s $`f^2`$ from $`R^2`$

``` math
f^2 = \frac{R^2}{1-R^2}
```

``` r
effect_size_f2(r2 = 0.1)
#> [1] 0.1111111
r2_from_f2(0.1111111)
#> [1] 0.09999999
```

## $`R^2`$ increase

``` math
f^2 = \frac{R^2_{\text{full}} - R^2_{\text{reduced}}}{1 - R^2_{\text{full}}}
```

``` r
effect_size_f2_increase(r2_full = 0.2, r2_reduced = 0.1)
#> [1] 0.125
```

## Cohen’s w (chi-square)

``` math
w = \sqrt{\sum_i \frac{(p_{1i} - p_{0i})^2}{p_{0i}}}
```

``` r
effect_size_w(p0 = c(0.25, 0.25, 0.25, 0.25), p1 = c(0.4, 0.3, 0.2, 0.1))
#> [1] 0.4472136
```

## Cohen’s h (proportions)

``` math
h = 2\arcsin(\sqrt{p_1}) - 2\arcsin(\sqrt{p_0})
```

``` r
effect_size_h(p1 = 0.45, p2 = 0.3)
#> [1] 0.3113494
```

## Related

- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
- [t Tests](https://yaoxiangli.github.io/ggpower/articles/t-tests.md)
