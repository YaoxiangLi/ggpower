# Plot Power Curve for a One-Sample t-Test

This function creates a ggplot2 power curve for a one-sample t test.

## Usage

``` r
ggpower_t_one_sample(d, alpha = 0.05, n_range = seq(20, 100, by = 5),
  tails = "two")
```

## Arguments

- d:

  Numeric. The effect size (d).

- alpha:

  Numeric. The significance level (default 0.05).

- n_range:

  Numeric vector. A vector of total sample sizes (default is seq(20,
  100, by = 5)).

- tails:

  Character. `"two"` or `"one"`.

## Value

A ggplot object showing the power curve.

## Examples

``` r
# Plot power curve for d = 0.5 over sample sizes from 20 to 100
ggpower_t_one_sample(d = 0.5, alpha = 0.05, n_range = seq(20, 100, by = 5))
```
