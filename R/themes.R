#' Publication-ready ggpower theme
#'
#' @param base_size Base font size.
#' @param base_family Base font family.
#'
#' @return A ggplot2 theme.
#' @export
theme_ggpower <- function(base_size = 12, base_family = "") {
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", margin = ggplot2::margin(b = 8)),
      plot.subtitle = ggplot2::element_text(color = "#555555", margin = ggplot2::margin(b = 8)),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(color = "#e5e5e5", linewidth = 0.35),
      axis.title = ggplot2::element_text(face = "bold"),
      legend.position = "bottom",
      legend.title = ggplot2::element_blank()
    )
}
