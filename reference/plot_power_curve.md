# Plot a power curve

Builds a publication-ready power curve for a selected ggpower test.

## Usage

``` r
plot_power_curve(test, n_values, analysis = "post_hoc", ...)
```

## Arguments

- test:

  Character test id.

- n_values:

  Numeric vector of total sample sizes.

- analysis:

  Power analysis mode used for fixed parameters.

- ...:

  Test-specific fixed parameters.

## Value

A ggplot object.

## Examples

``` r
plot_power_curve("t_one_sample", n_values = c(20, 30, 40), d = 0.5)
```
