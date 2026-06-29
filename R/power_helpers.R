`%||%` <- function(x, y) {
  if (is.null(x) || length(x) == 0 || (length(x) == 1 && is.na(x))) y else x
}

.gp_arg <- function(params, name, default = NULL) {
  params[[name]] %||% default
}

.gp_numeric <- function(params, name, default = NULL, min = -Inf, max = Inf,
                        strict_min = FALSE, strict_max = FALSE) {
  value <- .gp_arg(params, name, default)
  if (is.null(value) || !is.numeric(value) || length(value) != 1 || is.na(value)) {
    stop("'", name, "' must be a single numeric value.", call. = FALSE)
  }
  if ((strict_min && value <= min) || (!strict_min && value < min)) {
    stop("'", name, "' is below the allowed range.", call. = FALSE)
  }
  if ((strict_max && value >= max) || (!strict_max && value > max)) {
    stop("'", name, "' is above the allowed range.", call. = FALSE)
  }
  value
}

.gp_count <- function(params, name, default = NULL, min = 1) {
  value <- ceiling(.gp_numeric(params, name, default, min = min))
  as.integer(value)
}

.gp_alpha <- function(params) {
  .gp_numeric(params, "alpha", 0.05, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
}

.gp_power_target <- function(params) {
  .gp_numeric(params, "power", 0.8, min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
}

.gp_tail <- function(params) {
  tails <- .gp_arg(params, "tails", "two")
  tails <- tolower(as.character(tails))
  if (tails %in% c("two", "two.sided", "two-sided", "2")) {
    return("two")
  }
  if (tails %in% c("one", "one.sided", "one-sided", "1", "greater", "less")) {
    return("one")
  }
  stop("'tails' must be 'one' or 'two'.", call. = FALSE)
}

.gp_tail_direction <- function(effect, tails) {
  if (tails == "two") {
    return("two")
  }
  if (effect < 0) "less" else "greater"
}

.gp_power_t <- function(df, ncp, alpha, tails = "two") {
  if (tails == "two") {
    critical <- stats::qt(1 - alpha / 2, df)
    power <- stats::pt(-critical, df, ncp = ncp) +
      1 - stats::pt(critical, df, ncp = ncp)
    return(list(
      power = power,
      critical = c(lower = -critical, upper = critical),
      direction = "two"
    ))
  }

  if (ncp < 0) {
    critical <- stats::qt(alpha, df)
    power <- stats::pt(critical, df, ncp = ncp)
    direction <- "less"
  } else {
    critical <- stats::qt(1 - alpha, df)
    power <- 1 - stats::pt(critical, df, ncp = ncp)
    direction <- "greater"
  }

  list(power = power, critical = critical, direction = direction)
}

.gp_power_z <- function(mean_h1, alpha, tails = "two", sd_h1 = 1) {
  if (tails == "two") {
    critical <- stats::qnorm(1 - alpha / 2)
    power <- stats::pnorm(-critical, mean = mean_h1, sd = sd_h1) +
      1 - stats::pnorm(critical, mean = mean_h1, sd = sd_h1)
    return(list(
      power = power,
      critical = c(lower = -critical, upper = critical),
      direction = "two"
    ))
  }

  if (mean_h1 < 0) {
    critical <- stats::qnorm(alpha)
    power <- stats::pnorm(critical, mean = mean_h1, sd = sd_h1)
    direction <- "less"
  } else {
    critical <- stats::qnorm(1 - alpha)
    power <- 1 - stats::pnorm(critical, mean = mean_h1, sd = sd_h1)
    direction <- "greater"
  }

  list(power = power, critical = critical, direction = direction)
}

.gp_power_f <- function(df1, df2, ncp, alpha) {
  critical <- stats::qf(1 - alpha, df1 = df1, df2 = df2)
  power <- 1 - stats::pf(critical, df1 = df1, df2 = df2, ncp = ncp)
  list(power = power, critical = critical)
}

.gp_power_chisq <- function(df, ncp, alpha) {
  critical <- stats::qchisq(1 - alpha, df = df)
  power <- 1 - stats::pchisq(critical, df = df, ncp = ncp)
  list(power = power, critical = critical)
}

.gp_solve_root <- function(fn, lower, upper, name = "parameter") {
  f_lower <- fn(lower)
  f_upper <- fn(upper)

  if (!is.finite(f_lower) || !is.finite(f_upper) || f_lower * f_upper > 0) {
    stop("Could not bracket a solution for ", name, ".", call. = FALSE)
  }

  stats::uniroot(fn, lower = lower, upper = upper, tol = 1e-8)$root
}

.gp_phi_to_h <- function(p1, p2) {
  2 * asin(sqrt(p1)) - 2 * asin(sqrt(p2))
}

.gp_fisher_z <- function(r) {
  0.5 * log((1 + r) / (1 - r))
}

.gp_check_correlation <- function(r, name = "correlation") {
  if (!is.numeric(r) || length(r) != 1 || is.na(r) || r <= -1 || r >= 1) {
    stop("'", name, "' must be between -1 and 1.", call. = FALSE)
  }
  r
}

.gp_positive_semidefinite <- function(mat, tolerance = 1e-8) {
  if (!is.matrix(mat) || nrow(mat) != ncol(mat)) {
    return(FALSE)
  }
  if (!isTRUE(all.equal(mat, t(mat), tolerance = tolerance))) {
    return(FALSE)
  }
  min(eigen(mat, symmetric = TRUE, only.values = TRUE)$values) >= -tolerance
}

.gp_var_x <- function(params) {
  .gp_numeric(params, "x_variance", 1, min = 0, strict_min = TRUE)
}

.gp_notes_method <- function(...) {
  paste(..., collapse = "")
}
