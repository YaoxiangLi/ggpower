# Format a ggpower result as structured HTML for Shiny UI

Renders metric cards, input/output blocks, and notes for the Shiny app.

## Usage

``` r
format_result_html(x)
```

## Arguments

- x:

  A `ggpower_result` object.

## Value

A `shiny.tag` list suitable for `renderUI`.
