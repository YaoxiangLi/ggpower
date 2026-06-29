\name{plot_distribution}
\alias{plot_distribution}
\title{Plot H0 and H1 distributions}
\usage{
plot_distribution(result)
}
\arguments{
\item{result}{A \code{ggpower_result} object.}
}
\value{
A ggplot object.
}
\description{
Builds a publication-ready distribution overlay for a computed power-analysis result.
}
\examples{
result <- power_compute("t_one_sample", "post_hoc", d = 0.5, n = 40)
plot_distribution(result)
}
