library(testthat)
library(ggpower)

test_that("power_t_one_sample returns a number between 0 and 1", {
  pwr <- power_t_one_sample(d = 0.5, n = 40)
  expect_true(is.numeric(pwr))
  expect_true(pwr > 0 && pwr < 1)
})

test_that("ggpower_t_one_sample returns a ggplot object", {
  p <- ggpower_t_one_sample(d = 0.5, alpha = 0.05, n_range = seq(20, 100, by = 10))
  expect_s3_class(p, "ggplot")
})

test_that("Increasing sample size increases power", {
  power_small <- power_t_one_sample(d = 0.5, n = 30)
  power_large <- power_t_one_sample(d = 0.5, n = 60)
  expect_true(power_large > power_small)
})
