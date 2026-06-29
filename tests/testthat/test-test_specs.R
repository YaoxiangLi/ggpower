test_that("test registry exposes required metadata", {
  tests <- ggpower_tests()

  expect_true(nrow(tests) >= 20)
  expect_true(all(c("id", "family", "label") %in% names(tests)))
  expect_true(all(nzchar(tests$id)))
  expect_true(all(nzchar(tests$family)))
  expect_true(all(nzchar(tests$label)))
})

test_that("registered tests have compute specs", {
  registry <- ggpower_test_registry()

  for (id in names(registry)) {
    spec <- ggpower_get_test(id)
    expect_equal(spec$id, id)
    expect_true(length(spec$modes) >= 1)
    expect_true(length(spec$fields) >= 1)
    expect_true(is.character(spec$effect))
    expect_true(is.character(spec$sample))
  }
})

test_that("effect size helpers compute standard conversions", {
  expect_equal(effect_size_d(15, 10, 8), 0.625)
  expect_equal(effect_size_f(0.2), 0.5)
  expect_equal(eta2_from_f(0.5), 0.2)
  expect_equal(effect_size_f2(0.1), 0.1111111, tolerance = 1e-6)
  expect_equal(r2_from_f2(0.1111111), 0.1, tolerance = 1e-7)
  expect_equal(odds_ratio_from_probs(0.5, 0.6), 1.5)
})
