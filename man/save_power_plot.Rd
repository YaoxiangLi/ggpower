\name{save_power_plot}
\alias{save_power_plot}
\alias{save_distribution_plot}
\title{Save a ggpower plot}
\usage{
save_power_plot(plot, filename, width = 7, height = 5, dpi = 320)

save_distribution_plot(plot, filename, width = 7, height = 5, dpi = 320)
}
\arguments{
\item{plot}{A ggplot object.}
\item{filename}{Output filename.}
\item{width,height}{Plot dimensions.}
\item{dpi}{Resolution for raster outputs.}
}
\value{
The filename invisibly.
}
\description{
Exports publication-ready ggpower plots through \code{ggplot2::ggsave()}.
}
