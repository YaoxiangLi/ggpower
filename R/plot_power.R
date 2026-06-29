#' Plot a power curve
#'
#' @param test Character test id.
#' @param n_values Numeric vector of total sample sizes to evaluate.
#' @param analysis Power analysis mode used for fixed parameters.
#' @param ... Test-specific fixed parameters.
#'
#' @return A ggplot object.
#' @export
plot_power_curve <- function(test, n_values, analysis = "post_hoc", ...) {
  params <- list(...)
  dat <- do.call(rbind, lapply(n_values, function(n_total) {
    trial <- .gp_set_total_n(test, params, n_total)
    result <- do.call(power_compute, c(list(test = test, analysis = "post_hoc"), trial))
    data.frame(total_n = .gp_current_total_n_plot(test, trial), power = .gp_output_power(result))
  }))

  ggplot2::ggplot(dat, ggplot2::aes(x = total_n, y = power)) +
    ggplot2::geom_line(color = "#2468a2", linewidth = 1.1) +
    ggplot2::geom_point(color = "#8f2d1c", size = 2) +
    ggplot2::scale_y_continuous(limits = c(0, 1)) +
    ggplot2::labs(
      title = "Power curve",
      subtitle = ggpower_get_test(test)$label,
      x = "Total sample size",
      y = "Power (1 - beta)"
    ) +
    theme_ggpower()
}

#' Plot H0 and H1 distributions for a result
#'
#' @param result A `ggpower_result` object.
#'
#' @return A ggplot object.
#' @export
plot_distribution <- function(result) {
  .gp_distribution_plot_core(result) +
    theme_ggpower()
}

#' Save a ggpower plot
#'
#' @param plot A ggplot object.
#' @param filename Output filename.
#' @param width,height Plot dimensions.
#' @param dpi Resolution for raster outputs.
#'
#' @return The filename invisibly.
#' @export
save_power_plot <- function(plot, filename, width = 7, height = 5, dpi = 320) {
  ggplot2::ggsave(filename, plot = plot, width = width, height = height, dpi = dpi)
  invisible(filename)
}

#' @rdname save_power_plot
#' @export
save_distribution_plot <- save_power_plot

.gp_current_total_n_plot <- function(test, params) {
  if (test %in% c("t_two_sample", "t_linear_regression_two_groups", "f_variance_two", "exact_fisher", "z_corr_independent", "wilcoxon_mann_whitney")) {
    return((params$n1 %||% params$n_per_group %||% 30) + (params$n2 %||% params$n_per_group %||% 30))
  }
  params$total_n %||% params$n %||% 80
}

.gp_distribution_plot_core <- function(result) {
  dist <- result$distribution
  if (is.null(dist$type)) {
    return(ggplot2::ggplot() + ggplot2::theme_void())
  }

  if (dist$type == "t") {
    upper <- stats::qt(0.999, dist$df, ncp = dist$ncp)
    lower <- stats::qt(0.001, dist$df, ncp = min(0, dist$ncp))
    x <- seq(lower, upper, length.out = 500)
    dat <- rbind(
      data.frame(x = x, density = stats::dt(x, dist$df), distribution = "H0"),
      data.frame(x = x, density = stats::dt(x, dist$df, ncp = dist$ncp), distribution = "H1")
    )
  } else if (dist$type == "F") {
    x <- seq(0, stats::qf(0.995, dist$df1, dist$df2, ncp = dist$ncp %||% 0), length.out = 500)
    dat <- rbind(
      data.frame(x = x, density = stats::df(x, dist$df1, dist$df2), distribution = "H0"),
      data.frame(x = x, density = stats::df(x, dist$df1, dist$df2, ncp = dist$ncp %||% 0), distribution = "H1")
    )
  } else if (dist$type == "chi-square") {
    x <- seq(0, stats::qchisq(0.995, dist$df, ncp = dist$ncp %||% 0), length.out = 500)
    dat <- rbind(
      data.frame(x = x, density = stats::dchisq(x, dist$df), distribution = "H0"),
      data.frame(x = x, density = stats::dchisq(x, dist$df, ncp = dist$ncp %||% 0), distribution = "H1")
    )
  } else {
    mean_h1 <- dist$mean_h1 %||% 0
    sd_h1 <- dist$sd_h1 %||% 1
    x <- seq(min(-4, mean_h1 - 4 * sd_h1), max(4, mean_h1 + 4 * sd_h1), length.out = 500)
    dat <- rbind(
      data.frame(x = x, density = stats::dnorm(x), distribution = "H0"),
      data.frame(x = x, density = stats::dnorm(x, mean = mean_h1, sd = sd_h1), distribution = "H1")
    )
  }

  ggplot2::ggplot(dat, ggplot2::aes(x = x, y = density, color = distribution, fill = distribution)) +
    ggplot2::geom_area(alpha = 0.08, position = "identity") +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::labs(
      title = "Central and noncentral distributions",
      subtitle = result$test,
      x = "Test statistic",
      y = "Density"
    )
}
