test_that("clinical kernels return valid post_hoc power", {
  r1 <- power_compute("rct_superiority_continuous", analysis = "post_hoc", d = 0.5, n1 = 50, n2 = 50)
  expect_s3_class(r1, "ggpower_result")
  expect_true(r1$outputs$power > 0.5)

  r2 <- power_compute("rct_superiority_binary", analysis = "post_hoc", p0 = 0.3, p1 = 0.45, n1 = 120, n2 = 120)
  expect_true(r2$outputs$power > 0.4)

  r3 <- power_compute(
    "rct_noninferiority_continuous", analysis = "post_hoc",
    d = 0, ni_margin = 0.2, n1 = 80, n2 = 80
  )
  expect_true(r3$outputs$power > 0.3)

  r4 <- power_compute(
    "rct_noninferiority_binary", analysis = "post_hoc",
    p0 = 0.5, p1 = 0.55, ni_margin = 0.1, n1 = 200, n2 = 200
  )
  expect_true(r4$outputs$power > 0.4)

  r5 <- power_compute(
    "rct_equivalence_continuous", analysis = "post_hoc",
    d = 0, eq_margin = 0.25, n1 = 60, n2 = 60
  )
  expect_true(r5$outputs$power > 0.1)

  r6 <- power_compute(
    "simon_two_stage", analysis = "post_hoc",
    p0 = 0.2, p1 = 0.35, n1 = 15, r1 = 4, n2 = 20, r = 10
  )
  expect_true(r6$outputs$power > 0.3)

  r7 <- power_compute(
    "cluster_rct", analysis = "post_hoc",
    d = 0.5, icc = 0.05, cluster_size = 10, n_clusters = 20
  )
  expect_true(r7$outputs$power > 0.4)

  r8 <- power_compute("survival_pmu", analysis = "post_hoc", hazard_ratio = 0.7, event_rate = 0.6, total_n = 250)
  expect_true(r8$outputs$power > 0.4)
})

test_that("registry domain tags are present", {
  tests <- ggpower_tests()
  expect_true(all(c("domain", "module") %in% names(tests)))
  expect_true(any(tests$domain == "biomarker"))
  expect_true(any(tests$domain == "pharma"))
  expect_equal(nrow(ggpower_tests(module = "biomarker")), 7)
  expect_equal(nrow(ggpower_tests(module = "clinical")), 11)
})
