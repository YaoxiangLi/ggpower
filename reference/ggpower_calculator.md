# Evaluate a ggpower calculator script

Evaluates distribution-function calculator expressions, including
helpers such as `zcdf()`, `tinv()`, `ncfcdf()`, and `binocdf()`.

## Usage

``` r
ggpower_calculator(script)
```

## Arguments

- script:

  Character calculator script with arithmetic, assignments, comments,
  and supported distribution helper functions.

## Value

The value of the final expression.

## Examples

``` r
ggpower_calculator("x <- 2^3\nx + zinv(.975)")
#> [1] 9.959964
```
