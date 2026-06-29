# Compute power for a paired-samples t-test

Computes achieved power for a paired-samples t-test using the noncentral
t kernel.

## Usage

``` r
power_t_paired(d, n, alpha = 0.05, tails = "two")
```

## Arguments

- d:

  Numeric paired-samples effect size dz.

- n:

  Integer number of pairs.

- alpha:

  Numeric significance level.

- tails:

  Character, `"two"` or `"one"`.

## Value

Numeric power.

## Examples

``` r
power_t_paired(d = 0.5, n = 40)
#> [1] 0.8693981
```
