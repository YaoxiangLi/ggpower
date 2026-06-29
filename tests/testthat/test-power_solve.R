test_that("a priori solver rounds up to actual power at or above target", {
  result <- power_compute(
    "t_two_sample",
    "a_priori",
    d = 0.5,
    alpha = 0.05,
    power = 0.8,
    tails = "two",
    allocation_ratio = 1
  )

  expect_true(result$outputs$actual_power >= 0.8)
  expect_true(result$outputs$total_sample_size >= 2)
})

test_that("a priori solver starts inside each kernel's valid sample-size range", {
  point_biserial <- power_compute("t_point_biserial", "a_priori")
  slope_groups <- power_compute("t_linear_regression_two_groups", "a_priori")

  expect_true(point_biserial$inputs$total_sample_size >= 4)
  expect_true(slope_groups$inputs$sample_size_group_1 >= 3)
  expect_true(slope_groups$inputs$sample_size_group_2 >= 3)
  expect_true(point_biserial$outputs$actual_power >= point_biserial$inputs$target_power)
  expect_true(slope_groups$outputs$actual_power >= slope_groups$inputs$target_power)
})

test_that("criterion solver computes alpha for requested power", {
  result <- power_compute(
    "t_one_sample",
    "criterion",
    d = 0.5,
    n = 40,
    power = 0.8,
    tails = "two"
  )

  expect_true(result$outputs$alpha > 0)
  expect_true(result$outputs$alpha < 1)
  expect_equal(result$outputs$power, 0.8, tolerance = 1e-5)
})

test_that("sensitivity solver computes an effect size", {
  result <- power_compute(
    "f_mreg_omnibus",
    "sensitivity",
    alpha = 0.05,
    power = 0.8,
    total_n = 100,
    predictors = 3
  )

  expect_true(result$outputs$f2 > 0)
  expect_equal(result$outputs$power, 0.8, tolerance = 1e-5)
})

test_that("sensitivity solver handles bounded and null-centered effects", {
  variance <- power_compute("f_variance_two", "sensitivity")
  common <- power_compute("z_corr_dependent_common", "sensitivity")
  no_common <- power_compute("z_corr_dependent_no_common", "sensitivity")

  expect_true(variance$outputs$variance_ratio > 1)
  expect_true(common$outputs$rho_ac >= -1 && common$outputs$rho_ac <= 1)
  expect_true(no_common$outputs$rho_cd >= -1 && no_common$outputs$rho_cd <= 1)
  expect_equal(variance$outputs$power, 0.8, tolerance = 1e-5)
  expect_equal(common$outputs$power, 0.8, tolerance = 1e-5)
  expect_equal(no_common$outputs$power, 0.8, tolerance = 1e-5)
})

test_that("compromise solver returns alpha and beta ratio", {
  result <- power_compute(
    "t_one_sample",
    "compromise",
    d = 0.5,
    n = 40,
    q = 1,
    tails = "two"
  )

  expect_true(result$outputs$alpha > 0)
  expect_true(result$outputs$beta > 0)
  expect_equal(result$outputs$beta_alpha_ratio, 1, tolerance = 1e-4)
})
