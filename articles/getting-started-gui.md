# Getting Started with the GUI

## In plain English

The ggpower app is a wide-screen research workspace. A **left sidebar**
switches between modules so you can run general statistical power
analyses, biomarker discovery workflows, or clinical trial designs
without leaving the same session.

## Sidebar modules

| Module | Use when |
|----|----|
| **Power Workspace** | Classical test families (t, F, chi-square, exact, z, nonparametric) |
| **Biomarker Discovery** | ROC/AUC, diagnostic accuracy, survival, Cox, FDR screening |
| **Clinical Trials** | Superiority, NI, equivalence, Simon two-stage, cluster RCT |
| **Calculator** | Distribution-function expressions and calculator scripts |
| **Protocol** | Download a log of every analysis from the session |
| **Help** | Links to vignettes and reference articles |

## Launch the app

``` r
run_app()
```

On a 1080p display you get a two-column analysis grid. At **1920px** and
**2560px** width the layout expands to a three-column grid with larger
plot panels.

## Typical workflow

1.  Pick a module from the sidebar.
2.  Choose **test family**, **statistical test**, and **analysis mode**.
3.  Enter inputs in the parameter panel.
4.  Click **Calculate** — results appear as metric cards with full
    detail below.
5.  Review the distribution plot and sample-size power curve.
6.  Open **Protocol** to download the session log.

## Worked example (script)

The same calculation is available programmatically:

``` r
power_compute(
  "t_two_sample",
  analysis = "a_priori",
  d = 0.5,
  alpha = 0.05,
  power = 0.8,
  tails = "two"
)
#> ggpower result
#> Test: t test: Means - difference between two independent means (two groups)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.5
#>   alpha: 0.05
#>   sample_size_group_1: 64
#>   sample_size_group_2: 64
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.828427
#>   critical_t: -1.978971,  1.978971
#>   df: 126
#>   total_sample_size: 128
#>   actual_power: 0.8014596
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related analyses

- [Choosing a power
  analysis](https://yaoxiangli.github.io/ggpower/articles/choosing-a-power-analysis.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
