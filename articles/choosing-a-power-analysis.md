# Choosing a Power Analysis

ggpower organizes power analysis around the question being asked.

- Use **a priori** before data collection when sample size is unknown.
- Use **post hoc** when sample size is fixed and achieved power is
  needed.
- Use **criterion** when alpha should be selected to reach a target
  power.
- Use **sensitivity** when the smallest detectable effect size is the
  target.
- Use **compromise** when alpha and beta should be balanced with a
  chosen beta/alpha ratio.

## Example: Planning a One-Sample Mean Test

Suppose a clinical scale has a baseline mean of 10, the expected mean is
15, and the standard deviation is 8. The effect size is:

``` r

d <- effect_size_d(mean_h1 = 15, mean_h0 = 10, sd = 8)
d
#> [1] 0.625
```

For a one-tailed test with alpha = 0.05 and target power = 0.95:

``` r

power_compute("t_one_sample", "a_priori", d = d, alpha = 0.05,
              power = 0.95, tails = "one")
#> ggpower result
#> Test: t test: Means - difference from constant (one sample case)
#> Analysis: a_priori
#> 
#> Input parameters
#>   tails: greater
#>   effect_size_d: 0.625
#>   alpha: 0.05
#>   total_sample_size: 30
#>   target_power: 0.95
#> 
#> 
#> Output parameters
#>   noncentrality_parameter: 3.423266
#>   critical_t: 1.699127
#>   df: 29
#>   actual_power: 0.9551444
#> 
#> 
#> Notes
#> - A priori sample sizes are rounded up to integer values and actual power is recomputed.
```

## Choosing tests

Use
[`ggpower_tests()`](https://yaoxiangli.github.io/ggpower/reference/ggpower_tests.md)
to inspect supported families, domains, and modules. The package
registers **48 tests** across workspace, biomarker, and clinical
workflows.

``` r

ggpower_tests()[, c("id", "family", "domain", "module")]
#>                                                            id           family
#> t_one_sample                                     t_one_sample          t tests
#> t_paired                                             t_paired          t tests
#> t_two_sample                                     t_two_sample          t tests
#> t_point_biserial                             t_point_biserial          t tests
#> t_linear_regression                       t_linear_regression          t tests
#> t_linear_regression_two_groups t_linear_regression_two_groups          t tests
#> t_generic                                           t_generic          t tests
#> f_anova_one_way                               f_anova_one_way          F tests
#> f_anova_special                               f_anova_special          F tests
#> f_mreg_omnibus                                 f_mreg_omnibus          F tests
#> f_mreg_increase                               f_mreg_increase          F tests
#> f_variance_two                                 f_variance_two          F tests
#> chisq_variance_one                         chisq_variance_one chi-square tests
#> chisq_gof                                           chisq_gof chi-square tests
#> chisq_contingency                           chisq_contingency chi-square tests
#> exact_binomial                                 exact_binomial            Exact
#> exact_one_proportion                     exact_one_proportion            Exact
#> exact_sign                                         exact_sign            Exact
#> exact_fisher                                     exact_fisher            Exact
#> exact_mcnemar                                   exact_mcnemar            Exact
#> exact_correlation                           exact_correlation            Exact
#> exact_mreg_random                           exact_mreg_random            Exact
#> z_corr_independent                         z_corr_independent          z tests
#> z_corr_dependent_common               z_corr_dependent_common          z tests
#> z_corr_dependent_no_common         z_corr_dependent_no_common          z tests
#> z_logistic                                         z_logistic          z tests
#> z_poisson                                           z_poisson          z tests
#> z_tetrachoric                                   z_tetrachoric          z tests
#> wilcoxon_signed                               wilcoxon_signed    nonparametric
#> wilcoxon_mann_whitney                   wilcoxon_mann_whitney    nonparametric
#> roc_auc_one                                       roc_auc_one        biomarker
#> roc_auc_two                                       roc_auc_two        biomarker
#> diagnostic_acc                                 diagnostic_acc        biomarker
#> survival_logrank                             survival_logrank        biomarker
#> cox_regression                                 cox_regression        biomarker
#> discovery_fdr                                   discovery_fdr        biomarker
#> ttest_biomarker                               ttest_biomarker        biomarker
#> rct_superiority_continuous         rct_superiority_continuous         clinical
#> rct_superiority_binary                 rct_superiority_binary         clinical
#> rct_noninferiority_continuous   rct_noninferiority_continuous         clinical
#> rct_noninferiority_binary           rct_noninferiority_binary         clinical
#> rct_equivalence_continuous         rct_equivalence_continuous         clinical
#> rct_equivalence_proportion         rct_equivalence_proportion         clinical
#> simon_two_stage                               simon_two_stage         clinical
#> cluster_rct                                       cluster_rct         clinical
#> multi_arm_superiority                   multi_arm_superiority         clinical
#> count_endpoint_poisson                 count_endpoint_poisson         clinical
#> survival_pmu                                     survival_pmu         clinical
#>                                   domain    module
#> t_one_sample                     general workspace
#> t_paired                         general workspace
#> t_two_sample                     general workspace
#> t_point_biserial                 general workspace
#> t_linear_regression              general workspace
#> t_linear_regression_two_groups   general workspace
#> t_generic                        general workspace
#> f_anova_one_way                  general workspace
#> f_anova_special                  general workspace
#> f_mreg_omnibus                   general workspace
#> f_mreg_increase                  general workspace
#> f_variance_two                   general workspace
#> chisq_variance_one               general workspace
#> chisq_gof                        general workspace
#> chisq_contingency                general workspace
#> exact_binomial                   general workspace
#> exact_one_proportion             general workspace
#> exact_sign                       general workspace
#> exact_fisher                     general workspace
#> exact_mcnemar                    general workspace
#> exact_correlation                general workspace
#> exact_mreg_random                general workspace
#> z_corr_independent               general workspace
#> z_corr_dependent_common          general workspace
#> z_corr_dependent_no_common       general workspace
#> z_logistic                       general workspace
#> z_poisson                        general workspace
#> z_tetrachoric                    general workspace
#> wilcoxon_signed                  general workspace
#> wilcoxon_mann_whitney            general workspace
#> roc_auc_one                    biomarker biomarker
#> roc_auc_two                    biomarker biomarker
#> diagnostic_acc                 biomarker biomarker
#> survival_logrank               biomarker biomarker
#> cox_regression                 biomarker biomarker
#> discovery_fdr                  biomarker biomarker
#> ttest_biomarker                biomarker biomarker
#> rct_superiority_continuous        pharma  clinical
#> rct_superiority_binary            pharma  clinical
#> rct_noninferiority_continuous     pharma  clinical
#> rct_noninferiority_binary         pharma  clinical
#> rct_equivalence_continuous        pharma  clinical
#> rct_equivalence_proportion        pharma  clinical
#> simon_two_stage                   pharma  clinical
#> cluster_rct                       pharma  clinical
#> multi_arm_superiority             pharma  clinical
#> count_endpoint_poisson            pharma  clinical
#> survival_pmu                      pharma  clinical
```

## Sidebar modules

Not every research question belongs in the same module. Use this guide
to pick the sidebar entry that matches your endpoint and study design.

    #>                                                   Question              Module
    #> 1         What sample size for a standard t test or ANOVA?     Power Workspace
    #> 2 Can my biomarker discriminate cases from controls (AUC)? Biomarker Discovery
    #> 3          Is my classifier sensitive and specific enough? Biomarker Discovery
    #> 4                       Does a biomarker predict survival? Biomarker Discovery
    #> 5     How many patients for a Phase III superiority trial?     Clinical Trials
    #> 6           Is treatment non-inferior to standard of care?     Clinical Trials
    #> 7        Is a new formulation equivalent (bioequivalence)?     Clinical Trials
    #> 8        Oncology single-arm Phase II with early stopping?     Clinical Trials
    #>                 Example_test
    #> 1               t_two_sample
    #> 2                roc_auc_one
    #> 3             diagnostic_acc
    #> 4             cox_regression
    #> 5 rct_superiority_continuous
    #> 6  rct_noninferiority_binary
    #> 7 rct_equivalence_continuous
    #> 8            simon_two_stage

- **Power Workspace** — classical test families (t, F, chi-square,
  exact, z, nonparametric)
- **Biomarker Discovery** — ROC, diagnostic, survival, FDR
- **Clinical Trials** — superiority, NI, equivalence, Simon, cluster RCT

``` r

ggpower_tests(module = "biomarker")[, c("id", "label")]
#>                                id
#> roc_auc_one           roc_auc_one
#> roc_auc_two           roc_auc_two
#> diagnostic_acc     diagnostic_acc
#> survival_logrank survival_logrank
#> cox_regression     cox_regression
#> discovery_fdr       discovery_fdr
#> ttest_biomarker   ttest_biomarker
#>                                                             label
#> roc_auc_one                       ROC AUC: One sample vs null AUC
#> roc_auc_two                 ROC AUC: Compare two independent AUCs
#> diagnostic_acc   Diagnostic accuracy: Sensitivity and specificity
#> survival_logrank                          Survival: Log-rank test
#> cox_regression                  Survival: Cox PH single covariate
#> discovery_fdr      Discovery: Multiplicity-adjusted FDR screening
#> ttest_biomarker         Differential expression: Two-group t test
```

``` r

ggpower_tests(module = "clinical")[, c("id", "label")]
#>                                                          id
#> rct_superiority_continuous       rct_superiority_continuous
#> rct_superiority_binary               rct_superiority_binary
#> rct_noninferiority_continuous rct_noninferiority_continuous
#> rct_noninferiority_binary         rct_noninferiority_binary
#> rct_equivalence_continuous       rct_equivalence_continuous
#> rct_equivalence_proportion       rct_equivalence_proportion
#> simon_two_stage                             simon_two_stage
#> cluster_rct                                     cluster_rct
#> multi_arm_superiority                 multi_arm_superiority
#> count_endpoint_poisson               count_endpoint_poisson
#> survival_pmu                                   survival_pmu
#>                                                                      label
#> rct_superiority_continuous            RCT superiority: Continuous endpoint
#> rct_superiority_binary                    RCT superiority: Binary endpoint
#> rct_noninferiority_continuous         Non-inferiority: Continuous endpoint
#> rct_noninferiority_binary                 Non-inferiority: Binary endpoint
#> rct_equivalence_continuous         Equivalence: Continuous endpoint (TOST)
#> rct_equivalence_proportion             Equivalence: Binary endpoint (TOST)
#> simon_two_stage                            Simon two-stage Phase II design
#> cluster_rct                                       Cluster-randomized trial
#> multi_arm_superiority                        Multi-arm superiority (ANOVA)
#> count_endpoint_poisson                  Count endpoint: Poisson regression
#> survival_pmu                  Survival endpoint: Log-rank primary analysis
```

Stay in **Power Workspace** when you need specialized classical tests
(McNemar, tetrachoric correlation, Wilcoxon, etc.) even if the endpoint
sounds clinical.

## Related

- [Getting started with the
  GUI](https://yaoxiangli.github.io/ggpower/articles/getting-started-gui.md)
- [Scenario
  guide](https://yaoxiangli.github.io/ggpower/articles/scenario-guide.md)
- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
