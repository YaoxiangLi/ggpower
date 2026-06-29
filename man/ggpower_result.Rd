\name{ggpower_result}
\alias{ggpower_result}
\alias{print.ggpower_result}
\title{Create a ggpower result object}
\usage{
ggpower_result(test, analysis, inputs, outputs, notes = character(),
  distribution = list())
}
\arguments{
\item{test}{Character label for the selected test.}
\item{analysis}{Character label for the selected analysis mode.}
\item{inputs}{Named list of input parameters.}
\item{outputs}{Named list of computed output parameters.}
\item{notes}{Character vector with method notes or assumptions.}
\item{distribution}{Named list describing the H0/H1 distributions.}
}
\value{
An object of class \code{ggpower_result}.
}
\description{
Creates the common result object used by the scriptable API and Shiny GUI.
}
