library(testthat)
library(ggpower)  # Ensure ggpower is loaded

test_that("power_t_two_sample returns a valid power between 0 and 1", {
  pwr <- power_t_two_sample(d = 0.5, n_per_group = 30)
  expect_true(is.numeric(pwr))
  expect_true(pwr > 0 && pwr < 1)
})

test_that("ggpower_ttest returns a ggplot object", {
  p <- ggpower_ttest(d = 0.5, alpha = 0.05, n_range = seq(10, 100, by = 10))
  expect_s3_class(p, "ggplot")
})

test_that("Power increases with sample size", {
  # Compute power for two different sample sizes
  power_small <- power_t_two_sample(d = 0.5, n_per_group = 20)
  power_large <- power_t_two_sample(d = 0.5, n_per_group = 40)
  expect_true(power_large > power_small)
})
