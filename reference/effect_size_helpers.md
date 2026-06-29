# Effect-size helper functions

Helpers used by the GUI effect-size drawer and by scripting workflows.

## Usage

``` r
effect_size_d(mean_h1, mean_h0 = 0, sd)
effect_size_f(eta2)
effect_size_f2(r2)
effect_size_f2_increase(r2_full, r2_reduced)
effect_size_h(p1, p2)
effect_size_q(r1, r2)
effect_size_w(p0, p1)
eta2_from_f(f)
odds_ratio_from_probs(p0, p1)
r2_from_f2(f2)
```

## Arguments

- mean_h1, mean_h0:

  Means used to compute Cohen's d.

- sd:

  Common standard deviation.

- eta2:

  Eta-squared value.

- r2, r2_full, r2_reduced:

  R-squared values; `r2` is also the second correlation in
  `effect_size_q()`.

- p0, p1, p2:

  Probabilities or probability vectors.

- r1:

  First correlation in `effect_size_q()`.

- f, f2:

  Cohen effect-size values.

## Value

A numeric effect-size or converted variance-explained value.
