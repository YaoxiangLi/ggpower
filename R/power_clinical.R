.gp_rct_superiority_continuous <- function(params, analysis) {
  params$tails <- "one"
  result <- .gp_t_two_sample(params, analysis)
  result$test <- "Clinical: RCT superiority (continuous endpoint)"
  result
}

.gp_rct_superiority_binary <- function(params, analysis) {
  params$tails <- "one"
  result <- .gp_exact_fisher(params, analysis)
  result$test <- "Clinical: RCT superiority (binary endpoint)"
  result
}

.gp_rct_noninferiority_continuous <- function(params, analysis) {
  d <- .gp_numeric(params, "d", 0)
  margin <- .gp_numeric(params, "ni_margin", 0.2, min = 0, strict_min = TRUE)
  n1 <- .gp_count(params, "n1", 30, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)
  df <- n1 + n2 - 2
  ncp <- (d + margin) * sqrt(n1 * n2 / (n1 + n2))
  pwr <- .gp_power_t(df, ncp, alpha, "one")

  .gp_result(
    "Clinical: Non-inferiority trial (continuous)", analysis,
    list(
      tails = "one", effect_size_d = d, ni_margin = margin,
      sample_size_group_1 = n1, sample_size_group_2 = n2, alpha = alpha
    ),
    list(
      noncentrality_parameter = ncp, critical_t = pwr$critical, df = df,
      total_sample_size = n1 + n2, power = pwr$power
    ),
    notes = "One-sided NI test: H0 difference <= -margin vs H1 difference > -margin.",
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_rct_noninferiority_binary <- function(params, analysis) {
  p_treat <- .gp_numeric(params, "p1", 0.6, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p_control <- .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  margin <- .gp_numeric(params, "ni_margin", 0.1, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n1 <- .gp_count(params, "n1", 100, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)

  p_eff <- p_treat - p_control + margin
  se <- sqrt(p_control * (1 - p_control) / n2 + p_treat * (1 - p_treat) / n1)
  z_ncp <- p_eff / se
  pwr <- .gp_power_z(z_ncp, alpha, "one")

  .gp_result(
    "Clinical: Non-inferiority trial (binary)", analysis,
    list(
      tails = "one", p_treatment = p_treat, p_control = p_control,
      ni_margin = margin, sample_size_group_1 = n1, sample_size_group_2 = n2, alpha = alpha
    ),
    list(
      z_statistic = z_ncp, total_sample_size = n1 + n2, power = pwr$power
    ),
    notes = "Normal approximation for NI on proportions (one-sided).",
    distribution = list(type = "z", mean = z_ncp)
  )
}

.gp_rct_equivalence_continuous <- function(params, analysis) {
  d <- .gp_numeric(params, "d", 0)
  margin <- .gp_numeric(params, "eq_margin", 0.2, min = 0, strict_min = TRUE)
  n1 <- .gp_count(params, "n1", 30, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)
  df <- n1 + n2 - 2
  se_factor <- sqrt(n1 * n2 / (n1 + n2))
  ncp_upper <- (margin - d) * se_factor
  ncp_lower <- (margin + d) * se_factor
  pwr_upper <- .gp_power_t(df, ncp_upper, alpha, "one")
  pwr_lower <- .gp_power_t(df, ncp_lower, alpha, "one")
  power <- pwr_upper$power * pwr_lower$power

  .gp_result(
    "Clinical: Equivalence trial (continuous, TOST)", analysis,
    list(
      effect_size_d = d, eq_margin = margin,
      sample_size_group_1 = n1, sample_size_group_2 = n2, alpha = alpha
    ),
    list(
      power_upper = pwr_upper$power, power_lower = pwr_lower$power,
      total_sample_size = n1 + n2, power = power
    ),
    notes = "Two one-sided t tests (TOST); overall power is the product of both one-sided powers.",
    distribution = list(type = "t", df = df, ncp = abs(d) * se_factor)
  )
}

.gp_rct_equivalence_proportion <- function(params, analysis) {
  p1 <- .gp_numeric(params, "p1", 0.55, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p0 <- .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  margin <- .gp_numeric(params, "eq_margin", 0.1, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n1 <- .gp_count(params, "n1", 100, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)

  diff <- p1 - p0
  se <- sqrt(p1 * (1 - p1) / n1 + p0 * (1 - p0) / n2)
  z_upper <- (margin - diff) / se
  z_lower <- (margin + diff) / se
  pwr_upper <- .gp_power_z(z_upper, alpha, "one")
  pwr_lower <- .gp_power_z(z_lower, alpha, "one")
  power <- pwr_upper$power * pwr_lower$power

  .gp_result(
    "Clinical: Equivalence trial (proportions, TOST)", analysis,
    list(
      p_treatment = p1, p_control = p0, eq_margin = margin,
      sample_size_group_1 = n1, sample_size_group_2 = n2, alpha = alpha
    ),
    list(
      power_upper = pwr_upper$power, power_lower = pwr_lower$power,
      total_sample_size = n1 + n2, power = power
    ),
    notes = "TOST on proportion difference using normal approximation.",
    distribution = list(type = "z", mean = diff / se)
  )
}

.gp_simon_two_stage <- function(params, analysis) {
  p0 <- .gp_numeric(params, "p0", 0.2, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p1 <- .gp_numeric(params, "p1", 0.35, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  alpha <- .gp_alpha(params)
  beta <- 1 - .gp_power_target(params)
  n1 <- .gp_count(params, "n1", 15, min = 2)
  r1 <- .gp_count(params, "r1", 4, min = 0)
  n2 <- .gp_count(params, "n2", 20, min = 0)
  r <- .gp_count(params, "r", 10, min = 0)

  prob_stage1 <- stats::pbinom(r1, n1, p1, lower.tail = FALSE)
  prob_stage2 <- stats::pbinom(r, n1 + n2, p1, lower.tail = FALSE)
  prob_null <- stats::pbinom(r1, n1, p0, lower.tail = FALSE) *
    stats::pbinom(r, n1 + n2, p0, lower.tail = FALSE)
  power <- prob_stage1 * prob_stage2

  .gp_result(
    "Clinical: Simon two-stage Phase II design", analysis,
    list(
      p0 = p0, p1 = p1, alpha = alpha, target_power = 1 - beta,
      stage1_n = n1, stage1_r = r1, stage2_n = n2, total_r = r
    ),
    list(
      power = power, type_i_error = prob_null,
      total_sample_size = n1 + n2, expected_sample_size = n1 + n2 * prob_stage1
    ),
    notes = "Simon optimal/minimax design power for specified (n1,r1,n2,r).",
    distribution = list(type = "binomial", n = n1 + n2, p = p1)
  )
}

.gp_cluster_rct <- function(params, analysis) {
  d <- .gp_numeric(params, "d", 0.5)
  icc <- .gp_numeric(params, "icc", 0.05, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  cluster_size <- .gp_count(params, "cluster_size", 10, min = 2)
  n_clusters <- .gp_count(params, "n_clusters", .gp_arg(params, "total_n", 20), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  deff <- 1 + (cluster_size - 1) * icc
  n_eff <- n_clusters * cluster_size / deff
  df <- max(2, 2 * n_clusters - 2)
  ncp <- d * sqrt(n_eff / 2)
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "Clinical: Cluster-randomized trial", analysis,
    list(
      tails = pwr$direction, effect_size_d = d, icc = icc,
      cluster_size = cluster_size, n_clusters_per_arm = n_clusters, alpha = alpha
    ),
    list(
      design_effect = deff, effective_n_per_arm = n_eff,
      noncentrality_parameter = ncp, power = pwr$power,
      total_sample_size = 2 * n_clusters * cluster_size
    ),
    notes = "Design effect DE = 1 + (m-1)*ICC applied to two-arm cluster RCT.",
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_multi_arm_superiority <- function(params, analysis) {
  result <- .gp_f_anova_one_way(params, analysis)
  result$test <- "Clinical: Multi-arm superiority (ANOVA)"
  result$notes <- c(result$notes, "Consider Dunnett adjustment for pairwise comparisons.")
  result
}

.gp_count_endpoint_poisson <- function(params, analysis) {
  result <- .gp_z_poisson(params, analysis)
  result$test <- "Clinical: Count endpoint (Poisson regression)"
  result
}

.gp_survival_pmu <- function(params, analysis) {
  result <- .gp_survival_logrank(params, analysis)
  result$test <- "Clinical: Survival endpoint (log-rank / Cox framework)"
  result
}
