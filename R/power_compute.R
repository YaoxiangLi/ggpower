#' Compute statistical power analyses
#'
#' @param test Character test id. Use `ggpower_tests()` to list ids.
#' @param analysis One of `a_priori`, `compromise`, `criterion`, `post_hoc`,
#'   or `sensitivity`.
#' @param ... Test-specific inputs.
#'
#' @return A `ggpower_result` object.
#' @export
power_compute <- function(test, analysis = "post_hoc", ...) {
  spec <- ggpower_get_test(test)
  analysis <- match.arg(
    analysis,
    choices = c("a_priori", "compromise", "criterion", "post_hoc", "sensitivity")
  )

  if (!analysis %in% spec$modes) {
    stop("'", analysis, "' is not supported for ", spec$label, ".", call. = FALSE)
  }

  params <- list(...)
  params$test <- spec$id
  params$analysis <- analysis

  switch(
    analysis,
    post_hoc = .gp_post_hoc(spec$id, params, analysis),
    a_priori = .gp_solve_n(spec, params),
    criterion = .gp_solve_alpha(spec, params),
    sensitivity = .gp_solve_effect(spec, params),
    compromise = .gp_solve_compromise(spec, params)
  )
}

.gp_solve_n <- function(spec, params) {
  target <- .gp_power_target(params)
  lower <- .gp_min_total_n(spec$id, params)
  upper <- max(50, lower * 2)

  objective <- function(n_total) {
    trial <- .gp_set_total_n(spec$id, params, ceiling(n_total))
    .gp_output_power(.gp_post_hoc(spec$id, trial, "a_priori")) - target
  }

  while (objective(upper) < 0 && upper < 1e7) {
    upper <- upper * 2
  }
  if (objective(upper) < 0) {
    stop("Requested power could not be reached before N = 10,000,000.", call. = FALSE)
  }

  if (objective(lower) >= 0) {
    n_total <- lower
  } else {
    n_total <- ceiling(.gp_solve_root(objective, lower, upper, "sample size"))
    while (objective(n_total) < 0) {
      n_total <- n_total + 1
    }
  }

  out <- .gp_post_hoc(spec$id, .gp_set_total_n(spec$id, params, n_total), "a_priori")
  out$inputs$target_power <- target
  out$outputs$actual_power <- out$outputs$power
  out$outputs$power <- NULL
  out$notes <- c(out$notes, "A priori sample sizes are rounded up to integer values and actual power is recomputed.")
  out
}

.gp_solve_alpha <- function(spec, params) {
  target <- .gp_power_target(params)
  objective <- function(alpha) {
    trial <- params
    trial$alpha <- alpha
    .gp_output_power(.gp_post_hoc(spec$id, trial, "criterion")) - target
  }

  alpha <- .gp_solve_root(objective, 1e-8, 0.999999, "alpha")
  out <- .gp_post_hoc(spec$id, within(params, alpha <- alpha), "criterion")
  out$inputs$target_power <- target
  out$outputs$alpha <- alpha
  out$outputs$beta <- 1 - out$outputs$power
  out
}

.gp_solve_effect <- function(spec, params) {
  target <- .gp_power_target(params)
  effect_name <- spec$effect

  if (effect_name %in% c("variance_ratio", "odds_ratio", "exp_beta1", "p1", "auc", "auc1", "hazard_ratio", "sensitivity")) {
    null <- switch(
      effect_name,
      p1 = .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE),
      auc = .gp_numeric(params, "auc0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE),
      auc1 = .gp_arg(params, "auc2", 0.65),
      hazard_ratio = 1,
      sensitivity = 0.5,
      1
    )
    start <- .gp_arg(params, effect_name, .gp_default_effect(effect_name))
    direction <- if (is.numeric(start) && length(start) == 1 && start < null) -1 else 1
    max_delta <- if (effect_name == "p1") {
      if (direction > 0) 1 - null - 1e-8 else null - 1e-8
    } else if (effect_name %in% c("auc", "sensitivity")) {
      if (direction > 0) 1 - null - 1e-8 else null - 1e-8
    } else if (effect_name == "hazard_ratio") {
      if (direction > 0) 1e4 - null else null - 1e-8
    } else if (direction > 0) {
      1e4 - null
    } else {
      null - 1e-8
    }
    if (max_delta <= 1e-8) {
      stop("Requested effect-size direction leaves no valid search range.", call. = FALSE)
    }

    lower <- 1e-8
    upper <- min(max(abs(start - null), 0.1), max_delta)
    ratio_objective <- function(delta) {
      trial <- params
      trial[[effect_name]] <- null + direction * delta
      .gp_output_power(.gp_post_hoc(spec$id, trial, "sensitivity")) - target
    }

    while (ratio_objective(upper) < 0 && upper < max_delta) {
      upper <- min(upper * 2, max_delta)
    }
    if (ratio_objective(upper) < 0) {
      stop("Requested power could not be reached for the effect-size search range.", call. = FALSE)
    }

    delta <- if (ratio_objective(lower) >= 0) {
      lower
    } else {
      .gp_solve_root(ratio_objective, lower, upper, "effect size")
    }
    params[[effect_name]] <- null + direction * delta
    out <- .gp_post_hoc(spec$id, params, "sensitivity")
    out$inputs$target_power <- target
    out$outputs[[effect_name]] <- params[[effect_name]]
    return(out)
  }

  if (effect_name %in% c("rho", "rho_ac", "rho_cd")) {
    null <- switch(
      effect_name,
      rho = .gp_arg(params, "rho0", 0),
      rho_ac = .gp_arg(params, "rho_ab", 0.4),
      rho_cd = .gp_arg(params, "rho_ab", 0.1)
    )
    null <- .gp_check_correlation(null, paste0(effect_name, "_null"))
    start <- switch(
      effect_name,
      rho = .gp_arg(params, "rho", .gp_default_effect("rho")),
      rho_ac = .gp_arg(params, "rho_ac", 0.2),
      rho_cd = .gp_arg(params, "rho_cd", 0.2)
    )
    preferred_direction <- if (is.numeric(start) && length(start) == 1 && start < null) -1 else 1
    directions <- unique(c(preferred_direction, -preferred_direction))

    for (direction in directions) {
      max_delta <- if (direction > 0) 1 - null - 1e-8 else null + 1 - 1e-8
      if (max_delta <= 1e-8) {
        next
      }

      lower <- 1e-8
      upper <- min(max(abs(start - null), 0.1), max_delta)
      correlation_objective <- function(delta) {
        trial <- params
        trial[[effect_name]] <- null + direction * delta
        .gp_output_power(.gp_post_hoc(spec$id, trial, "sensitivity")) - target
      }

      found_upper <- FALSE
      while (TRUE) {
        upper_value <- tryCatch(correlation_objective(upper), error = function(e) NA_real_)
        if (is.finite(upper_value) && upper_value >= 0) {
          found_upper <- TRUE
          break
        }
        if (upper >= max_delta) {
          break
        }
        upper <- min(upper * 2, max_delta)
      }
      if (!found_upper) {
        next
      }

      delta <- if (correlation_objective(lower) >= 0) {
        lower
      } else {
        .gp_solve_root(correlation_objective, lower, upper, "effect size")
      }
      params[[effect_name]] <- null + direction * delta
      out <- .gp_post_hoc(spec$id, params, "sensitivity")
      out$inputs$target_power <- target
      out$outputs[[effect_name]] <- params[[effect_name]]
      return(out)
    }

    stop("Requested power could not be reached for the effect-size search range.", call. = FALSE)
  }

  start <- abs(.gp_arg(params, effect_name, .gp_default_effect(effect_name)))
  lower <- 1e-8
  upper <- max(start, 0.1)

  effect_objective <- function(effect) {
    trial <- params
    trial[[effect_name]] <- .gp_effect_sign(params, effect_name) * effect
    .gp_output_power(.gp_post_hoc(spec$id, trial, "sensitivity")) - target
  }

  while (effect_objective(upper) < 0 && upper < 1e4) {
    upper <- upper * 2
  }
  if (effect_objective(upper) < 0) {
    stop("Requested power could not be reached for the effect-size search range.", call. = FALSE)
  }

  effect <- .gp_solve_root(effect_objective, lower, upper, "effect size")
  params[[effect_name]] <- .gp_effect_sign(params, effect_name) * effect
  out <- .gp_post_hoc(spec$id, params, "sensitivity")
  out$inputs$target_power <- target
  out$outputs[[effect_name]] <- params[[effect_name]]
  out
}

.gp_solve_compromise <- function(spec, params) {
  q <- .gp_numeric(params, "q", 1, min = 0, strict_min = TRUE)

  objective <- function(alpha) {
    trial <- params
    trial$alpha <- alpha
    power <- .gp_output_power(.gp_post_hoc(spec$id, trial, "compromise"))
    beta <- 1 - power
    beta / alpha - q
  }

  alpha <- tryCatch(
    .gp_solve_root(objective, 1e-8, 0.999999, "alpha-beta compromise"),
    error = function(e) {
      opt <- stats::optimize(function(a) abs(objective(a)), c(1e-8, 0.999999))
      opt$minimum
    }
  )

  out <- .gp_post_hoc(spec$id, within(params, alpha <- alpha), "compromise")
  out$outputs$alpha <- alpha
  out$outputs$beta <- 1 - out$outputs$power
  out$outputs$beta_alpha_ratio <- out$outputs$beta / alpha
  out$notes <- c(out$notes, "Compromise analysis solves alpha so beta / alpha matches the requested ratio as closely as possible.")
  out
}

.gp_post_hoc <- function(test, params, analysis = "post_hoc") {
  switch(
    test,
    t_one_sample = .gp_t_one_sample(params, analysis),
    t_paired = .gp_t_paired(params, analysis),
    t_two_sample = .gp_t_two_sample(params, analysis),
    t_point_biserial = .gp_t_point_biserial(params, analysis),
    t_linear_regression = .gp_t_linear_regression(params, analysis),
    t_linear_regression_two_groups = .gp_t_linear_regression_two_groups(params, analysis),
    t_generic = .gp_t_generic(params, analysis),
    f_anova_one_way = .gp_f_anova_one_way(params, analysis),
    f_anova_special = .gp_f_anova_special(params, analysis),
    f_mreg_omnibus = .gp_f_mreg_omnibus(params, analysis),
    f_mreg_increase = .gp_f_mreg_increase(params, analysis),
    f_variance_two = .gp_f_variance_two(params, analysis),
    chisq_variance_one = .gp_chisq_variance_one(params, analysis),
    chisq_gof = .gp_chisq_power(params, analysis, "Goodness-of-fit tests: Contingency tables"),
    chisq_contingency = .gp_chisq_power(params, analysis, "Contingency tables"),
    exact_binomial = .gp_exact_binomial(params, analysis, "Generic binomial test"),
    exact_one_proportion = .gp_exact_binomial(params, analysis, "Proportion: Difference from constant"),
    exact_sign = .gp_exact_binomial(params, analysis, "Proportion: Sign test"),
    exact_mcnemar = .gp_exact_binomial(params, analysis, "McNemar test approximation through discordant-pair binomial test"),
    exact_fisher = .gp_exact_fisher(params, analysis),
    exact_correlation = .gp_exact_correlation(params, analysis),
    exact_mreg_random = .gp_exact_mreg_random(params, analysis),
    z_corr_independent = .gp_z_corr_independent(params, analysis),
    z_corr_dependent_common = .gp_z_corr_dependent_common(params, analysis),
    z_corr_dependent_no_common = .gp_z_corr_dependent_no_common(params, analysis),
    z_logistic = .gp_z_logistic(params, analysis),
    z_poisson = .gp_z_poisson(params, analysis),
    z_tetrachoric = .gp_z_tetrachoric(params, analysis),
    wilcoxon_signed = .gp_wilcoxon_signed(params, analysis),
    wilcoxon_mann_whitney = .gp_wilcoxon_mann_whitney(params, analysis),
    roc_auc_one = .gp_roc_auc_one(params, analysis),
    roc_auc_two = .gp_roc_auc_two(params, analysis),
    diagnostic_acc = .gp_diagnostic_acc(params, analysis),
    survival_logrank = .gp_survival_logrank(params, analysis),
    cox_regression = .gp_cox_regression(params, analysis),
    discovery_fdr = .gp_discovery_fdr(params, analysis),
    ttest_biomarker = .gp_ttest_biomarker(params, analysis),
    rct_superiority_continuous = .gp_rct_superiority_continuous(params, analysis),
    rct_superiority_binary = .gp_rct_superiority_binary(params, analysis),
    rct_noninferiority_continuous = .gp_rct_noninferiority_continuous(params, analysis),
    rct_noninferiority_binary = .gp_rct_noninferiority_binary(params, analysis),
    rct_equivalence_continuous = .gp_rct_equivalence_continuous(params, analysis),
    rct_equivalence_proportion = .gp_rct_equivalence_proportion(params, analysis),
    simon_two_stage = .gp_simon_two_stage(params, analysis),
    cluster_rct = .gp_cluster_rct(params, analysis),
    multi_arm_superiority = .gp_multi_arm_superiority(params, analysis),
    count_endpoint_poisson = .gp_count_endpoint_poisson(params, analysis),
    survival_pmu = .gp_survival_pmu(params, analysis),
    stop("No compute kernel registered for '", test, "'.", call. = FALSE)
  )
}

.gp_t_one_sample <- function(params, analysis) {
  d <- .gp_numeric(params, "d", 0.5)
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 40), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n - 1
  ncp <- d * sqrt(n)
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Means - difference from constant (one sample case)", analysis,
    list(tails = pwr$direction, effect_size_d = d, alpha = alpha, total_sample_size = n),
    list(noncentrality_parameter = ncp, critical_t = pwr$critical, df = df, power = pwr$power),
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_t_paired <- function(params, analysis) {
  result <- .gp_t_one_sample(params, analysis)
  result$test <- "t test: Means - difference between two dependent means (matched pairs)"
  names(result$inputs)[names(result$inputs) == "effect_size_d"] <- "effect_size_dz"
  result
}

.gp_t_two_sample <- function(params, analysis) {
  d <- .gp_numeric(params, "d", 0.5)
  n1 <- .gp_count(params, "n1", .gp_arg(params, "n_per_group", 30), min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n1 + n2 - 2
  ncp <- d * sqrt(n1 * n2 / (n1 + n2))
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Means - difference between two independent means (two groups)", analysis,
    list(tails = pwr$direction, effect_size_d = d, alpha = alpha, sample_size_group_1 = n1, sample_size_group_2 = n2),
    list(noncentrality_parameter = ncp, critical_t = pwr$critical, df = df, total_sample_size = n1 + n2, power = pwr$power),
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_t_point_biserial <- function(params, analysis) {
  rho <- abs(.gp_check_correlation(.gp_numeric(params, "rho", 0.3), "rho"))
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 4)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n - 2
  ncp <- sqrt(rho^2 * n / (1 - rho^2))
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Correlation - point biserial model", analysis,
    list(tails = pwr$direction, effect_size_rho = rho, alpha = alpha, total_sample_size = n),
    list(noncentrality_parameter = ncp, critical_t = pwr$critical, df = df, power = pwr$power),
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_t_generic <- function(params, analysis) {
  ncp <- .gp_numeric(params, "ncp", 1)
  df <- .gp_numeric(params, "df", .gp_numeric(params, "n", 30) - 1, min = 1)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Generic case", analysis,
    list(tails = pwr$direction, noncentrality_parameter = ncp, alpha = alpha, df = df),
    list(critical_t = pwr$critical, power = pwr$power),
    notes = "Generic t tests do not have a unique sample-size definition, so a priori mode is not available.",
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_t_linear_regression <- function(params, analysis) {
  slope_h1 <- .gp_numeric(params, "slope_h1", -0.0667)
  slope_h0 <- .gp_numeric(params, "slope_h0", 0)
  sd_x <- .gp_numeric(params, "sd_x", 1, min = 0, strict_min = TRUE)
  sd_y <- .gp_numeric(params, "sd_y", 1, min = 0, strict_min = TRUE)
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 3)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n - 2
  ncp <- sqrt(n) * sd_x * (slope_h1 - slope_h0) / sd_y
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Linear Regression (size of slope, one group)", analysis,
    list(tails = pwr$direction, slope_h1 = slope_h1, slope_h0 = slope_h0, sd_x = sd_x, sd_y = sd_y, alpha = alpha, total_sample_size = n),
    list(noncentrality_parameter = ncp, critical_t = pwr$critical, df = df, power = pwr$power),
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_t_linear_regression_two_groups <- function(params, analysis) {
  delta_slope <- .gp_numeric(params, "delta_slope", 0.1)
  residual_sd <- .gp_numeric(params, "residual_sd", 1, min = 0, strict_min = TRUE)
  sd_x1 <- .gp_numeric(params, "sd_x1", 1, min = 0, strict_min = TRUE)
  sd_x2 <- .gp_numeric(params, "sd_x2", 1, min = 0, strict_min = TRUE)
  n1 <- .gp_count(params, "n1", 30, min = 3)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 3)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n1 + n2 - 4
  se <- residual_sd * sqrt(1 / (n1 * sd_x1^2) + 1 / (n2 * sd_x2^2))
  ncp <- delta_slope / se
  pwr <- .gp_power_t(df, ncp, alpha, tails)

  .gp_result(
    "t test: Linear Regression (two groups)", analysis,
    list(tails = pwr$direction, delta_slope = delta_slope, residual_sd = residual_sd, sd_x1 = sd_x1, sd_x2 = sd_x2, alpha = alpha, sample_size_group_1 = n1, sample_size_group_2 = n2),
    list(noncentrality_parameter = ncp, critical_t = pwr$critical, df = df, total_sample_size = n1 + n2, power = pwr$power),
    distribution = list(type = "t", df = df, ncp = ncp)
  )
}

.gp_f_anova_one_way <- function(params, analysis) {
  f <- .gp_numeric(params, "f", 0.25, min = 0, strict_min = TRUE)
  groups <- .gp_count(params, "groups", 3, min = 2)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 60), min = groups + 2)
  alpha <- .gp_alpha(params)
  df1 <- groups - 1
  df2 <- total_n - groups
  ncp <- f^2 * total_n
  pwr <- .gp_power_f(df1, df2, ncp, alpha)

  .gp_result(
    "F test: Fixed effects ANOVA - one way", analysis,
    list(effect_size_f = f, alpha = alpha, total_sample_size = total_n, groups = groups),
    list(noncentrality_parameter = ncp, critical_f = pwr$critical, numerator_df = df1, denominator_df = df2, power = pwr$power),
    distribution = list(type = "F", df1 = df1, df2 = df2, ncp = ncp)
  )
}

.gp_f_anova_special <- function(params, analysis) {
  f <- .gp_numeric(params, "f", 0.25, min = 0, strict_min = TRUE)
  df1 <- .gp_numeric(params, "df1", 1, min = 1)
  groups <- .gp_count(params, "groups", 4, min = 2)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 80), min = groups + 2)
  alpha <- .gp_alpha(params)
  df2 <- total_n - groups
  ncp <- f^2 * total_n
  pwr <- .gp_power_f(df1, df2, ncp, alpha)

  .gp_result(
    "F test: Fixed effects ANOVA - special, main effects and interactions", analysis,
    list(effect_size_f = f, alpha = alpha, total_sample_size = total_n, numerator_df = df1, groups = groups),
    list(noncentrality_parameter = ncp, critical_f = pwr$critical, denominator_df = df2, power = pwr$power),
    distribution = list(type = "F", df1 = df1, df2 = df2, ncp = ncp)
  )
}

.gp_f_mreg_omnibus <- function(params, analysis) {
  f2 <- .gp_numeric(params, "f2", 0.15, min = 0, strict_min = TRUE)
  predictors <- .gp_count(params, "predictors", 1, min = 1)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 100), min = predictors + 3)
  alpha <- .gp_alpha(params)
  df1 <- predictors
  df2 <- total_n - predictors - 1
  ncp <- f2 * total_n
  pwr <- .gp_power_f(df1, df2, ncp, alpha)

  .gp_result(
    "F test: Multiple Regression - omnibus (deviation of R2 from zero), fixed model", analysis,
    list(effect_size_f2 = f2, alpha = alpha, total_sample_size = total_n, predictors = predictors),
    list(noncentrality_parameter = ncp, critical_f = pwr$critical, numerator_df = df1, denominator_df = df2, power = pwr$power),
    distribution = list(type = "F", df1 = df1, df2 = df2, ncp = ncp)
  )
}

.gp_f_mreg_increase <- function(params, analysis) {
  f2 <- .gp_numeric(params, "f2", 0.15, min = 0, strict_min = TRUE)
  tested <- .gp_count(params, "tested_predictors", .gp_arg(params, "df1", 1), min = 1)
  predictors <- .gp_count(params, "predictors", tested + 1, min = tested)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 120), min = predictors + 3)
  alpha <- .gp_alpha(params)
  df2 <- total_n - predictors - 1
  ncp <- f2 * total_n
  pwr <- .gp_power_f(tested, df2, ncp, alpha)

  .gp_result(
    "F test: Multiple Regression - special (increase of R2), fixed model", analysis,
    list(effect_size_f2 = f2, alpha = alpha, total_sample_size = total_n, tested_predictors = tested, total_predictors = predictors),
    list(noncentrality_parameter = ncp, critical_f = pwr$critical, numerator_df = tested, denominator_df = df2, power = pwr$power),
    distribution = list(type = "F", df1 = tested, df2 = df2, ncp = ncp)
  )
}

.gp_f_variance_two <- function(params, analysis) {
  ratio <- .gp_numeric(params, "variance_ratio", 1.5, min = 0, strict_min = TRUE)
  n1 <- .gp_count(params, "n1", 30, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df1 <- n1 - 1
  df2 <- n2 - 1

  if (tails == "two") {
    lower <- stats::qf(alpha / 2, df1, df2)
    upper <- stats::qf(1 - alpha / 2, df1, df2)
    power <- stats::pf(lower / ratio, df1, df2) + 1 - stats::pf(upper / ratio, df1, df2)
    critical <- c(lower = lower, upper = upper)
    direction <- "two"
  } else if (ratio < 1) {
    critical <- stats::qf(alpha, df1, df2)
    power <- stats::pf(critical / ratio, df1, df2)
    direction <- "less"
  } else {
    critical <- stats::qf(1 - alpha, df1, df2)
    power <- 1 - stats::pf(critical / ratio, df1, df2)
    direction <- "greater"
  }

  .gp_result(
    "F test: Inequality of two variances", analysis,
    list(tails = direction, ratio_var1_var0 = ratio, alpha = alpha, sample_size_group_1 = n1, sample_size_group_2 = n2),
    list(critical_f = critical, numerator_df = df1, denominator_df = df2, total_sample_size = n1 + n2, power = power),
    notes = "Two-variance power uses the scaled central F distribution.",
    distribution = list(type = "F", df1 = df1, df2 = df2, scale = ratio)
  )
}

.gp_chisq_variance_one <- function(params, analysis) {
  ratio <- .gp_numeric(params, "variance_ratio", 0.667, min = 0, strict_min = TRUE)
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 80), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  df <- n - 1

  if (tails == "two") {
    lower <- stats::qchisq(alpha / 2, df)
    upper <- stats::qchisq(1 - alpha / 2, df)
    power <- stats::pchisq(lower / ratio, df) + 1 - stats::pchisq(upper / ratio, df)
    critical <- c(lower = lower, upper = upper)
    direction <- "two"
  } else if (ratio < 1) {
    critical <- stats::qchisq(alpha, df)
    power <- stats::pchisq(critical / ratio, df)
    direction <- "less"
  } else {
    critical <- stats::qchisq(1 - alpha, df)
    power <- 1 - stats::pchisq(critical / ratio, df)
    direction <- "greater"
  }

  .gp_result(
    "chi-square test: Variance - difference from constant (one sample case)", analysis,
    list(tails = direction, ratio_var1_var0 = ratio, alpha = alpha, total_sample_size = n),
    list(critical_chisq = critical, df = df, power = power),
    distribution = list(type = "chi-square", df = df, scale = ratio)
  )
}

.gp_chisq_power <- function(params, analysis, label) {
  w <- .gp_numeric(params, "w", 0.3, min = 0, strict_min = TRUE)
  df <- .gp_numeric(params, "df", 1, min = 1)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 100), min = 2)
  alpha <- .gp_alpha(params)
  ncp <- total_n * w^2
  pwr <- .gp_power_chisq(df, ncp, alpha)

  .gp_result(
    paste("chi-square test:", label), analysis,
    list(effect_size_w = w, alpha = alpha, total_sample_size = total_n, df = df),
    list(noncentrality_parameter = ncp, critical_chisq = pwr$critical, power = pwr$power),
    distribution = list(type = "chi-square", df = df, ncp = ncp)
  )
}

.gp_exact_binomial <- function(params, analysis, label) {
  p0 <- .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p1 <- .gp_numeric(params, "p1", 0.65, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 50), min = 1)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  alternative <- if (tails == "two") "two.sided" else if (p1 < p0) "less" else "greater"
  power <- .gp_binomial_power(n, p0, p1, alpha, alternative)

  .gp_result(
    paste("Exact:", label), analysis,
    list(tails = alternative, p_h0 = p0, p_h1 = p1, alpha = alpha, total_sample_size = n),
    list(power = power),
    notes = "Exact binomial power sums probabilities for outcomes whose exact binomial-test p-value is at or below alpha.",
    distribution = list(type = "binomial", n = n, p0 = p0, p1 = p1)
  )
}

.gp_exact_fisher <- function(params, analysis) {
  p0 <- .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p1 <- .gp_numeric(params, "p1", 0.65, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  n1 <- .gp_count(params, "n1", 40, min = 2)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 2)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  alternative <- if (tails == "two") "two.sided" else if (p1 < p0) "greater" else "less"
  exact_power <- .gp_fisher_power(n1, n2, p0, p1, alpha, alternative)
  h <- .gp_phi_to_h(p1, p0)

  .gp_result(
    "Exact: Proportions - inequality of two independent groups (Fisher exact)", analysis,
    list(tails = alternative, p_group_1 = p0, p_group_2 = p1, alpha = alpha, sample_size_group_1 = n1, sample_size_group_2 = n2),
    list(effect_size_h = h, total_sample_size = n1 + n2, power = exact_power),
    notes = "Fisher exact power enumerates all two-binomial outcome pairs and sums outcomes rejected by Fisher's exact test.",
    distribution = list(type = "fisher_exact", n1 = n1, n2 = n2, p0 = p0, p1 = p1)
  )
}

.gp_exact_correlation <- function(params, analysis) {
  rho0 <- .gp_check_correlation(.gp_numeric(params, "rho0", 0), "rho0")
  rho <- .gp_check_correlation(.gp_numeric(params, "rho", 0.3), "rho")
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  q <- .gp_fisher_z(rho) - .gp_fisher_z(rho0)
  mean_h1 <- q * sqrt(n - 3)
  pwr <- .gp_power_z(mean_h1, alpha, tails)

  .gp_result(
    "Exact: Correlation - difference from constant (one sample case)", analysis,
    list(tails = pwr$direction, rho_h0 = rho0, rho_h1 = rho, alpha = alpha, total_sample_size = n),
    list(effect_size_q = q, critical_z = pwr$critical, power = pwr$power),
    notes = "Correlation support uses Fisher Z approximation; exact small-sample correlation distribution is planned.",
    distribution = list(type = "normal", mean_h1 = mean_h1)
  )
}

.gp_exact_mreg_random <- function(params, analysis) {
  rho2 <- .gp_numeric(params, "rho2", .gp_arg(params, "r2", 0.1), min = 0, max = 1, strict_max = TRUE)
  predictors <- .gp_count(params, "predictors", 1, min = 1)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 100), min = predictors + 3)
  alpha <- .gp_alpha(params)
  df1 <- predictors
  df2 <- total_n - predictors - 1
  f2 <- rho2 / (1 - rho2)
  ncp <- f2 * total_n
  pwr <- .gp_power_f(df1, df2, ncp, alpha)

  .gp_result(
    "Exact test: Multiple Regression - random model", analysis,
    list(rho2 = rho2, alpha = alpha, total_sample_size = total_n, predictors = predictors),
    list(effect_size_f2 = f2, noncentrality_parameter = ncp, critical_f = pwr$critical, numerator_df = df1, denominator_df = df2, power = pwr$power),
    notes = "Random-model multiple regression uses the noncentral F representation for R2 planning.",
    distribution = list(type = "F", df1 = df1, df2 = df2, ncp = ncp)
  )
}

.gp_z_corr_independent <- function(params, analysis) {
  q_effect <- .gp_numeric(params, "q_effect", .gp_arg(params, "q_corr", 0.3))
  n1 <- .gp_count(params, "n1", 50, min = 4)
  n2 <- .gp_count(params, "n2", .gp_arg(params, "n_per_group", n1), min = 4)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  se <- sqrt(1 / (n1 - 3) + 1 / (n2 - 3))
  mean_h1 <- q_effect / se
  pwr <- .gp_power_z(mean_h1, alpha, tails)

  .gp_result(
    "z test: Correlation - inequality of two independent Pearson r's", analysis,
    list(tails = pwr$direction, effect_size_q = q_effect, alpha = alpha, sample_size_group_1 = n1, sample_size_group_2 = n2),
    list(critical_z = pwr$critical, total_sample_size = n1 + n2, power = pwr$power),
    distribution = list(type = "normal", mean_h1 = mean_h1)
  )
}

.gp_z_corr_dependent_common <- function(params, analysis) {
  rho_ab <- .gp_check_correlation(.gp_numeric(params, "rho_ab", 0.4), "rho_ab")
  rho_ac <- .gp_check_correlation(.gp_numeric(params, "rho_ac", 0.2), "rho_ac")
  rho_bc <- .gp_check_correlation(.gp_numeric(params, "rho_bc", 0.5), "rho_bc")
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  mat_h1 <- matrix(c(1, rho_ab, rho_ac, rho_ab, 1, rho_bc, rho_ac, rho_bc, 1), 3, 3)
  if (!.gp_positive_semidefinite(mat_h1)) {
    stop("The supplied correlations do not form a valid correlation matrix.", call. = FALSE)
  }

  c0 <- .gp_corr_cov_common(rho_ab, rho_ab, rho_bc)
  c1 <- .gp_corr_cov_common(rho_ab, rho_ac, rho_bc)
  s0 <- sqrt((2 - 2 * c0) / (n - 3))
  s1 <- sqrt((2 - 2 * c1) / (n - 3)) / s0
  mean_h1 <- (.gp_fisher_z(rho_ab) - .gp_fisher_z(rho_ac)) / s0
  pwr <- .gp_power_z(mean_h1, alpha, tails, sd_h1 = s1)

  .gp_result(
    "z test: Correlation - inequality of two dependent Pearson r's (common index)", analysis,
    list(tails = pwr$direction, rho_ab = rho_ab, rho_ac = rho_ac, rho_bc = rho_bc, alpha = alpha, total_sample_size = n),
    list(critical_z = pwr$critical, power = pwr$power),
    distribution = list(type = "normal", mean_h1 = mean_h1, sd_h1 = s1)
  )
}

.gp_z_corr_dependent_no_common <- function(params, analysis) {
  rho_ab <- .gp_check_correlation(.gp_numeric(params, "rho_ab", 0.1), "rho_ab")
  rho_cd <- .gp_check_correlation(.gp_numeric(params, "rho_cd", 0.2), "rho_cd")
  rho_ac <- .gp_check_correlation(.gp_numeric(params, "rho_ac", 0.5), "rho_ac")
  rho_ad <- .gp_check_correlation(.gp_numeric(params, "rho_ad", 0.4), "rho_ad")
  rho_bc <- .gp_check_correlation(.gp_numeric(params, "rho_bc", -0.4), "rho_bc")
  rho_bd <- .gp_check_correlation(.gp_numeric(params, "rho_bd", 0.8), "rho_bd")
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)

  mat_h1 <- matrix(
    c(1, rho_ab, rho_ac, rho_ad,
      rho_ab, 1, rho_bc, rho_bd,
      rho_ac, rho_bc, 1, rho_cd,
      rho_ad, rho_bd, rho_cd, 1),
    4, 4
  )
  if (!.gp_positive_semidefinite(mat_h1)) {
    stop("The supplied correlations do not form a valid correlation matrix.", call. = FALSE)
  }

  c0 <- .gp_corr_cov_no_common(rho_ab, rho_ab, rho_ac, rho_ad, rho_bc, rho_bd)
  c1 <- .gp_corr_cov_no_common(rho_ab, rho_cd, rho_ac, rho_ad, rho_bc, rho_bd)
  s0 <- sqrt((2 - 2 * c0) / (n - 3))
  s1 <- sqrt((2 - 2 * c1) / (n - 3)) / s0
  mean_h1 <- (.gp_fisher_z(rho_ab) - .gp_fisher_z(rho_cd)) / s0
  pwr <- .gp_power_z(mean_h1, alpha, tails, sd_h1 = s1)

  .gp_result(
    "z test: Correlation - inequality of two dependent Pearson r's (no common index)", analysis,
    list(tails = pwr$direction, rho_ab = rho_ab, rho_cd = rho_cd, rho_ac = rho_ac, rho_ad = rho_ad, rho_bc = rho_bc, rho_bd = rho_bd, alpha = alpha, total_sample_size = n),
    list(critical_z = pwr$critical, power = pwr$power),
    distribution = list(type = "normal", mean_h1 = mean_h1, sd_h1 = s1)
  )
}

.gp_z_logistic <- function(params, analysis) {
  odds_ratio <- .gp_numeric(params, "odds_ratio", 1.5, min = 0, strict_min = TRUE)
  p0 <- .gp_numeric(params, "p0", 0.5, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 300), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  r2 <- .gp_numeric(params, "r2_other", 0, min = 0, max = 1)
  x_var <- .gp_var_x(params)
  beta <- log(odds_ratio)
  mean_h1 <- beta * sqrt(total_n * (1 - r2) * p0 * (1 - p0) * x_var)
  pwr <- .gp_power_z(mean_h1, alpha, tails)

  .gp_result(
    "z test: Multiple logistic regression", analysis,
    list(tails = pwr$direction, odds_ratio = odds_ratio, p_h0 = p0, alpha = alpha, total_sample_size = total_n, r2_other_x = r2, x_variance = x_var),
    list(critical_z = pwr$critical, beta1 = beta, power = pwr$power),
    notes = "Logistic regression support uses a large-sample Wald approximation suitable for planning; enumeration and Demidenko variants can be added later.",
    distribution = list(type = "normal", mean_h1 = mean_h1)
  )
}

.gp_z_poisson <- function(params, analysis) {
  exp_beta1 <- .gp_numeric(params, "exp_beta1", 1.3, min = 0, strict_min = TRUE)
  base_rate <- .gp_numeric(params, "base_rate", 0.85, min = 0, strict_min = TRUE)
  exposure <- .gp_numeric(params, "exposure", 1, min = 0, strict_min = TRUE)
  total_n <- .gp_count(params, "total_n", .gp_arg(params, "n", 300), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  r2 <- .gp_numeric(params, "r2_other", 0, min = 0, max = 1)
  x_var <- .gp_var_x(params)
  beta <- log(exp_beta1)
  mean_h1 <- beta * sqrt(total_n * (1 - r2) * base_rate * exposure * x_var)
  pwr <- .gp_power_z(mean_h1, alpha, tails)

  .gp_result(
    "z test: Poisson regression", analysis,
    list(tails = pwr$direction, exp_beta1 = exp_beta1, base_rate = base_rate, exposure = exposure, alpha = alpha, total_sample_size = total_n, r2_other_x = r2, x_variance = x_var),
    list(critical_z = pwr$critical, beta1 = beta, power = pwr$power),
    notes = "Poisson regression support uses a large-sample Wald approximation; exact enumeration is a future refinement.",
    distribution = list(type = "normal", mean_h1 = mean_h1)
  )
}

.gp_z_tetrachoric <- function(params, analysis) {
  rho0 <- .gp_check_correlation(.gp_numeric(params, "rho0", 0), "rho0")
  rho <- .gp_check_correlation(.gp_numeric(params, "rho", 0.3), "rho")
  n <- .gp_count(params, "n", .gp_arg(params, "total_n", 100), min = 5)
  alpha <- .gp_alpha(params)
  tails <- .gp_tail(params)
  mean_h1 <- (.gp_fisher_z(rho) - .gp_fisher_z(rho0)) * sqrt(n - 3)
  pwr <- .gp_power_z(mean_h1, alpha, tails)

  .gp_result(
    "z test: Tetrachoric correlation", analysis,
    list(tails = pwr$direction, rho_h0 = rho0, rho_h1 = rho, alpha = alpha, total_sample_size = n),
    list(critical_z = pwr$critical, power = pwr$power),
    notes = "Tetrachoric correlation currently uses the large-sample Fisher-Z style planning approximation.",
    distribution = list(type = "normal", mean_h1 = mean_h1)
  )
}

.gp_wilcoxon_signed <- function(params, analysis) {
  are <- .gp_numeric(params, "are", 3 / pi, min = 0, strict_min = TRUE)
  trial <- params
  trial$n <- max(2, floor(.gp_count(params, "n", 40, min = 2) * are))
  out <- .gp_t_one_sample(trial, analysis)
  out$test <- "Wilcoxon signed-rank test: Means - difference from constant or matched pairs"
  out$inputs$asymptotic_relative_efficiency <- are
  out$notes <- c(out$notes, "Wilcoxon signed-rank support uses the A.R.E. method and reuses the matched/one-sample t-test kernel.")
  out
}

.gp_wilcoxon_mann_whitney <- function(params, analysis) {
  are <- .gp_numeric(params, "are", 3 / pi, min = 0, strict_min = TRUE)
  trial <- params
  trial$n1 <- max(2, floor(.gp_count(params, "n1", 30, min = 2) * are))
  trial$n2 <- max(2, floor(.gp_count(params, "n2", trial$n1, min = 2) * are))
  out <- .gp_t_two_sample(trial, analysis)
  out$test <- "Wilcoxon-Mann-Whitney test of a difference between two independent means"
  out$inputs$asymptotic_relative_efficiency <- are
  out$notes <- c(out$notes, "Wilcoxon-Mann-Whitney support uses the A.R.E. method and reuses the two-sample t-test kernel.")
  out
}

.gp_output_power <- function(result) {
  result$outputs$power %||% result$outputs$actual_power
}

.gp_min_total_n <- function(test, params) {
  switch(
    test,
    t_point_biserial = 4,
    t_linear_regression = 3,
    t_linear_regression_two_groups = 6,
    t_two_sample = 4,
    f_anova_one_way = max(4, .gp_count(params, "groups", 3, min = 2) + 2),
    f_anova_special = max(4, .gp_count(params, "groups", 4, min = 2) + 2),
    f_mreg_omnibus = .gp_count(params, "predictors", 1, min = 1) + 3,
    f_mreg_increase = .gp_count(params, "predictors", 2, min = 1) + 3,
    exact_correlation = 5,
    exact_mreg_random = .gp_count(params, "predictors", 1, min = 1) + 3,
    z_corr_independent = 8,
    z_corr_dependent_common = 5,
    z_corr_dependent_no_common = 5,
    z_logistic = 5,
    z_poisson = 5,
    z_tetrachoric = 5,
    exact_fisher = 4,
    wilcoxon_mann_whitney = 4,
    roc_auc_one = 4,
    roc_auc_two = 4,
    diagnostic_acc = 4,
    survival_logrank = 8,
    cox_regression = 10,
    discovery_fdr = 4,
    ttest_biomarker = 4,
    rct_superiority_continuous = 4,
    rct_superiority_binary = 4,
    rct_noninferiority_continuous = 4,
    rct_noninferiority_binary = 4,
    rct_equivalence_continuous = 4,
    rct_equivalence_proportion = 4,
    simon_two_stage = 4,
    cluster_rct = 4,
    multi_arm_superiority = max(4, .gp_count(params, "groups", 3, min = 2) + 2),
    count_endpoint_poisson = 5,
    survival_pmu = 8,
    2
  )
}

.gp_set_total_n <- function(test, params, n_total) {
  params$total_n <- ceiling(n_total)

  if (test %in% c("t_two_sample", "t_linear_regression_two_groups", "f_variance_two", "exact_fisher", "z_corr_independent", "wilcoxon_mann_whitney", "roc_auc_two", "ttest_biomarker", "rct_superiority_continuous", "rct_superiority_binary", "rct_noninferiority_continuous", "rct_noninferiority_binary", "rct_equivalence_continuous", "rct_equivalence_proportion")) {
    ratio <- .gp_numeric(params, "allocation_ratio", .gp_arg(params, "ratio", 1), min = 0, strict_min = TRUE)
    per_group_min <- if (test == "t_linear_regression_two_groups") 3 else 2
    n1 <- max(per_group_min, floor(n_total / (1 + ratio)))
    n2 <- max(per_group_min, ceiling(n1 * ratio))
    while (n1 + n2 < n_total) {
      n2 <- n2 + 1
    }
    params$n1 <- n1
    params$n2 <- n2
  } else if (test == "roc_auc_one") {
    half <- max(2, floor(n_total / 2))
    params$n_pos <- half
    params$n_neg <- max(2, n_total - half)
  } else if (test == "diagnostic_acc") {
    half <- max(2, floor(n_total / 2))
    params$n_pos <- half
    params$n_neg <- max(2, n_total - half)
  } else if (test == "cluster_rct") {
    params$n_clusters <- max(2, floor(n_total / (2 * .gp_count(params, "cluster_size", 10, min = 2))))
  } else if (test == "cox_regression") {
    params$events <- ceiling(n_total)
  } else if (!test %in% c("f_anova_one_way", "f_anova_special", "f_mreg_omnibus", "f_mreg_increase", "chisq_gof", "chisq_contingency", "z_logistic", "z_poisson", "exact_mreg_random", "multi_arm_superiority", "count_endpoint_poisson", "survival_logrank", "survival_pmu", "discovery_fdr", "simon_two_stage")) {
    params$n <- ceiling(n_total)
  }

  params
}

.gp_default_effect <- function(effect_name) {
  switch(
    effect_name,
    d = 0.5,
    f = 0.25,
    f2 = 0.15,
    w = 0.3,
    rho = 0.3,
    q_effect = 0.3,
    slope_h1 = 0.1,
    delta_slope = 0.1,
    p1 = 0.65,
    auc = 0.75,
    auc1 = 0.75,
    hazard_ratio = 0.65,
    sensitivity = 0.85,
    effect_d = 0.5,
    rho2 = 0.1,
    variance_ratio = 1.5,
    odds_ratio = 1.5,
    exp_beta1 = 1.3,
    ncp = 1,
    0.5
  )
}

.gp_effect_sign <- function(params, effect_name) {
  value <- .gp_arg(params, effect_name, .gp_default_effect(effect_name))
  if (is.numeric(value) && length(value) == 1 && value < 0) -1 else 1
}

.gp_binomial_power <- function(n, p0, p1, alpha, alternative) {
  if (n > 5000) {
    zmean <- (p1 - p0) / sqrt(p0 * (1 - p0) / n)
    tails <- if (alternative == "two.sided") "two" else "one"
    return(.gp_power_z(zmean, alpha, tails)$power)
  }

  k <- 0:n
  p_values <- vapply(k, function(x) {
    stats::binom.test(x, n, p = p0, alternative = alternative)$p.value
  }, numeric(1))
  sum(stats::dbinom(k[p_values <= alpha], n, p1))
}

.gp_fisher_power <- function(n1, n2, p0, p1, alpha, alternative) {
  if (n1 * n2 > 40000) {
    h <- .gp_phi_to_h(p1, p0)
    zmean <- h / sqrt(1 / n1 + 1 / n2)
    tails <- if (alternative == "two.sided") "two" else "one"
    warning("Large Fisher exact grids use Cohen's h normal approximation for speed.", call. = FALSE)
    return(.gp_power_z(zmean, alpha, tails)$power)
  }

  x1 <- 0:n1
  x2 <- 0:n2
  p_x1 <- stats::dbinom(x1, n1, p0)
  p_x2 <- stats::dbinom(x2, n2, p1)
  power <- 0

  for (i in seq_along(x1)) {
    for (j in seq_along(x2)) {
      p_value <- .gp_fisher_p_value(x1[[i]], x2[[j]], n1, n2, alternative)
      if (is.finite(p_value) && p_value <= alpha) {
        power <- power + p_x1[[i]] * p_x2[[j]]
      }
    }
  }

  power
}

.gp_fisher_p_value <- function(x1, x2, n1, n2, alternative) {
  successes <- x1 + x2
  failures <- n1 + n2 - successes
  observed <- x1

  if (alternative == "greater") {
    return(stats::phyper(observed - 1, successes, failures, n1, lower.tail = FALSE))
  }
  if (alternative == "less") {
    return(stats::phyper(observed, successes, failures, n1))
  }

  lower <- max(0, n1 - failures)
  upper <- min(n1, successes)
  support <- lower:upper
  probabilities <- stats::dhyper(support, successes, failures, n1)
  observed_probability <- stats::dhyper(observed, successes, failures, n1)
  sum(probabilities[probabilities <= observed_probability * (1 + 1e-7)])
}

.gp_corr_cov_common <- function(r_ab, r_ac, r_bc) {
  psi <- r_bc * (1 - r_ab^2 - r_ac^2) -
    r_ab * r_ac * (1 - r_ab^2 - r_ac^2 - r_bc^2) / 2
  psi / ((1 - r_ab^2) * (1 - r_ac^2))
}

.gp_corr_cov_no_common <- function(r_ab, r_cd, r_ac, r_ad, r_bc, r_bd) {
  psi <- (
    (r_ac - r_ab * r_bc) * (r_bd - r_bc * r_cd) +
      (r_ad - r_ac * r_cd) * (r_bc - r_ab * r_ac) +
      (r_ac - r_ad * r_cd) * (r_bd - r_ab * r_ad) +
      (r_ad - r_ab * r_bd) * (r_bc - r_bd * r_cd)
  ) / 2
  psi / ((1 - r_ab^2) * (1 - r_cd^2))
}
