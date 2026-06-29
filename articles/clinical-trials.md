# Clinical Trials

The **Clinical Trials** module covers Phase III superiority,
non-inferiority, equivalence, oncology two-stage, cluster RCT, survival,
and count endpoints.

## Phase III superiority

``` r
power_compute(
  "rct_superiority_continuous",
  analysis = "post_hoc",
  d = 0.4,
  alpha = 0.025,
  n1 = 120,
  n2 = 120
)
#> ggpower result
#> Test: Clinical: RCT superiority (continuous endpoint)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.4
#>   alpha: 0.025
#>   sample_size_group_1: 120
#>   sample_size_group_2: 120
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.098387
#>   critical_t: 1.969982
#>   df: 238
#>   total_sample_size: 240
#>   power: 0.8698953
```

``` r
power_compute(
  "rct_superiority_binary",
  analysis = "a_priori",
  p0 = 0.3,
  p1 = 0.45,
  alpha = 0.025,
  power = 0.9,
  n1 = 50,
  n2 = 50
)
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> Warning: Large Fisher exact grids use Cohen's h normal approximation for speed.
#> ggpower result
#> Test: Clinical: RCT superiority (binary endpoint)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: less
#>   p_group_1: 0.3
#>   p_group_2: 0.45
#>   alpha: 0.025
#>   sample_size_group_1: 217
#>   sample_size_group_2: 217
#>   target_power: 0.9
#> 
#> 
#> Output parameters
#>   effect_size_h: 0.3113494
#>   total_sample_size: 434
#>   actual_power: 0.9002812
#> 
#> 
#> Notes
#> - Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

``` r
power_compute("multi_arm_superiority", "a_priori", f = 0.25, groups = 3,
              alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Multi-arm superiority (ANOVA)
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_f: 0.25
#>   alpha: 0.05
#>   total_sample_size: 158
#>   groups: 3
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 9.875
#>   critical_f: 3.054385
#>   numerator_df: 2
#>   denominator_df: 155
#>   actual_power: 0.8021998
#> 
#> 
#> Notes
#> - Consider Dunnett adjustment for pairwise comparisons.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Non-inferiority

``` r
power_compute("rct_noninferiority_continuous", "a_priori", d = 0.1,
              ni_margin = 0.2, alpha = 0.025, power = 0.8, n1 = 100, n2 = 100)
#> ggpower result
#> Test: Clinical: Non-inferiority trial (continuous)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: one
#>   effect_size_d: 0.1
#>   ni_margin: 0.2
#>   sample_size_group_1: 175
#>   sample_size_group_2: 176
#>   alpha: 0.025
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 2.810238
#>   critical_t: 1.966785
#>   df: 349
#>   total_sample_size: 351
#>   actual_power: 0.800255
#> 
#> 
#> Notes
#> - One-sided NI test: H0 difference <= -margin vs H1 difference > -margin.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

``` r
power_compute("rct_noninferiority_binary", "post_hoc", p0 = 0.5, p1 = 0.55,
              ni_margin = 0.1, alpha = 0.025, n1 = 200, n2 = 200)
#> ggpower result
#> Test: Clinical: Non-inferiority trial (binary)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: one
#>   p_treatment: 0.55
#>   p_control: 0.5
#>   ni_margin: 0.1
#>   sample_size_group_1: 200
#>   sample_size_group_2: 200
#>   alpha: 0.025
#> 
#> 
#> Output parameters
#>   z_statistic: 3.007528
#>   total_sample_size: 400
#>   power: 0.8525803
#> 
#> 
#> Notes
#> - Normal approximation for NI on proportions (one-sided).
```

## Equivalence (TOST)

``` r
power_compute("rct_equivalence_continuous", "a_priori", d = 0,
              eq_margin = 0.2, alpha = 0.05, power = 0.8, n1 = 80, n2 = 80)
#> ggpower result
#> Test: Clinical: Equivalence trial (continuous, TOST)
#> Analysis: a_priori
#> 
#> Input parameters
#>   effect_size_d: 0
#>   eq_margin: 0.2
#>   sample_size_group_1: 420
#>   sample_size_group_2: 420
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   power_upper: 0.8945475
#>   power_lower: 0.8945475
#>   total_sample_size: 840
#>   actual_power: 0.8002153
#> 
#> 
#> Notes
#> - Two one-sided t tests (TOST); overall power is the product of both one-sided powers.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

``` r
power_compute("rct_equivalence_proportion", "post_hoc", p0 = 0.5, p1 = 0.52,
              eq_margin = 0.1, alpha = 0.05, n1 = 150, n2 = 150)
#> ggpower result
#> Test: Clinical: Equivalence trial (proportions, TOST)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   p_treatment: 0.52
#>   p_control: 0.5
#>   eq_margin: 0.1
#>   sample_size_group_1: 150
#>   sample_size_group_2: 150
#>   alpha: 0.05
#> 
#> 
#> Output parameters
#>   power_upper: 0.3979494
#>   power_lower: 0.6680152
#>   total_sample_size: 300
#>   power: 0.2658363
#> 
#> 
#> Notes
#> - TOST on proportion difference using normal approximation.
```

## Simon two-stage (Phase II)

`simon_two_stage` supports `post_hoc` and `sensitivity` only.

``` r
power_compute("simon_two_stage", "post_hoc", p0 = 0.2, p1 = 0.4,
              r1 = 4, r = 10, n1 = 20, n2 = 20, alpha = 0.05)
#> ggpower result
#> Test: Clinical: Simon two-stage Phase II design
#> Analysis: post_hoc
#> 
#> Input parameters
#>   p0: 0.2
#>   p1: 0.4
#>   alpha: 0.05
#>   target_power: 0.8
#>   stage1_n: 20
#>   stage1_r: 4
#>   stage2_n: 20
#>   total_r: 10
#> 
#> 
#> Output parameters
#>   power: 0.9156202
#>   type_i_error: 0.05954113
#>   total_sample_size: 40
#>   expected_sample_size: 38.98096
#> 
#> 
#> Notes
#> - Simon optimal/minimax design power for specified (n1,r1,n2,r).
```

## Cluster RCT

``` r
power_compute("cluster_rct", "a_priori", d = 0.4, icc = 0.05,
              cluster_size = 10, n_clusters = 20, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Cluster-randomized trial
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   effect_size_d: 0.4
#>   icc: 0.05
#>   cluster_size: 10
#>   n_clusters_per_arm: 16
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   design_effect: 1.45
#>   effective_n_per_arm: 110.3448
#>   noncentrality_parameter: 2.971125
#>   total_sample_size: 320
#>   actual_power: 0.8198668
#> 
#> 
#> Notes
#> - Design effect DE = 1 + (m-1)*ICC applied to two-arm cluster RCT.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Survival endpoints

``` r
power_compute("survival_pmu", "a_priori", hazard_ratio = 0.65,
              event_rate = 0.5, alpha = 0.05, power = 0.8)
#> ggpower result
#> Test: Clinical: Survival endpoint (log-rank / Cox framework)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   hazard_ratio: 0.65
#>   event_rate: 0.5
#>   allocation_ratio: 1
#>   total_sample_size: 339
#>   alpha: 0.05
#>   target_power: 0.8
#> 
#> 
#> Output parameters
#>   expected_events: 169.5
#>   z_statistic: 2.804228
#>   actual_power: 0.80074
#> 
#> 
#> Notes
#> - Schoenfeld/Freedman log-rank approximation for equal follow-up.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Binary and count endpoints

``` r
power_compute("rct_superiority_binary", "post_hoc", p0 = 0.3, p1 = 0.45,
              alpha = 0.025, n1 = 120, n2 = 120)
#> ggpower result
#> Test: Clinical: RCT superiority (binary endpoint)
#> Analysis: post_hoc
#> 
#> Input parameters
#>   tails: less
#>   p_group_1: 0.3
#>   p_group_2: 0.45
#>   alpha: 0.025
#>   sample_size_group_1: 120
#>   sample_size_group_2: 120
#> 
#> 
#> Output parameters
#>   effect_size_h: 0.3113494
#>   total_sample_size: 240
#>   power: 0.6319254
#> 
#> 
#> Notes
#> - Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.
```

``` r
power_compute("count_endpoint_poisson", "a_priori", exp_beta1 = 1.3,
              base_rate = 0.85, exposure = 1, alpha = 0.05, power = 0.9,
              total_n = 250)
#> ggpower result
#> Test: Clinical: Count endpoint (Poisson regression)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: two
#>   exp_beta1: 1.3
#>   base_rate: 0.85
#>   exposure: 1
#>   alpha: 0.05
#>   total_sample_size: 180
#>   r2_other_x: 0
#>   x_variance: 1
#>   target_power: 0.9
#> 
#> 
#> Output parameters
#>   critical_z: -1.959964,  1.959964
#>   beta1: 0.2623643
#>   actual_power: 0.9006568
#> 
#> 
#> Notes
#> - Poisson regression support uses a large-sample Wald approximation; exact enumeration is a future refinement.
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Related

- [Biomarker
  endpoints](https://yaoxiangli.github.io/ggpower/articles/biomarker-endpoints.md)
- [Scenario
  guide](https://yaoxiangli.github.io/ggpower/articles/scenario-guide.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
