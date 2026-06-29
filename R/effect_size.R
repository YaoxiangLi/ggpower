#' Compute Cohen's d from means and standard deviation
#'
#' @param mean_h1 Mean assumed under H1.
#' @param mean_h0 Mean assumed under H0 or comparison group mean.
#' @param sd Common standard deviation.
#'
#' @return Numeric effect size d.
#' @export
effect_size_d <- function(mean_h1, mean_h0 = 0, sd) {
  sd <- .gp_numeric(list(sd = sd), "sd", min = 0, strict_min = TRUE)
  (mean_h1 - mean_h0) / sd
}

#' Compute Cohen's f from eta-squared
#'
#' @param eta2 Proportion of variance explained.
#'
#' @return Numeric effect size f.
#' @export
effect_size_f <- function(eta2) {
  eta2 <- .gp_numeric(list(eta2 = eta2), "eta2", min = 0, max = 1, strict_max = TRUE)
  sqrt(eta2 / (1 - eta2))
}

#' Convert Cohen's f to eta-squared
#'
#' @param f Cohen's f.
#'
#' @return Numeric eta-squared value.
#' @export
eta2_from_f <- function(f) {
  f <- .gp_numeric(list(f = f), "f", min = 0)
  f^2 / (1 + f^2)
}

#' Compute Cohen's f2 from R-squared
#'
#' @param r2 Coefficient of determination.
#'
#' @return Numeric effect size f2.
#' @export
effect_size_f2 <- function(r2) {
  r2 <- .gp_numeric(list(r2 = r2), "r2", min = 0, max = 1, strict_max = TRUE)
  r2 / (1 - r2)
}

#' Compute f2 for an R-squared increase
#'
#' @param r2_full R-squared for the full model.
#' @param r2_reduced R-squared for the reduced model.
#'
#' @return Numeric effect size f2.
#' @export
effect_size_f2_increase <- function(r2_full, r2_reduced) {
  r2_full <- .gp_numeric(list(r2_full = r2_full), "r2_full", min = 0, max = 1, strict_max = TRUE)
  r2_reduced <- .gp_numeric(list(r2_reduced = r2_reduced), "r2_reduced", min = 0, max = 1)
  if (r2_reduced > r2_full) {
    stop("'r2_reduced' cannot be greater than 'r2_full'.", call. = FALSE)
  }
  (r2_full - r2_reduced) / (1 - r2_full)
}

#' Convert f2 to R-squared
#'
#' @param f2 Cohen's f2.
#'
#' @return Numeric R-squared value.
#' @export
r2_from_f2 <- function(f2) {
  f2 <- .gp_numeric(list(f2 = f2), "f2", min = 0)
  f2 / (1 + f2)
}

#' Compute chi-square effect size w
#'
#' @param p0 Probabilities under H0.
#' @param p1 Probabilities under H1.
#'
#' @return Numeric effect size w.
#' @export
effect_size_w <- function(p0, p1) {
  if (length(p0) != length(p1)) {
    stop("'p0' and 'p1' must have the same length.", call. = FALSE)
  }
  if (any(p0 <= 0) || any(p1 < 0)) {
    stop("'p0' must be positive and 'p1' must be non-negative.", call. = FALSE)
  }
  p0 <- p0 / sum(p0)
  p1 <- p1 / sum(p1)
  sqrt(sum((p1 - p0)^2 / p0))
}

#' Compute Cohen's q for two correlations
#'
#' @param r1,r2 Correlations to compare.
#'
#' @return Numeric Fisher-z difference q.
#' @export
effect_size_q <- function(r1, r2) {
  r1 <- .gp_check_correlation(r1, "r1")
  r2 <- .gp_check_correlation(r2, "r2")
  .gp_fisher_z(r1) - .gp_fisher_z(r2)
}

#' Compute odds ratio from two probabilities
#'
#' @param p0 Baseline event probability.
#' @param p1 Event probability under H1.
#'
#' @return Numeric odds ratio.
#' @export
odds_ratio_from_probs <- function(p0, p1) {
  p0 <- .gp_numeric(list(p0 = p0), "p0", min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  p1 <- .gp_numeric(list(p1 = p1), "p1", min = 0, max = 1, strict_min = TRUE, strict_max = TRUE)
  (p1 / (1 - p1)) / (p0 / (1 - p0))
}

#' Compute Cohen's h for two proportions
#'
#' @param p1,p2 Proportions.
#'
#' @return Numeric h.
#' @export
effect_size_h <- function(p1, p2) {
  p1 <- .gp_numeric(list(p1 = p1), "p1", min = 0, max = 1)
  p2 <- .gp_numeric(list(p2 = p2), "p2", min = 0, max = 1)
  .gp_phi_to_h(p1, p2)
}
