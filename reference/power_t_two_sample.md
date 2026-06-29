# Compute Power for a Two-Sample t-Test (Equal Sample Sizes)

This function calculates the power for a two-sample t-test when the two
groups have equal sample sizes.

## Usage

``` r
power_t_two_sample(d, n_per_group, alpha = 0.05, tails = "two", n2 = NULL)
```

## Arguments

- d:

  Numeric. The effect size (Cohen's d).

- n_per_group:

  Integer. The sample size per group.

- alpha:

  Numeric. The significance level (default is 0.05).

- tails:

  Character. `"two"` for a two-tailed test or `"one"` for a one-tailed
  test.

- n2:

  Optional second-group sample size. If omitted, equal group sizes are
  used.

## Value

Numeric. The computed power (1 - beta).

## Examples

``` r
# Compute power for an effect size d = 0.5 with 30 subjects per group
power_t_two_sample(d = 0.5, n_per_group = 30)
#> [1] 0.4778965
```
