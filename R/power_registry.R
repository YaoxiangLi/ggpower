#' List supported statistical power tests
#'
#' @param domain Optional character vector to filter by domain (`general`,
#'   `biomarker`, `pharma`).
#' @param module Optional character vector to filter by app module (`workspace`,
#'   `biomarker`, `clinical`).
#' @return A data frame describing tests available to `power_compute()`.
#' @export
ggpower_tests <- function(domain = NULL, module = NULL) {
  specs <- ggpower_test_registry()
  df <- data.frame(
    id = vapply(specs, `[[`, character(1), "id"),
    family = vapply(specs, `[[`, character(1), "family"),
    label = vapply(specs, `[[`, character(1), "label"),
    method = vapply(specs, `[[`, character(1), "method"),
    parity = vapply(specs, `[[`, character(1), "parity"),
    domain = vapply(specs, `[[`, character(1), "domain"),
    module = vapply(specs, `[[`, character(1), "module"),
    modes = vapply(specs, function(x) paste(x$modes, collapse = ", "), character(1)),
    stringsAsFactors = FALSE
  )
  if (!is.null(domain)) {
    df <- df[df$domain %in% domain, , drop = FALSE]
  }
  if (!is.null(module)) {
    df <- df[df$module %in% module, , drop = FALSE]
  }
  df
}

ggpower_test_registry <- function() {
  list(
    t_one_sample = .gp_spec(
      "t_one_sample", "t tests",
      "Means: Difference from constant (one sample case)",
      effect = "d", sample = "n",
      fields = c("tails", "d", "alpha", "power", "n", "q")
    ),
    t_paired = .gp_spec(
      "t_paired", "t tests",
      "Means: Difference between two dependent means (matched pairs)",
      effect = "d", sample = "n",
      fields = c("tails", "d", "alpha", "power", "n", "q")
    ),
    t_two_sample = .gp_spec(
      "t_two_sample", "t tests",
      "Means: Difference between two independent means (two groups)",
      effect = "d", sample = "total_n",
      fields = c("tails", "d", "alpha", "power", "n1", "n2", "allocation_ratio", "q")
    ),
    t_point_biserial = .gp_spec(
      "t_point_biserial", "t tests",
      "Correlation: Point biserial model",
      effect = "rho", sample = "n",
      fields = c("tails", "rho", "alpha", "power", "n", "q")
    ),
    t_linear_regression = .gp_spec(
      "t_linear_regression", "t tests",
      "Linear regression: Size of slope (one group)",
      effect = "slope_h1", sample = "n",
      fields = c("tails", "slope_h1", "slope_h0", "sd_x", "sd_y", "alpha", "power", "n", "q")
    ),
    t_linear_regression_two_groups = .gp_spec(
      "t_linear_regression_two_groups", "t tests",
      "Linear regression: Difference between two slopes (two groups)",
      effect = "delta_slope", sample = "total_n",
      fields = c("tails", "delta_slope", "residual_sd", "sd_x1", "sd_x2", "alpha", "power", "n1", "n2", "allocation_ratio", "q")
    ),
    t_generic = .gp_spec(
      "t_generic", "t tests",
      "Generic t test",
      effect = "ncp", sample = "n",
      modes = c("post_hoc", "criterion", "sensitivity", "compromise"),
      fields = c("tails", "ncp", "alpha", "power", "n", "df", "q")
    ),
    f_anova_one_way = .gp_spec(
      "f_anova_one_way", "F tests",
      "ANOVA: Fixed effects, omnibus, one-way",
      effect = "f", sample = "total_n",
      fields = c("f", "alpha", "power", "total_n", "groups", "q")
    ),
    f_anova_special = .gp_spec(
      "f_anova_special", "F tests",
      "ANOVA: Fixed effects, special, main effects and interactions",
      effect = "f", sample = "total_n",
      fields = c("f", "alpha", "power", "total_n", "df1", "groups", "q")
    ),
    f_mreg_omnibus = .gp_spec(
      "f_mreg_omnibus", "F tests",
      "Multiple regression: Omnibus (R2 deviation from zero)",
      effect = "f2", sample = "total_n",
      fields = c("f2", "alpha", "power", "total_n", "predictors", "q")
    ),
    f_mreg_increase = .gp_spec(
      "f_mreg_increase", "F tests",
      "Multiple regression: Special (R2 increase)",
      effect = "f2", sample = "total_n",
      fields = c("f2", "alpha", "power", "total_n", "tested_predictors", "predictors", "q")
    ),
    f_variance_two = .gp_spec(
      "f_variance_two", "F tests",
      "Variance: Inequality of two variances",
      effect = "variance_ratio", sample = "total_n",
      fields = c("tails", "variance_ratio", "alpha", "power", "n1", "n2", "allocation_ratio", "q")
    ),
    chisq_variance_one = .gp_spec(
      "chisq_variance_one", "chi-square tests",
      "Variance: Difference from constant (one sample case)",
      effect = "variance_ratio", sample = "n",
      fields = c("tails", "variance_ratio", "alpha", "power", "n", "q")
    ),
    chisq_gof = .gp_spec(
      "chisq_gof", "chi-square tests",
      "Goodness-of-fit tests: Contingency tables",
      effect = "w", sample = "total_n",
      fields = c("w", "alpha", "power", "total_n", "df", "q")
    ),
    chisq_contingency = .gp_spec(
      "chisq_contingency", "chi-square tests",
      "Contingency tables",
      effect = "w", sample = "total_n",
      fields = c("w", "alpha", "power", "total_n", "df", "q")
    ),
    exact_binomial = .gp_spec(
      "exact_binomial", "Exact",
      "Generic binomial test",
      effect = "p1", sample = "n",
      fields = c("tails", "p0", "p1", "alpha", "power", "n", "q")
    ),
    exact_one_proportion = .gp_spec(
      "exact_one_proportion", "Exact",
      "Proportion: Difference from constant (one sample case)",
      effect = "p1", sample = "n",
      fields = c("tails", "p0", "p1", "alpha", "power", "n", "q")
    ),
    exact_sign = .gp_spec(
      "exact_sign", "Exact",
      "Proportion: Sign test",
      effect = "p1", sample = "n",
      fields = c("tails", "p0", "p1", "alpha", "power", "n", "q")
    ),
    exact_fisher = .gp_spec(
      "exact_fisher", "Exact",
      "Proportions: Inequality of two independent groups (Fisher exact)",
      effect = "p1", sample = "total_n",
      fields = c("tails", "p0", "p1", "alpha", "power", "n1", "n2", "allocation_ratio", "q")
    ),
    exact_mcnemar = .gp_spec(
      "exact_mcnemar", "Exact",
      "Proportion: Inequality, two dependent groups (McNemar)",
      effect = "p1", sample = "n",
      fields = c("tails", "p0", "p1", "alpha", "power", "n", "q")
    ),
    exact_correlation = .gp_spec(
      "exact_correlation", "Exact",
      "Correlation: Difference from constant (one sample case)",
      effect = "rho", sample = "n",
      fields = c("tails", "rho0", "rho", "alpha", "power", "n", "q"),
      method = "Fisher Z with exact-kernel TODO",
      parity = "approximation"
    ),
    exact_mreg_random = .gp_spec(
      "exact_mreg_random", "Exact",
      "Multiple regression: Random model",
      effect = "rho2", sample = "total_n",
      fields = c("rho2", "alpha", "power", "total_n", "predictors", "q"),
      method = "exact R2 distribution approximation",
      parity = "supported"
    ),
    z_corr_independent = .gp_spec(
      "z_corr_independent", "z tests",
      "Correlation: Inequality of two independent Pearson r's",
      effect = "q_effect", sample = "total_n",
      fields = c("tails", "q_effect", "alpha", "power", "n1", "n2", "allocation_ratio", "q")
    ),
    z_corr_dependent_common = .gp_spec(
      "z_corr_dependent_common", "z tests",
      "Correlation: Inequality of two dependent Pearson r's (common index)",
      effect = "rho_ac", sample = "n",
      fields = c("tails", "rho_ab", "rho_ac", "rho_bc", "alpha", "power", "n", "q")
    ),
    z_corr_dependent_no_common = .gp_spec(
      "z_corr_dependent_no_common", "z tests",
      "Correlation: Inequality of two dependent Pearson r's (no common index)",
      effect = "rho_cd", sample = "n",
      fields = c("tails", "rho_ab", "rho_cd", "rho_ac", "rho_ad", "rho_bc", "rho_bd", "alpha", "power", "n", "q")
    ),
    z_logistic = .gp_spec(
      "z_logistic", "z tests",
      "Regression: Logistic regression",
      effect = "odds_ratio", sample = "total_n",
      fields = c("tails", "odds_ratio", "p0", "alpha", "power", "total_n", "r2_other", "x_variance", "q")
    ),
    z_poisson = .gp_spec(
      "z_poisson", "z tests",
      "Regression: Poisson regression",
      effect = "exp_beta1", sample = "total_n",
      fields = c("tails", "exp_beta1", "base_rate", "exposure", "alpha", "power", "total_n", "r2_other", "x_variance", "q")
    ),
    z_tetrachoric = .gp_spec(
      "z_tetrachoric", "z tests",
      "Correlation: Tetrachoric correlation",
      effect = "rho", sample = "n",
      fields = c("tails", "rho0", "rho", "alpha", "power", "n", "q"),
      method = "large-sample tetrachoric z approximation",
      parity = "approximation"
    ),
    wilcoxon_signed = .gp_spec(
      "wilcoxon_signed", "nonparametric",
      "Wilcoxon signed-rank test: One sample or matched pairs",
      effect = "d", sample = "n",
      fields = c("tails", "d", "alpha", "power", "n", "are", "q")
    ),
    wilcoxon_mann_whitney = .gp_spec(
      "wilcoxon_mann_whitney", "nonparametric",
      "Wilcoxon-Mann-Whitney test: Two independent means",
      effect = "d", sample = "total_n",
      fields = c("tails", "d", "alpha", "power", "n1", "n2", "allocation_ratio", "are", "q")
    ),
    roc_auc_one = .gp_spec(
      "roc_auc_one", "biomarker",
      "ROC AUC: One sample vs null AUC",
      effect = "auc", sample = "total_n",
      fields = c("tails", "auc", "auc0", "n_pos", "n_neg", "alpha", "power", "q"),
      method = "Hanley-McNeil AUC variance approximation",
      domain = "biomarker", module = "biomarker"
    ),
    roc_auc_two = .gp_spec(
      "roc_auc_two", "biomarker",
      "ROC AUC: Compare two independent AUCs",
      effect = "auc1", sample = "total_n",
      fields = c("tails", "auc1", "auc2", "n1", "n2", "alpha", "power", "q"),
      method = "DeLong-style AUC difference approximation",
      domain = "biomarker", module = "biomarker"
    ),
    diagnostic_acc = .gp_spec(
      "diagnostic_acc", "biomarker",
      "Diagnostic accuracy: Sensitivity and specificity",
      effect = "sensitivity", sample = "total_n",
      fields = c("tails", "sensitivity", "specificity", "n_pos", "n_neg", "alpha", "power", "q"),
      method = "Binomial normal approximation",
      domain = "biomarker", module = "biomarker"
    ),
    survival_logrank = .gp_spec(
      "survival_logrank", "biomarker",
      "Survival: Log-rank test",
      effect = "hazard_ratio", sample = "total_n",
      fields = c("tails", "hazard_ratio", "event_rate", "allocation_ratio", "total_n", "alpha", "power", "q"),
      method = "Schoenfeld/Freedman log-rank approximation",
      domain = "biomarker", module = "biomarker"
    ),
    cox_regression = .gp_spec(
      "cox_regression", "biomarker",
      "Survival: Cox PH single covariate",
      effect = "hazard_ratio", sample = "events",
      fields = c("tails", "hazard_ratio", "events", "alpha", "power", "q"),
      method = "Cox Wald z approximation",
      domain = "biomarker", module = "biomarker"
    ),
    discovery_fdr = .gp_spec(
      "discovery_fdr", "biomarker",
      "Discovery: Multiplicity-adjusted FDR screening",
      effect = "effect_d", sample = "n",
      fields = c("m_tests", "pi0", "effect_d", "n", "fdr_level", "alpha", "power", "q"),
      method = "Benjamini-Hochberg FDR framework",
      domain = "biomarker", module = "biomarker"
    ),
    ttest_biomarker = .gp_spec(
      "ttest_biomarker", "biomarker",
      "Differential expression: Two-group t test",
      effect = "d", sample = "total_n",
      fields = c("tails", "d", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "Two-sample t test (biomarker wrapper)",
      domain = "biomarker", module = "biomarker"
    ),
    rct_superiority_continuous = .gp_spec(
      "rct_superiority_continuous", "clinical",
      "RCT superiority: Continuous endpoint",
      effect = "d", sample = "total_n",
      fields = c("d", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "One-sided two-sample t test",
      domain = "pharma", module = "clinical"
    ),
    rct_superiority_binary = .gp_spec(
      "rct_superiority_binary", "clinical",
      "RCT superiority: Binary endpoint",
      effect = "p1", sample = "total_n",
      fields = c("p0", "p1", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "One-sided Fisher exact / proportions",
      domain = "pharma", module = "clinical"
    ),
    rct_noninferiority_continuous = .gp_spec(
      "rct_noninferiority_continuous", "clinical",
      "Non-inferiority: Continuous endpoint",
      effect = "d", sample = "total_n",
      fields = c("d", "ni_margin", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "One-sided NI t test",
      domain = "pharma", module = "clinical"
    ),
    rct_noninferiority_binary = .gp_spec(
      "rct_noninferiority_binary", "clinical",
      "Non-inferiority: Binary endpoint",
      effect = "p1", sample = "total_n",
      fields = c("p0", "p1", "ni_margin", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "One-sided NI proportions test",
      domain = "pharma", module = "clinical"
    ),
    rct_equivalence_continuous = .gp_spec(
      "rct_equivalence_continuous", "clinical",
      "Equivalence: Continuous endpoint (TOST)",
      effect = "d", sample = "total_n",
      fields = c("d", "eq_margin", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "Two one-sided t tests (TOST)",
      domain = "pharma", module = "clinical"
    ),
    rct_equivalence_proportion = .gp_spec(
      "rct_equivalence_proportion", "clinical",
      "Equivalence: Binary endpoint (TOST)",
      effect = "p1", sample = "total_n",
      fields = c("p0", "p1", "eq_margin", "alpha", "power", "n1", "n2", "allocation_ratio", "q"),
      method = "Two one-sided proportion tests (TOST)",
      domain = "pharma", module = "clinical"
    ),
    simon_two_stage = .gp_spec(
      "simon_two_stage", "clinical",
      "Simon two-stage Phase II design",
      effect = "p1", sample = "total_n",
      fields = c("p0", "p1", "alpha", "power", "n1", "r1", "n2", "r"),
      method = "Simon 1989 two-stage binomial design",
      domain = "pharma", module = "clinical",
      modes = c("post_hoc", "sensitivity")
    ),
    cluster_rct = .gp_spec(
      "cluster_rct", "clinical",
      "Cluster-randomized trial",
      effect = "d", sample = "total_n",
      fields = c("tails", "d", "icc", "cluster_size", "n_clusters", "alpha", "power", "q"),
      method = "Design effect from ICC",
      domain = "pharma", module = "clinical"
    ),
    multi_arm_superiority = .gp_spec(
      "multi_arm_superiority", "clinical",
      "Multi-arm superiority (ANOVA)",
      effect = "f", sample = "total_n",
      fields = c("f", "alpha", "power", "total_n", "groups", "q"),
      method = "One-way ANOVA F test",
      domain = "pharma", module = "clinical"
    ),
    count_endpoint_poisson = .gp_spec(
      "count_endpoint_poisson", "clinical",
      "Count endpoint: Poisson regression",
      effect = "exp_beta1", sample = "total_n",
      fields = c("tails", "exp_beta1", "base_rate", "exposure", "alpha", "power", "total_n", "r2_other", "x_variance", "q"),
      method = "Poisson regression z approximation",
      domain = "pharma", module = "clinical"
    ),
    survival_pmu = .gp_spec(
      "survival_pmu", "clinical",
      "Survival endpoint: Log-rank primary analysis",
      effect = "hazard_ratio", sample = "total_n",
      fields = c("tails", "hazard_ratio", "event_rate", "allocation_ratio", "total_n", "alpha", "power", "q"),
      method = "Schoenfeld/Freedman log-rank approximation",
      domain = "pharma", module = "clinical"
    )
  )
}

ggpower_get_test <- function(test) {
  registry <- ggpower_test_registry()
  if (!test %in% names(registry)) {
    stop(
      "Unknown test '", test, "'. Use ggpower_tests() to list supported tests.",
      call. = FALSE
    )
  }
  registry[[test]]
}

.gp_spec <- function(id, family, label, effect, sample,
                     modes = c("a_priori", "compromise", "criterion", "post_hoc", "sensitivity"),
                     fields, method = "distribution kernel",
                     parity = "supported",
                     domain = "general", module = "workspace") {
  list(
    id = id,
    family = family,
    label = label,
    effect = effect,
    sample = sample,
    modes = modes,
    fields = fields,
    method = method,
    parity = parity,
    domain = domain,
    module = module
  )
}
