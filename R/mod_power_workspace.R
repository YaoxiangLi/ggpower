mod_power_workspace_ui <- function(id) {
  n_tests <- nrow(ggpower_tests(module = "workspace"))
  mod_power_core_ui(
    id,
    list(
      module_filter = "workspace",
      title = "Power analysis workspace",
      subtitle = "Choose a test family, set inputs, and calculate sample size, power, alpha, or effect size.",
      badges = list(
        list(label = paste0(n_tests, " statistical tests")),
        list(label = "5 analysis modes"),
        list(label = "Publication plots", class = "gp-badge gp-badge-accent")
      )
    )
  )
}

mod_power_workspace_server <- function(id, protocol = NULL) {
  mod_power_core_server(
    id,
    list(module_filter = "workspace"),
    protocol = protocol
  )
}

.gp_analysis_choice_map <- function() {
  c(
    "A priori: Compute required sample size" = "a_priori",
    "Compromise: Compute alpha and beta" = "compromise",
    "Criterion: Compute alpha" = "criterion",
    "Post hoc: Compute achieved power" = "post_hoc",
    "Sensitivity: Compute effect size" = "sensitivity"
  )
}

.gp_analysis_choices_for_modes <- function(modes) {
  all <- .gp_analysis_choice_map()
  all[all %in% modes]
}

.gp_fields_for_mode <- function(spec, mode) {
  fields <- spec$fields
  remove <- switch(
    mode,
    a_priori = spec$sample,
    post_hoc = "power",
    criterion = "alpha",
    sensitivity = spec$effect,
    compromise = c("alpha", "power"),
    character()
  )
  unique(fields[!fields %in% remove])
}

.gp_input_control <- function(ns, field) {
  labels <- .gp_field_labels()
  defaults <- .gp_field_defaults()

  if (field == "tails") {
    return(shiny::div(
      class = "gp-field gp-field-compact",
      shiny::selectInput(
        ns(field),
        labels[[field]],
        choices = c("One" = "one", "Two" = "two"),
        selected = defaults[[field]],
        width = "100%"
      )
    ))
  }

  shiny::div(
    class = "gp-field gp-field-compact",
    shiny::numericInput(
      ns(field),
      labels[[field]] %||% field,
      value = defaults[[field]] %||% 1,
      min = .gp_field_min()[[field]] %||% NA,
      step = .gp_field_step()[[field]] %||% NA,
      width = "100%"
    )
  )
}

.gp_collect_inputs <- function(input, test) {
  spec <- ggpower_get_test(test)
  defaults <- .gp_field_defaults()
  params <- list()
  for (field in spec$fields) {
    value <- input[[field]]
    if (is.null(value)) {
      value <- defaults[[field]]
    }
    params[[field]] <- value
  }
  params
}

.gp_make_xy_data <- function(test, analysis, params) {
  current_n <- .gp_current_total_n(test, params)
  start <- max(.gp_min_total_n(test, params), floor(current_n * 0.4))
  stop <- max(start + 10, ceiling(current_n * 1.8))
  values <- unique(ceiling(seq(start, stop, length.out = 30)))

  rows <- lapply(values, function(n_total) {
    trial <- .gp_set_total_n(test, params, n_total)
    trial$power <- NULL
    trial$q <- NULL
    result <- tryCatch(
      do.call(power_compute, c(list(test = test, analysis = "post_hoc"), trial)),
      error = function(e) NULL
    )
    if (is.null(result)) {
      return(NULL)
    }
    data.frame(
      total_n = .gp_current_total_n(test, trial),
      power = .gp_output_power(result)
    )
  })

  do.call(rbind, rows)
}

.gp_current_total_n <- function(test, params) {
  two_group <- c(
    "t_two_sample", "t_linear_regression_two_groups", "f_variance_two", "exact_fisher",
    "z_corr_independent", "wilcoxon_mann_whitney", "roc_auc_two", "ttest_biomarker",
    "rct_superiority_continuous", "rct_superiority_binary", "rct_noninferiority_continuous",
    "rct_noninferiority_binary", "rct_equivalence_continuous", "rct_equivalence_proportion"
  )
  if (test %in% two_group) {
    return((params$n1 %||% params$n_per_group %||% 30) + (params$n2 %||% params$n_per_group %||% 30))
  }
  if (test %in% c("roc_auc_one", "diagnostic_acc")) {
    return((params$n_pos %||% 30) + (params$n_neg %||% 30))
  }
  if (test == "cluster_rct") {
    cs <- params$cluster_size %||% 10
    nc <- params$n_clusters %||% 20
    return(2 * nc * cs)
  }
  params$total_n %||% params$n %||% params$events %||% 80
}

.gp_empty_plot <- function(message) {
  ggplot2::ggplot() +
    ggplot2::annotate("text", x = 0, y = 0, label = message) +
    ggplot2::theme_void()
}

.gp_effect_modal <- function(test, ns) {
  spec <- ggpower_get_test(test)
  shiny::modalDialog(
    title = paste("Determine effect size for", spec$label),
    shiny::p("Use the exported effect-size helpers in scripts or copy the formula below into the relevant field."),
    shiny::tags$ul(
      shiny::tags$li("d = (mean H1 - mean H0) / SD"),
      shiny::tags$li("f = sqrt(eta2 / (1 - eta2))"),
      shiny::tags$li("f2 = R2 / (1 - R2)"),
      shiny::tags$li("w = sqrt(sum((p1 - p0)^2 / p0))"),
      shiny::tags$li("q = FisherZ(r1) - FisherZ(r2)"),
      shiny::tags$li("AUC: Hanley-McNeil variance for ROC curves"),
      shiny::tags$li("HR: log hazard ratio for survival/Cox models")
    ),
    easyClose = TRUE,
    footer = shiny::modalButton("Close")
  )
}

.gp_field_labels <- function() {
  list(
    tails = "Tail(s)",
    d = "Effect size d / dz",
    f = "Effect size f",
    f2 = "Effect size f2",
    w = "Effect size w",
    h = "Effect size h",
    rho = "Correlation rho H1",
    rho0 = "Correlation rho H0",
    rho_ab = "H0 corr rho_ab",
    rho_ac = "H1 corr rho_ac",
    rho_cd = "H1 corr rho_cd",
    rho_bc = "Corr rho_bc",
    rho_ad = "Corr rho_ad",
    rho_bd = "Corr rho_bd",
    rho2 = "Population rho2",
    q_effect = "Effect size q",
    slope_h1 = "Slope H1",
    slope_h0 = "Slope H0",
    delta_slope = "Absolute slope difference",
    sd_x = "Std dev sigma_x",
    sd_y = "Std dev sigma_y",
    sd_x1 = "Std dev sigma_x1",
    sd_x2 = "Std dev sigma_x2",
    residual_sd = "Std dev residual sigma",
    ncp = "Noncentrality parameter",
    alpha = "Alpha err prob",
    power = "Power (1 - beta err prob)",
    q = "Beta/alpha ratio",
    n = "Total sample size",
    total_n = "Total sample size",
    n1 = "Sample size group 1",
    n2 = "Sample size group 2",
    n_pos = "N diseased / positive",
    n_neg = "N non-diseased / negative",
    allocation_ratio = "Allocation ratio N2/N1",
    df = "Degrees of freedom",
    df1 = "Numerator df",
    groups = "Number of groups",
    predictors = "Number of predictors",
    tested_predictors = "Number of tested predictors",
    variance_ratio = "Ratio var1/var0",
    p0 = "Probability H0",
    p1 = "Probability H1",
    odds_ratio = "Odds ratio",
    exp_beta1 = "Exp(beta1)",
    base_rate = "Base rate exp(beta0)",
    exposure = "Mean exposure",
    r2_other = "R2 other X",
    x_variance = "X variance",
    are = "Asymptotic relative efficiency",
    auc = "AUC H1",
    auc0 = "Null AUC H0",
    auc1 = "AUC group 1",
    auc2 = "AUC group 2",
    sensitivity = "Sensitivity H1",
    specificity = "Specificity H1",
    hazard_ratio = "Hazard ratio",
    event_rate = "Overall event rate",
    events = "Expected events",
    m_tests = "Number of tests",
    pi0 = "Proportion true null",
    effect_d = "Effect size d per test",
    fdr_level = "Target FDR level",
    ni_margin = "Non-inferiority margin",
    eq_margin = "Equivalence margin",
    icc = "Intraclass correlation",
    cluster_size = "Cluster size (m)",
    n_clusters = "Clusters per arm",
    r1 = "Stage 1 threshold (r1)",
    r = "Total threshold (r)"
  )
}

.gp_field_defaults <- function() {
  list(
    tails = "two",
    d = 0.5,
    f = 0.25,
    f2 = 0.15,
    w = 0.3,
    h = 0.3,
    rho = 0.3,
    rho0 = 0,
    rho_ab = 0.4,
    rho_ac = 0.2,
    rho_cd = 0.2,
    rho_bc = 0.5,
    rho_ad = 0.4,
    rho_bd = 0.8,
    rho2 = 0.1,
    q_effect = 0.3,
    slope_h1 = -0.0667,
    slope_h0 = 0,
    delta_slope = 0.1,
    sd_x = 1,
    sd_y = 1,
    sd_x1 = 1,
    sd_x2 = 1,
    residual_sd = 1,
    ncp = 1,
    alpha = 0.05,
    power = 0.8,
    q = 1,
    n = 40,
    total_n = 100,
    n1 = 30,
    n2 = 30,
    n_pos = 50,
    n_neg = 50,
    allocation_ratio = 1,
    df = 20,
    df1 = 1,
    groups = 3,
    predictors = 1,
    tested_predictors = 1,
    variance_ratio = 1.5,
    p0 = 0.5,
    p1 = 0.65,
    odds_ratio = 1.5,
    exp_beta1 = 1.3,
    base_rate = 0.85,
    exposure = 1,
    r2_other = 0,
    x_variance = 1,
    are = 3 / pi,
    auc = 0.75,
    auc0 = 0.5,
    auc1 = 0.75,
    auc2 = 0.65,
    sensitivity = 0.85,
    specificity = 0.85,
    hazard_ratio = 0.65,
    event_rate = 0.5,
    events = 100,
    m_tests = 1000,
    pi0 = 0.9,
    effect_d = 0.5,
    fdr_level = 0.05,
    ni_margin = 0.2,
    eq_margin = 0.2,
    icc = 0.05,
    cluster_size = 10,
    n_clusters = 20,
    r1 = 4,
    r = 10
  )
}

.gp_field_min <- function() {
  list(
    alpha = 0, power = 0, q = 0, n = 1, total_n = 1, n1 = 1, n2 = 1, n_pos = 1, n_neg = 1,
    allocation_ratio = 0, df = 1, df1 = 1, groups = 2, predictors = 1, tested_predictors = 1,
    p0 = 0, p1 = 0, odds_ratio = 0, exp_beta1 = 0, base_rate = 0, exposure = 0, r2_other = 0,
    x_variance = 0, are = 0, sd_x = 0, sd_y = 0, sd_x1 = 0, sd_x2 = 0, residual_sd = 0, rho2 = 0,
    auc = 0, auc0 = 0, auc1 = 0, auc2 = 0, sensitivity = 0, specificity = 0,
    hazard_ratio = 0, event_rate = 0, events = 1, m_tests = 2, pi0 = 0, effect_d = 0,
    fdr_level = 0, ni_margin = 0, eq_margin = 0, icc = 0, cluster_size = 2, n_clusters = 2,
    r1 = 0, r = 0
  )
}

.gp_field_step <- function() {
  list(
    alpha = 0.01, power = 0.01, q = 0.1, d = 0.1, f = 0.05, f2 = 0.05, w = 0.05, rho = 0.05,
    q_effect = 0.05, n = 1, total_n = 1, n1 = 1, n2 = 1, allocation_ratio = 0.1,
    auc = 0.01, hazard_ratio = 0.05, ni_margin = 0.05, eq_margin = 0.05, icc = 0.01
  )
}
