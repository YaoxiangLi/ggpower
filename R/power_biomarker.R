.gp_roc_auc_one <- function(params, analysis) {
  auc <- .gp_numeric(params, "auc", 0.75, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  auc0 <- .gp_numeric(params, "auc0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n_pos <- .gp_count(params, "n_pos", .gp_arg(params, "n1", 50), min = 2)
  n_neg <- .gp_count(params, "n_neg", .gp_arg(params, "n2", 50), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  q1 <- auc / (2 - auc)
  q2 <- (2 * auc^2) / (1 + auc)
  var_auc <- (auc * (1 - auc) +
    (n_pos - 1) * (q1 - auc^2) +
    (n_neg - 1) * (q2 - auc^2)) / (n_pos * n_neg)
  se <- sqrt(max(var_auc, 1e-12))
  z_ncp <- (auc - auc0) / se
  pwr <- .gp_power_z(z_ncp, alpha, tails)

  .gp_result(
    "Biomarker: One-sample ROC AUC vs null", analysis,
    list(
      tails = pwr$direction, auc_h1 = auc, auc_h0 = auc0,
      n_positive = n_pos, n_negative = n_neg, alpha = alpha
    ),
    list(
      z_statistic = z_ncp, se_auc = se, total_sample_size = n_pos + n_neg,
      power = pwr$power
    ),
    notes = "Hanley-McNeil normal approximation for AUC variance.",
    distribution = list(type = "z", mean = z_ncp)
  )
}

.gp_roc_auc_two <- function(params, analysis) {
  auc1 <- .gp_numeric(params, "auc1", 0.75, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  auc2 <- .gp_numeric(params, "auc2", 0.65, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n1 <- .gp_count(params, "n1", 50, min = 2)
  n2 <- .gp_count(params, "n2", 50, min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  q11 <- auc1 / (2 - auc1)
  q12 <- (2 * auc1^2) / (1 + auc1)
  q21 <- auc2 / (2 - auc2)
  q22 <- (2 * auc2^2) / (1 + auc2)
  var1 <- (auc1 * (1 - auc1) + (n1 - 1) * (q11 - auc1^2) + (n1 - 1) * (q12 - auc1^2)) / (n1^2)
  var2 <- (auc2 * (1 - auc2) + (n2 - 1) * (q21 - auc2^2) + (n2 - 1) * (q22 - auc2^2)) / (n2^2)
  se_diff <- sqrt(max(var1 + var2, 1e-12))
  z_ncp <- (auc1 - auc2) / se_diff
  pwr <- .gp_power_z(z_ncp, alpha, tails)

  .gp_result(
    "Biomarker: Two-sample ROC AUC comparison", analysis,
    list(
      tails = pwr$direction, auc_group_1 = auc1, auc_group_2 = auc2,
      sample_size_group_1 = n1, sample_size_group_2 = n2, alpha = alpha
    ),
    list(
      z_statistic = z_ncp, se_difference = se_diff, total_sample_size = n1 + n2,
      power = pwr$power
    ),
    notes = "DeLong-style normal approximation for AUC difference.",
    distribution = list(type = "z", mean = z_ncp)
  )
}

.gp_diagnostic_acc <- function(params, analysis) {
  sens <- .gp_numeric(params, "sensitivity", 0.85, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  spec <- .gp_numeric(params, "specificity", 0.85, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n_pos <- .gp_count(params, "n_pos", 50, min = 2)
  n_neg <- .gp_count(params, "n_neg", 50, min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  se_sens <- sqrt(sens * (1 - sens) / n_pos)
  se_spec <- sqrt(spec * (1 - spec) / n_neg)
  z_sens <- sens / se_sens
  z_spec <- spec / se_spec
  pwr_sens <- .gp_power_z(z_sens, alpha, tails)
  pwr_spec <- .gp_power_z(z_spec, alpha, tails)
  power <- min(pwr_sens$power, pwr_spec$power)

  .gp_result(
    "Biomarker: Diagnostic accuracy (sensitivity and specificity)", analysis,
    list(
      tails = tails, sensitivity_h1 = sens, specificity_h1 = spec,
      n_positive = n_pos, n_negative = n_neg, alpha = alpha
    ),
    list(
      z_sensitivity = z_sens, z_specificity = z_spec,
      power_sensitivity = pwr_sens$power, power_specificity = pwr_spec$power,
      power = power, total_sample_size = n_pos + n_neg
    ),
    notes = "Joint power uses the minimum of sensitivity and specificity power (Bonferroni-style).",
    distribution = list(type = "z", mean = mean(c(z_sens, z_spec)))
  )
}

.gp_survival_logrank <- function(params, analysis) {
  hr <- .gp_numeric(params, "hazard_ratio", 0.65, min = 0, strict_min = TRUE)
  p_event <- .gp_numeric(params, "event_rate", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  allocation <- .gp_numeric(params, "allocation_ratio", 1, min = 0, strict_min = TRUE)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 200), min = 4)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  p <- allocation / (1 + allocation)
  events <- total_n * p_event
  log_hr <- log(hr)
  z_ncp <- abs(log_hr) * sqrt(events * p * (1 - p))
  pwr <- .gp_power_z(z_ncp, alpha, tails)

  .gp_result(
    "Biomarker: Survival log-rank test", analysis,
    list(
      tails = pwr$direction, hazard_ratio = hr, event_rate = p_event,
      allocation_ratio = allocation, total_sample_size = total_n, alpha = alpha
    ),
    list(
      expected_events = events, z_statistic = z_ncp, power = pwr$power
    ),
    notes = "Schoenfeld/Freedman log-rank approximation for equal follow-up.",
    distribution = list(type = "z", mean = z_ncp)
  )
}

.gp_cox_regression <- function(params, analysis) {
  hr <- .gp_numeric(params, "hazard_ratio", 1.5, min = 0, strict_min = TRUE)
  events <- .gp_count(params, "events", .gp_arg(params, "n", 100), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  log_hr <- log(hr)
  z_ncp <- abs(log_hr) * sqrt(events)
  pwr <- .gp_power_z(z_ncp, alpha, tails)

  .gp_result(
    "Biomarker: Cox proportional hazards (single covariate)", analysis,
    list(tails = pwr$direction, hazard_ratio = hr, events = events, alpha = alpha),
    list(z_statistic = z_ncp, power = pwr$power),
    notes = "Wald test power from expected number of events.",
    distribution = list(type = "z", mean = z_ncp)
  )
}

.gp_discovery_fdr <- function(params, analysis) {
  m_tests <- .gp_count(params, "m_tests", 1000, min = 2)
  pi0 <- .gp_numeric(params, "pi0", 0.9, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  effect_d <- .gp_numeric(params, "effect_d", 0.5, min = 0, strict_min = TRUE)
  n_per_test <- .gp_count(params, "n", 30, min = 2)
  fdr <- .gp_numeric(params, "fdr_level", 0.05, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  alpha <- .gp_alpha(params)

  m1 <- ceiling(m_tests * (1 - pi0))
  df <- n_per_test - 1
  ncp <- effect_d * sqrt(n_per_test)
  pwr_single <- .gp_power_t(df, ncp, alpha, "two")$power
  expected_discoveries <- m1 * pwr_single
  expected_fdr <- (m_tests - m1) * alpha / max(expected_discoveries, 1e-8)
  power <- if (expected_fdr <= fdr) pwr_single else pwr_single * (fdr / expected_fdr)

  .gp_result(
    "Biomarker: Discovery power under FDR control", analysis,
    list(
      m_tests = m_tests, proportion_null = pi0, effect_size_d = effect_d,
      n_per_comparison = n_per_test, fdr_level = fdr, alpha = alpha
    ),
    list(
      alternative_hypotheses = m1, single_test_power = pwr_single,
      expected_discoveries = expected_discoveries, expected_fdr = expected_fdr,
      power = min(power, 1)
    ),
    notes = "BH-FDR framework with independent t-test approximations per biomarker.",
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_ttest_biomarker <- function(params, analysis) {
  result <- .gp_t_two_sample(params, analysis)
  result$test <- "Biomarker: Two-group differential expression (t test)"
  if (!is.null(result$inputs$effect_size_d)) {
    result$inputs$log_fold_change_sd <- result$inputs$effect_size_d
    result$inputs$effect_size_d <- NULL
  }
  result
}
