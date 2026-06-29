test_that("Fisher exact power uses exact enumeration for feasible grids", {
  result <- power_compute(
    "exact_fisher",
    "post_hoc",
    p0 = 0.4,
    p1 = 0.7,
    n1 = 12,
    n2 = 12,
    alpha = 0.05,
    tails = "greater"
  )

  expect_true(result$outputs$power > 0)
  expect_true(result$outputs$power < 1)
  expect_match(result$notes, "enumerates")
})

test_that("Fisher exact one-sided direction follows the alternative group", {
  result <- power_compute(
    "exact_fisher",
    "post_hoc",
    p0 = 0.4,
    p1 = 0.7,
    n1 = 12,
    n2 = 12,
    alpha = 0.05,
    tails = "one"
  )

  expect_true(result$outputs$power > 0.1)
  expect_equal(result$inputs$tails, "less")
})

test_that("linear regression one-group slope reproduces manual formula", {
  result <- power_compute(
    "t_linear_regression",
    "post_hoc",
    slope_h1 = -0.0667,
    slope_h0 = 0,
    sd_x = 7.5,
    sd_y = 4,
    n = 100,
    alpha = 0.05,
    tails = "two"
  )

  expect_equal(abs(result$outputs$noncentrality_parameter), 1.250625, tolerance = 1e-5)
  expect_equal(result$outputs$df, 98)
})

test_that("two-group slope test uses N minus four degrees of freedom", {
  result <- power_compute(
    "t_linear_regression_two_groups",
    "post_hoc",
    delta_slope = 0.01592,
    residual_sd = 0.5578413,
    sd_x1 = 9.02914,
    sd_x2 = 11.86779,
    n1 = 163,
    n2 = 256,
    alpha = 0.05,
    tails = "two"
  )

  expect_equal(result$outputs$df, 415)
  expect_true(result$outputs$power > 0.79)
})

test_that("dependent correlation common-index validates correlation matrix", {
  expect_error(
    power_compute(
      "z_corr_dependent_common",
      "post_hoc",
      rho_ab = 0.4,
      rho_ac = -0.4,
      rho_bc = 0.99,
      n = 100
    ),
    "valid correlation matrix"
  )
})

test_that("dependent correlation kernels return valid power", {
  common <- power_compute(
    "z_corr_dependent_common",
    "post_hoc",
    rho_ab = 0.4,
    rho_ac = 0.2,
    rho_bc = 0.5,
    n = 144,
    alpha = 0.05,
    tails = "one"
  )
  no_common <- power_compute(
    "z_corr_dependent_no_common",
    "post_hoc",
    rho_ab = 0.1,
    rho_cd = 0.2,
    rho_ac = 0.5,
    rho_ad = 0.4,
    rho_bc = -0.4,
    rho_bd = 0.8,
    n = 200,
    alpha = 0.05,
    tails = "one"
  )

  expect_true(common$outputs$power > 0 && common$outputs$power < 1)
  expect_true(no_common$outputs$power > 0 && no_common$outputs$power < 1)
})

test_that("calculator exposes distribution helpers", {
  expect_equal(ggpower_calculator("2^3"), 8)
  expect_equal(ggpower_calculator("zinv(.975)"), stats::qnorm(.975))
  expect_equal(ggpower_calculator("ncfcdf(3, 2, 20, 4)"), stats::pf(3, 2, 20, ncp = 4))
})

test_that("publication plotting functions return ggplot objects", {
  result <- power_compute("t_one_sample", "post_hoc", d = 0.5, n = 40)
  expect_s3_class(plot_distribution(result), "ggplot")
  expect_s3_class(plot_power_curve("t_one_sample", n_values = c(20, 30, 40), d = 0.5), "ggplot")
})
