# Create a ggpower result object

Creates the common result object used by the scriptable API and Shiny
GUI.

## Usage

``` r
ggpower_result(test, analysis, inputs, outputs, notes = character(),
  distribution = list())
```

## Arguments

- test:

  Character label for the selected test.

- analysis:

  Character label for the selected analysis mode.

- inputs:

  Named list of input parameters.

- outputs:

  Named list of computed output parameters.

- notes:

  Character vector with method notes or assumptions.

- distribution:

  Named list describing the H0/H1 distributions.

## Value

An object of class `ggpower_result`.
