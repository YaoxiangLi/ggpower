# Plot H0 and H1 distributions

Builds a publication-ready distribution overlay for a computed
power-analysis result.

## Usage

``` r
plot_distribution(result)
```

## Arguments

- result:

  A `ggpower_result` object.

## Value

A ggplot object.

## Examples

``` r
result <- power_compute("t_one_sample", "post_hoc", d = 0.5, n = 40)
plot_distribution(result)
```
