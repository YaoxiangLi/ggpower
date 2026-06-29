\name{effect_size_helpers}
\alias{effect_size_d}
\alias{effect_size_f}
\alias{effect_size_f2}
\alias{effect_size_f2_increase}
\alias{effect_size_h}
\alias{effect_size_q}
\alias{effect_size_w}
\alias{eta2_from_f}
\alias{odds_ratio_from_probs}
\alias{r2_from_f2}
\title{Effect-size helper functions}
\usage{
effect_size_d(mean_h1, mean_h0 = 0, sd)
effect_size_f(eta2)
effect_size_f2(r2)
effect_size_f2_increase(r2_full, r2_reduced)
effect_size_h(p1, p2)
effect_size_q(r1, r2)
effect_size_w(p0, p1)
eta2_from_f(f)
odds_ratio_from_probs(p0, p1)
r2_from_f2(f2)
}
\arguments{
\item{mean_h1, mean_h0}{Means used to compute Cohen's d.}
\item{sd}{Common standard deviation.}
\item{eta2}{Eta-squared value.}
\item{r2, r2_full, r2_reduced}{R-squared values; \code{r2} is also the second correlation in \code{effect_size_q()}.}
\item{p0, p1, p2}{Probabilities or probability vectors.}
\item{r1}{First correlation in \code{effect_size_q()}.}
\item{f, f2}{Cohen effect-size values.}
}
\value{
A numeric effect-size or converted variance-explained value.
}
\description{
Helpers used by the GUI effect-size drawer and by scripting workflows.
}
