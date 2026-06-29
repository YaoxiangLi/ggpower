# Compute Power for a One-Sample t-Test

Calculates the power for a one-sample t-test given the effect size (d),
total sample size (n), and significance level (alpha).

## Usage

``` r
power_t_one_sample(d, n, alpha = 0.05, tails = "two")
```

## Arguments

- d:

  Numeric. The effect size (difference from the constant divided by
  sigma).

- n:

  Integer. Total sample size.

- alpha:

  Numeric. The significance level (default is 0.05).

- tails:

  Character. `"two"` for a two-tailed test or `"one"` for a one-tailed
  test.

## Value

Numeric. The computed power (1 - beta).

## Examples

``` r
# Calculate power for an effect size of 0.5 with n = 40 subjects
power_t_one_sample(d = 0.5, n = 40, alpha = 0.05)
#> [1] 0.8693981
```
