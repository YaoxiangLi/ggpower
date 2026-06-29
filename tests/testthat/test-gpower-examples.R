test_that("one-sample t-test matches reference a priori example", {
  result <- power_compute(
    "t_one_sample",
    "a_priori",
    d = 0.625,
    alpha = 0.05,
    power = 0.95,
    tails = "one"
  )

  expect_equal(result$inputs$total_sample_size, 30)
  expect_equal(result$outputs$actual_power, 0.955144, tolerance = 1e-5)
  expect_equal(result$outputs$df, 29)
})

test_that("multiple regression omnibus matches reference example", {
  result <- power_compute(
    "f_mreg_omnibus",
    "post_hoc",
    f2 = 0.1111111,
    alpha = 0.05,
    total_n = 95,
    predictors = 5
  )

  expect_equal(result$outputs$noncentrality_parameter, 10.555555, tolerance = 1e-5)
  expect_equal(result$outputs$critical_f, 2.316858, tolerance = 1e-5)
  expect_equal(result$outputs$denominator_df, 89)
  expect_equal(result$outputs$power, 0.673586, tolerance = 1e-5)
})

test_that("ANOVA special example matches manual power value", {
  result <- power_compute(
    "f_anova_special",
    "post_hoc",
    f = 0.2450722,
    alpha = 0.05,
    total_n = 108,
    df1 = 4,
    groups = 36
  )

  expect_equal(result$outputs$noncentrality_parameter, 6.486521, tolerance = 1e-5)
  expect_equal(result$outputs$denominator_df, 72)
  expect_equal(result$outputs$power, 0.475635, tolerance = 1e-5)
})

test_that("independent two-sample t supports unequal sample sizes", {
  result <- power_compute(
    "t_two_sample",
    "post_hoc",
    d = 0.5,
    n1 = 4,
    n2 = 8,
    alpha = 0.05,
    tails = "one"
  )

  expect_equal(result$outputs$noncentrality_parameter, 0.816497, tolerance = 1e-5)
  expect_equal(result$outputs$df, 10)
  expect_equal(result$outputs$power, 0.188667, tolerance = 1e-5)
})
