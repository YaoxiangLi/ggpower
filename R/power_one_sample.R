#' Compute Power for a One-Sample t-Test
#'
#' Calculates the power for a one-sample t-test given the effect size (d),
#' total sample size (n), and significance level (alpha).
#'
#' @param d Numeric. The effect size (difference from the constant divided by sigma).
#' @param n Integer. Total sample size.
#' @param alpha Numeric. The significance level (default is 0.05).
#' @param tails Character. `"two"` for a two-tailed test or `"one"` for a one-tailed test.
#'
#' @return Numeric. The computed power (1 - beta).
#' @export
#'
#' @examples
#' # Calculate power for an effect size of 0.5 with n = 40 subjects
#' power_t_one_sample(d = 0.5, n = 40, alpha = 0.05)
power_t_one_sample <- function(d, n, alpha = 0.05, tails = "two") {
  result <- power_compute(
    "t_one_sample",
    analysis = "post_hoc",
    d = d,
    n = n,
    alpha = alpha,
    tails = tails
  )
  result$outputs$power
}


