# Calculator

The **Calculator** module in
[`run_app()`](https://yaoxiangli.github.io/ggpower/reference/run_app.md)
evaluates distribution-function scripts. The same engine is available as
[`ggpower_calculator()`](https://yaoxiangli.github.io/ggpower/reference/ggpower_calculator.md).

## Basic arithmetic

``` r

ggpower_calculator("2^3 + 1")
#> [1] 9
```

## Inverse normal

``` r

ggpower_calculator("zinv(0.975)")
#> [1] 1.959964
```

## Noncentral t CDF

``` r

ggpower_calculator("nctcdf(1.699127, 29, 3.423266)")
#> [1] 0.04485563
```

## Multi-line script

``` r

ggpower_calculator("alpha <- 0.05
nctcdf(1.699127, 29, 3.423266)")
#> [1] 0.04485563
```

## Available helpers

Common functions: `zcdf`, `zinv`, `tcdf`, `tinv`, `fcdf`, `finv`,
`chisqcdf`, `chisqinv`, `ncfcdf`, `nctcdf`, `binomcdf`, and assignment
with `<-`.

## Related

- [Getting started with the
  GUI](https://yaoxiangli.github.io/ggpower/articles/getting-started-gui.md)
- [Formula
  reference](https://yaoxiangli.github.io/ggpower/articles/formula-reference.md)
