# Publication-Ready Figures

ggpower provides plotting helpers with consistent typography and
export-ready styling.

## Power Curve

``` r
plot_power_curve("t_one_sample", n_values = seq(20, 100, by = 10),
                 d = 0.5, alpha = 0.05)
```

## Distribution Overlay

``` r
result <- power_compute("t_one_sample", "post_hoc", d = 0.5, n = 40)
plot_distribution(result)
```

## Export

``` r
p <- plot_power_curve("t_one_sample", n_values = seq(20, 100, by = 10),
                      d = 0.5, alpha = 0.05)
save_power_plot(p, "one-sample-power.png", width = 7, height = 5, dpi = 320)
```
