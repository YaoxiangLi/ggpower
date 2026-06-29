# Choosing the Right Module

## In plain English

Not every research question belongs in the same module. Use this guide
to pick the sidebar entry that matches your endpoint and study design.

## Decision guide

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

## Filter tests by module

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

## When NOT to switch modules

Stay in **Power Workspace** when you need specialized classical tests
(McNemar, tetrachoric correlation, Wilcoxon, etc.) even if the endpoint
sounds clinical.

## Related analyses

- [Getting started with the
  GUI](https://yaoxiangli.github.io/ggpower/articles/getting-started-gui.md)
- [Choosing a power
  analysis](https://yaoxiangli.github.io/ggpower/articles/choosing-a-power-analysis.md)
