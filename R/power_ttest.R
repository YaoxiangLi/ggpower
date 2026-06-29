#' Compute Power for a Two-Sample t-Test (Equal Sample Sizes)
#'
#' This function calculates the power for a two-sample t-test when the two groups have equal sample sizes.
#'
#' @param d Numeric. The effect size (Cohen's d).
#' @param n_per_group Integer. The sample size per group.
#' @param alpha Numeric. The significance level (default is 0.05).
#' @param tails Character. `"two"` for a two-tailed test or `"one"` for a one-tailed test.
#' @param n2 Optional second-group sample size. If omitted, equal group sizes are used.
#'
#' @return Numeric. The computed power (1 - beta).
#' @export
#'
#' @examples
#' # Compute power for an effect size d = 0.5 with 30 subjects per group
#' power_t_two_sample(d = 0.5, n_per_group = 30)
power_t_two_sample <- function(d, n_per_group, alpha = 0.05, tails = "two", n2 = NULL) {
  result <- power_compute(
    "t_two_sample",
    analysis = "post_hoc",
    d = d,
    n1 = n_per_group,
    n2 = n2 %||% n_per_group,
    alpha = alpha,
    tails = tails
  )
  result$outputs$power
}

#' Compute Power for a Paired-Samples t-Test
#'
#' @param d Numeric. The paired-samples effect size dz.
#' @param n Integer. Number of pairs.
#' @param alpha Numeric. The significance level.
#' @param tails Character. `"two"` or `"one"`.
#'
#' @return Numeric. The computed power.
#' @export
power_t_paired <- function(d, n, alpha = 0.05, tails = "two") {
  result <- power_compute(
    "t_paired",
    analysis = "post_hoc",
    d = d,
    n = n,
    alpha = alpha,
    tails = tails
  )
  result$outputs$power
}
