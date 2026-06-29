#' Plot Power Curve for a Two-Sample t-Test
#'
#' This function creates a ggplot2 power curve for a two-sample t test.
#'
#' @param d Numeric. The effect size (Cohen's d).
#' @param alpha Numeric. The significance level (default 0.05).
#' @param n_range Numeric vector. A vector of sample sizes per group (default is seq(10, 100, by = 5)).
#' @param tails Character. `"two"` or `"one"`.
#'
#' @return A ggplot object showing the power curve.
#' @export
#'
#' @examples
#' # Create a power curve for d = 0.5 over a range of sample sizes per group
#' ggpower_ttest(d = 0.5, alpha = 0.05, n_range = seq(10, 100, by = 5))
ggpower_ttest <- function(d, alpha = 0.05, n_range = seq(10, 100, by = 5), tails = "two") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' must be installed for plotting.")
  }

  # Compute power for each sample size using the core power function
  power_vals <- sapply(n_range, function(n) {
    power_t_two_sample(d = d, n_per_group = n, alpha = alpha, tails = tails)
  })

  # Create a data frame for plotting
  df_plot <- data.frame(
    n_per_group = n_range,
    power = power_vals
  )

  # Build the ggplot power curve
  p <- ggplot2::ggplot(df_plot, ggplot2::aes(x = n_per_group, y = power)) +
    ggplot2::geom_line(color = "steelblue", linewidth = 1.2) +  # Use 'linewidth' instead of 'size'
    ggplot2::geom_point(color = "darkred", size = 2) +
    ggplot2::labs(
      title = paste("Power Curve for Two-Sample t-Test (d =", d, ")"),
      x = "Sample Size per Group",
      y = "Power (1 - Beta)"
    ) +
    ggplot2::theme_minimal()

  return(p)
}
