# Save a ggpower plot

Exports publication-ready ggpower plots through
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Usage

``` r
save_power_plot(plot, filename, width = 7, height = 5, dpi = 320)

save_distribution_plot(plot, filename, width = 7, height = 5, dpi = 320)
```

## Arguments

- plot:

  A ggplot object.

- filename:

  Output filename.

- width,height:

  Plot dimensions.

- dpi:

  Resolution for raster outputs.

## Value

The filename invisibly.
