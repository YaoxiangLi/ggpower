\name{power_compute}
\alias{power_compute}
\title{Compute statistical power analyses}
\usage{
power_compute(test, analysis = "post_hoc", ...)
}
\arguments{
\item{test}{Character test id. Use \code{ggpower_tests()} to list available ids.}
\item{analysis}{One of \code{"a_priori"}, \code{"compromise"}, \code{"criterion"}, \code{"post_hoc"}, or \code{"sensitivity"}.}
\item{...}{Test-specific input parameters.}
}
\value{
A \code{ggpower_result} object.
}
\description{
Runs a power analysis using the shared ggpower compute engine. The function
supports classical test families and analysis modes.
}
\examples{
power_compute("t_one_sample", "a_priori", d = 0.625, alpha = 0.05,
  power = 0.95, tails = "one")
}
