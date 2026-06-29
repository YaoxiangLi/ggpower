#' Plot Power Curve for a One-Sample t-Test
#'
#' This function creates a ggplot2 power curve for a one-sample t test.
#'
#' @param d Numeric. The effect size (d).
#' @param alpha Numeric. The significance level (default 0.05).
#' @param n_range Numeric vector. A vector of total sample sizes (default is seq(20, 100, by = 5)).
#' @param tails Character. `"two"` or `"one"`.
#'
#' @return A ggplot object showing the power curve.
#' @export
#'
#' @examples
#' # Plot power curve for d = 0.5 over sample sizes from 20 to 100
#' ggpower_t_one_sample(d = 0.5, alpha = 0.05, n_range = seq(20, 100, by = 5))
ggpower_t_one_sample <- function(d, alpha = 0.05, n_range = seq(20, 100, by = 5), tails = "two") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' must be installed for plotting.")
  }

  power_vals <- sapply(n_range, function(n) {
    power_t_one_sample(d = d, n = n, alpha = alpha, tails = tails)
  })

  df_plot <- data.frame(
    n = n_range,
    power = power_vals
  )

  p <- ggplot2::ggplot(df_plot, ggplot2::aes(x = n, y = power)) +
    ggplot2::geom_line(color = "steelblue", linewidth = 1.2) +
    ggplot2::geom_point(color = "darkred", size = 2) +
    ggplot2::labs(
      title = paste("Power Curve for One-Sample t-Test (d =", d, ")"),
      x = "Total Sample Size",
      y = "Power (1 - Beta)"
    ) +
    ggplot2::theme_minimal()

  return(p)
}

