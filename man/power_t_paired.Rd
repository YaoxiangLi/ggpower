\name{power_t_paired}
\alias{power_t_paired}
\title{Compute power for a paired-samples t-test}
\usage{
power_t_paired(d, n, alpha = 0.05, tails = "two")
}
\arguments{
\item{d}{Numeric paired-samples effect size dz.}
\item{n}{Integer number of pairs.}
\item{alpha}{Numeric significance level.}
\item{tails}{Character, \code{"two"} or \code{"one"}.}
}
\value{
Numeric power.
}
\description{
Computes achieved power for a paired-samples t-test using the noncentral t kernel.
}
\examples{
power_t_paired(d = 0.5, n = 40)
}
