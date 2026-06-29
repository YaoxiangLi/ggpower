\name{ggpower_calculator}
\alias{ggpower_calculator}
\title{Evaluate a ggpower calculator script}
\usage{
ggpower_calculator(script)
}
\arguments{
\item{script}{Character calculator script with arithmetic, assignments, comments,
and supported distribution helper functions.}
}
\value{
The value of the final expression.
}
\description{
Evaluates distribution-function calculator expressions, including helpers such as
\code{zcdf()}, \code{tinv()}, \code{ncfcdf()}, and \code{binocdf()}.
}
\examples{
ggpower_calculator("x <- 2^3\nx + zinv(.975)")
}
