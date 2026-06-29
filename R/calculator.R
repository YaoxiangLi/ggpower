#' Evaluate a ggpower calculator script
#'
#' Evaluates distribution-function calculator expressions, including helpers
#' such as `zcdf()`, `tinv()`, and `ncfcdf()`.
#'
#' @param script Character calculator script. Lines may contain R-style
#'   arithmetic, assignments, comments starting with `#`, and distribution
#'   helper functions such as `zcdf()`, `tinv()`, and `ncfcdf()`.
#'
#' @return The value of the final expression.
#' @export
ggpower_calculator <- function(script) {
  env <- .gp_calculator_env()
  expr <- parse(text = script)
  value <- NULL
  for (i in seq_along(expr)) {
    value <- eval(expr[[i]], envir = env)
  }
  value
}

.gp_calculator_env <- function() {
  env <- new.env(parent = baseenv())
  env$abs <- base::abs
  env$sin <- base::sin
  env$asin <- base::asin
  env$cos <- base::cos
  env$acos <- base::acos
  env$tan <- base::tan
  env$atan <- base::atan
  env$atan2 <- base::atan2
  env$exp <- base::exp
  env$log <- base::log
  env$sqrt <- base::sqrt
  env$sqr <- function(x) x^2
  env$sign <- base::sign
  env$lngamma <- base::lgamma
  env$frac <- function(x) x - floor(x)
  env$int <- base::trunc
  env$min <- base::min
  env$max <- base::max
  env$uround <- function(x, m = 1) ceiling(x / m) * m

  env$zcdf <- stats::pnorm
  env$zpdf <- stats::dnorm
  env$zinv <- stats::qnorm
  env$normcdf <- function(x, m = 0, s = 1) stats::pnorm(x, m, s)
  env$normpdf <- function(x, m = 0, s = 1) stats::dnorm(x, m, s)
  env$norminv <- function(p, m = 0, s = 1) stats::qnorm(p, m, s)
  env$chi2cdf <- stats::pchisq
  env$chi2pdf <- stats::dchisq
  env$chi2inv <- stats::qchisq
  env$fcdf <- stats::pf
  env$fpdf <- stats::df
  env$finv <- stats::qf
  env$tcdf <- stats::pt
  env$tpdf <- stats::dt
  env$tinv <- stats::qt
  env$ncx2cdf <- function(x, df, nc) stats::pchisq(x, df, ncp = nc)
  env$ncx2pdf <- function(x, df, nc) stats::dchisq(x, df, ncp = nc)
  env$ncx2inv <- function(p, df, nc) stats::qchisq(p, df, ncp = nc)
  env$ncfcdf <- function(x, df1, df2, nc) stats::pf(x, df1, df2, ncp = nc)
  env$ncfpdf <- function(x, df1, df2, nc) stats::df(x, df1, df2, ncp = nc)
  env$ncfinv <- function(p, df1, df2, nc) stats::qf(p, df1, df2, ncp = nc)
  env$nctcdf <- function(x, df, nc) stats::pt(x, df, ncp = nc)
  env$nctpdf <- function(x, df, nc) stats::dt(x, df, ncp = nc)
  env$nctinv <- function(p, df, nc) stats::qt(p, df, ncp = nc)
  env$binocdf <- stats::pbinom
  env$binopdf <- stats::dbinom
  env$binoinv <- stats::qbinom
  env$poisscdf <- stats::ppois
  env$poisspdf <- stats::dpois
  env$poissinv <- stats::qpois
  env$betacdf <- stats::pbeta
  env$betapdf <- stats::dbeta
  env$betainv <- stats::qbeta
  env
}
