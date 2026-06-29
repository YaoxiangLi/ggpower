\name{plot_power_curve}
\alias{plot_power_curve}
\title{Plot a power curve}
\usage{
plot_power_curve(test, n_values, analysis = "post_hoc", ...)
}
\arguments{
\item{test}{Character test id.}
\item{n_values}{Numeric vector of total sample sizes.}
\item{analysis}{Power analysis mode used for fixed parameters.}
\item{...}{Test-specific fixed parameters.}
}
\value{
A ggplot object.
}
\description{
Builds a publication-ready power curve for a selected ggpower test.
}
\examples{
plot_power_curve("t_one_sample", n_values = c(20, 30, 40), d = 0.5)
}
