# List supported statistical power tests

Lists the tests available to
[`power_compute()`](https://yaoxiangli.github.io/ggpower/reference/power_compute.md).

## Usage

``` r
ggpower_tests(domain = NULL, module = NULL)
```

## Arguments

- domain:

  Optional character vector to filter by domain (`general`, `biomarker`,
  `pharma`).

- module:

  Optional character vector to filter by app module (`workspace`,
  `biomarker`, `clinical`).

## Value

A data frame describing tests available to
[`power_compute()`](https://yaoxiangli.github.io/ggpower/reference/power_compute.md).

## Examples

``` r
ggpower_tests()
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
#>                                                                                                 label
#> t_one_sample                                        Means: Difference from constant (one sample case)
#> t_paired                                Means: Difference between two dependent means (matched pairs)
#> t_two_sample                             Means: Difference between two independent means (two groups)
#> t_point_biserial                                                    Correlation: Point biserial model
#> t_linear_regression                                      Linear regression: Size of slope (one group)
#> t_linear_regression_two_groups          Linear regression: Difference between two slopes (two groups)
#> t_generic                                                                              Generic t test
#> f_anova_one_way                                                ANOVA: Fixed effects, omnibus, one-way
#> f_anova_special                          ANOVA: Fixed effects, special, main effects and interactions
#> f_mreg_omnibus                                  Multiple regression: Omnibus (R2 deviation from zero)
#> f_mreg_increase                                            Multiple regression: Special (R2 increase)
#> f_variance_two                                                  Variance: Inequality of two variances
#> chisq_variance_one                               Variance: Difference from constant (one sample case)
#> chisq_gof                                                   Goodness-of-fit tests: Contingency tables
#> chisq_contingency                                                                  Contingency tables
#> exact_binomial                                                                  Generic binomial test
#> exact_one_proportion                           Proportion: Difference from constant (one sample case)
#> exact_sign                                                                      Proportion: Sign test
#> exact_fisher                         Proportions: Inequality of two independent groups (Fisher exact)
#> exact_mcnemar                                  Proportion: Inequality, two dependent groups (McNemar)
#> exact_correlation                             Correlation: Difference from constant (one sample case)
#> exact_mreg_random                                                   Multiple regression: Random model
#> z_corr_independent                             Correlation: Inequality of two independent Pearson r's
#> z_corr_dependent_common           Correlation: Inequality of two dependent Pearson r's (common index)
#> z_corr_dependent_no_common     Correlation: Inequality of two dependent Pearson r's (no common index)
#> z_logistic                                                            Regression: Logistic regression
#> z_poisson                                                              Regression: Poisson regression
#> z_tetrachoric                                                    Correlation: Tetrachoric correlation
#> wilcoxon_signed                                Wilcoxon signed-rank test: One sample or matched pairs
#> wilcoxon_mann_whitney                               Wilcoxon-Mann-Whitney test: Two independent means
#> roc_auc_one                                                           ROC AUC: One sample vs null AUC
#> roc_auc_two                                                     ROC AUC: Compare two independent AUCs
#> diagnostic_acc                                       Diagnostic accuracy: Sensitivity and specificity
#> survival_logrank                                                              Survival: Log-rank test
#> cox_regression                                                      Survival: Cox PH single covariate
#> discovery_fdr                                          Discovery: Multiplicity-adjusted FDR screening
#> ttest_biomarker                                             Differential expression: Two-group t test
#> rct_superiority_continuous                                       RCT superiority: Continuous endpoint
#> rct_superiority_binary                                               RCT superiority: Binary endpoint
#> rct_noninferiority_continuous                                    Non-inferiority: Continuous endpoint
#> rct_noninferiority_binary                                            Non-inferiority: Binary endpoint
#> rct_equivalence_continuous                                    Equivalence: Continuous endpoint (TOST)
#> rct_equivalence_proportion                                        Equivalence: Binary endpoint (TOST)
#> simon_two_stage                                                       Simon two-stage Phase II design
#> cluster_rct                                                                  Cluster-randomized trial
#> multi_arm_superiority                                                   Multi-arm superiority (ANOVA)
#> count_endpoint_poisson                                             Count endpoint: Poisson regression
#> survival_pmu                                             Survival endpoint: Log-rank primary analysis
#>                                                                    method
#> t_one_sample                                          distribution kernel
#> t_paired                                              distribution kernel
#> t_two_sample                                          distribution kernel
#> t_point_biserial                                      distribution kernel
#> t_linear_regression                                   distribution kernel
#> t_linear_regression_two_groups                        distribution kernel
#> t_generic                                             distribution kernel
#> f_anova_one_way                                       distribution kernel
#> f_anova_special                                       distribution kernel
#> f_mreg_omnibus                                        distribution kernel
#> f_mreg_increase                                       distribution kernel
#> f_variance_two                                        distribution kernel
#> chisq_variance_one                                    distribution kernel
#> chisq_gof                                             distribution kernel
#> chisq_contingency                                     distribution kernel
#> exact_binomial                                        distribution kernel
#> exact_one_proportion                                  distribution kernel
#> exact_sign                                            distribution kernel
#> exact_fisher                                          distribution kernel
#> exact_mcnemar                                         distribution kernel
#> exact_correlation                         Fisher Z with exact-kernel TODO
#> exact_mreg_random                     exact R2 distribution approximation
#> z_corr_independent                                    distribution kernel
#> z_corr_dependent_common                               distribution kernel
#> z_corr_dependent_no_common                            distribution kernel
#> z_logistic                                            distribution kernel
#> z_poisson                                             distribution kernel
#> z_tetrachoric                    large-sample tetrachoric z approximation
#> wilcoxon_signed                                       distribution kernel
#> wilcoxon_mann_whitney                                 distribution kernel
#> roc_auc_one                      Hanley-McNeil AUC variance approximation
#> roc_auc_two                     DeLong-style AUC difference approximation
#> diagnostic_acc                              Binomial normal approximation
#> survival_logrank               Schoenfeld/Freedman log-rank approximation
#> cox_regression                                   Cox Wald z approximation
#> discovery_fdr                            Benjamini-Hochberg FDR framework
#> ttest_biomarker                     Two-sample t test (biomarker wrapper)
#> rct_superiority_continuous                    One-sided two-sample t test
#> rct_superiority_binary               One-sided Fisher exact / proportions
#> rct_noninferiority_continuous                         One-sided NI t test
#> rct_noninferiority_binary                   One-sided NI proportions test
#> rct_equivalence_continuous                   Two one-sided t tests (TOST)
#> rct_equivalence_proportion          Two one-sided proportion tests (TOST)
#> simon_two_stage                      Simon 1989 two-stage binomial design
#> cluster_rct                                        Design effect from ICC
#> multi_arm_superiority                                One-way ANOVA F test
#> count_endpoint_poisson                 Poisson regression z approximation
#> survival_pmu                   Schoenfeld/Freedman log-rank approximation
#>                                       parity    domain    module
#> t_one_sample                       supported   general workspace
#> t_paired                           supported   general workspace
#> t_two_sample                       supported   general workspace
#> t_point_biserial                   supported   general workspace
#> t_linear_regression                supported   general workspace
#> t_linear_regression_two_groups     supported   general workspace
#> t_generic                          supported   general workspace
#> f_anova_one_way                    supported   general workspace
#> f_anova_special                    supported   general workspace
#> f_mreg_omnibus                     supported   general workspace
#> f_mreg_increase                    supported   general workspace
#> f_variance_two                     supported   general workspace
#> chisq_variance_one                 supported   general workspace
#> chisq_gof                          supported   general workspace
#> chisq_contingency                  supported   general workspace
#> exact_binomial                     supported   general workspace
#> exact_one_proportion               supported   general workspace
#> exact_sign                         supported   general workspace
#> exact_fisher                       supported   general workspace
#> exact_mcnemar                      supported   general workspace
#> exact_correlation              approximation   general workspace
#> exact_mreg_random                  supported   general workspace
#> z_corr_independent                 supported   general workspace
#> z_corr_dependent_common            supported   general workspace
#> z_corr_dependent_no_common         supported   general workspace
#> z_logistic                         supported   general workspace
#> z_poisson                          supported   general workspace
#> z_tetrachoric                  approximation   general workspace
#> wilcoxon_signed                    supported   general workspace
#> wilcoxon_mann_whitney              supported   general workspace
#> roc_auc_one                        supported biomarker biomarker
#> roc_auc_two                        supported biomarker biomarker
#> diagnostic_acc                     supported biomarker biomarker
#> survival_logrank                   supported biomarker biomarker
#> cox_regression                     supported biomarker biomarker
#> discovery_fdr                      supported biomarker biomarker
#> ttest_biomarker                    supported biomarker biomarker
#> rct_superiority_continuous         supported    pharma  clinical
#> rct_superiority_binary             supported    pharma  clinical
#> rct_noninferiority_continuous      supported    pharma  clinical
#> rct_noninferiority_binary          supported    pharma  clinical
#> rct_equivalence_continuous         supported    pharma  clinical
#> rct_equivalence_proportion         supported    pharma  clinical
#> simon_two_stage                    supported    pharma  clinical
#> cluster_rct                        supported    pharma  clinical
#> multi_arm_superiority              supported    pharma  clinical
#> count_endpoint_poisson             supported    pharma  clinical
#> survival_pmu                       supported    pharma  clinical
#>                                                                                 modes
#> t_one_sample                   a_priori, compromise, criterion, post_hoc, sensitivity
#> t_paired                       a_priori, compromise, criterion, post_hoc, sensitivity
#> t_two_sample                   a_priori, compromise, criterion, post_hoc, sensitivity
#> t_point_biserial               a_priori, compromise, criterion, post_hoc, sensitivity
#> t_linear_regression            a_priori, compromise, criterion, post_hoc, sensitivity
#> t_linear_regression_two_groups a_priori, compromise, criterion, post_hoc, sensitivity
#> t_generic                                post_hoc, criterion, sensitivity, compromise
#> f_anova_one_way                a_priori, compromise, criterion, post_hoc, sensitivity
#> f_anova_special                a_priori, compromise, criterion, post_hoc, sensitivity
#> f_mreg_omnibus                 a_priori, compromise, criterion, post_hoc, sensitivity
#> f_mreg_increase                a_priori, compromise, criterion, post_hoc, sensitivity
#> f_variance_two                 a_priori, compromise, criterion, post_hoc, sensitivity
#> chisq_variance_one             a_priori, compromise, criterion, post_hoc, sensitivity
#> chisq_gof                      a_priori, compromise, criterion, post_hoc, sensitivity
#> chisq_contingency              a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_binomial                 a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_one_proportion           a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_sign                     a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_fisher                   a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_mcnemar                  a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_correlation              a_priori, compromise, criterion, post_hoc, sensitivity
#> exact_mreg_random              a_priori, compromise, criterion, post_hoc, sensitivity
#> z_corr_independent             a_priori, compromise, criterion, post_hoc, sensitivity
#> z_corr_dependent_common        a_priori, compromise, criterion, post_hoc, sensitivity
#> z_corr_dependent_no_common     a_priori, compromise, criterion, post_hoc, sensitivity
#> z_logistic                     a_priori, compromise, criterion, post_hoc, sensitivity
#> z_poisson                      a_priori, compromise, criterion, post_hoc, sensitivity
#> z_tetrachoric                  a_priori, compromise, criterion, post_hoc, sensitivity
#> wilcoxon_signed                a_priori, compromise, criterion, post_hoc, sensitivity
#> wilcoxon_mann_whitney          a_priori, compromise, criterion, post_hoc, sensitivity
#> roc_auc_one                    a_priori, compromise, criterion, post_hoc, sensitivity
#> roc_auc_two                    a_priori, compromise, criterion, post_hoc, sensitivity
#> diagnostic_acc                 a_priori, compromise, criterion, post_hoc, sensitivity
#> survival_logrank               a_priori, compromise, criterion, post_hoc, sensitivity
#> cox_regression                 a_priori, compromise, criterion, post_hoc, sensitivity
#> discovery_fdr                  a_priori, compromise, criterion, post_hoc, sensitivity
#> ttest_biomarker                a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_superiority_continuous     a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_superiority_binary         a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_noninferiority_continuous  a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_noninferiority_binary      a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_equivalence_continuous     a_priori, compromise, criterion, post_hoc, sensitivity
#> rct_equivalence_proportion     a_priori, compromise, criterion, post_hoc, sensitivity
#> simon_two_stage                                                 post_hoc, sensitivity
#> cluster_rct                    a_priori, compromise, criterion, post_hoc, sensitivity
#> multi_arm_superiority          a_priori, compromise, criterion, post_hoc, sensitivity
#> count_endpoint_poisson         a_priori, compromise, criterion, post_hoc, sensitivity
#> survival_pmu                   a_priori, compromise, criterion, post_hoc, sensitivity
ggpower_tests(module = "biomarker")
#>                                id    family
#> roc_auc_one           roc_auc_one biomarker
#> roc_auc_two           roc_auc_two biomarker
#> diagnostic_acc     diagnostic_acc biomarker
#> survival_logrank survival_logrank biomarker
#> cox_regression     cox_regression biomarker
#> discovery_fdr       discovery_fdr biomarker
#> ttest_biomarker   ttest_biomarker biomarker
#>                                                             label
#> roc_auc_one                       ROC AUC: One sample vs null AUC
#> roc_auc_two                 ROC AUC: Compare two independent AUCs
#> diagnostic_acc   Diagnostic accuracy: Sensitivity and specificity
#> survival_logrank                          Survival: Log-rank test
#> cox_regression                  Survival: Cox PH single covariate
#> discovery_fdr      Discovery: Multiplicity-adjusted FDR screening
#> ttest_biomarker         Differential expression: Two-group t test
#>                                                      method    parity    domain
#> roc_auc_one        Hanley-McNeil AUC variance approximation supported biomarker
#> roc_auc_two       DeLong-style AUC difference approximation supported biomarker
#> diagnostic_acc                Binomial normal approximation supported biomarker
#> survival_logrank Schoenfeld/Freedman log-rank approximation supported biomarker
#> cox_regression                     Cox Wald z approximation supported biomarker
#> discovery_fdr              Benjamini-Hochberg FDR framework supported biomarker
#> ttest_biomarker       Two-sample t test (biomarker wrapper) supported biomarker
#>                     module
#> roc_auc_one      biomarker
#> roc_auc_two      biomarker
#> diagnostic_acc   biomarker
#> survival_logrank biomarker
#> cox_regression   biomarker
#> discovery_fdr    biomarker
#> ttest_biomarker  biomarker
#>                                                                   modes
#> roc_auc_one      a_priori, compromise, criterion, post_hoc, sensitivity
#> roc_auc_two      a_priori, compromise, criterion, post_hoc, sensitivity
#> diagnostic_acc   a_priori, compromise, criterion, post_hoc, sensitivity
#> survival_logrank a_priori, compromise, criterion, post_hoc, sensitivity
#> cox_regression   a_priori, compromise, criterion, post_hoc, sensitivity
#> discovery_fdr    a_priori, compromise, criterion, post_hoc, sensitivity
#> ttest_biomarker  a_priori, compromise, criterion, post_hoc, sensitivity
```
