# Plot Power Curve for a Two-Sample t-Test

This function creates a ggplot2 power curve for a two-sample t test.

## Usage

``` r
ggpower_ttest(d, alpha = 0.05, n_range = seq(10, 100, by = 5),
  tails = "two")
```

## Arguments

- d:

  Numeric. The effect size (Cohen's d).

- alpha:

  Numeric. The significance level (default 0.05).

- n_range:

  Numeric vector. A vector of sample sizes per group (default is seq(10,
  100, by = 5)).

- tails:

  Character. `"two"` or `"one"`.

## Value

A ggplot object showing the power curve.

## Examples

``` r
# Create a power curve for d = 0.5 over a range of sample sizes per group
ggpower_ttest(d = 0.5, alpha = 0.05, n_range = seq(10, 100, by = 5))
```
