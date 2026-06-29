test_that("biomarker kernels return valid post_hoc power", {
  r1 <- power_compute("roc_auc_one", analysis = "post_hoc", auc = 0.8, auc0 = 0.5, n_pos = 60, n_neg = 60)
  expect_s3_class(r1, "ggpower_result")
  expect_true(r1$outputs$power > 0.5)

  r2 <- power_compute("roc_auc_two", analysis = "post_hoc", auc1 = 0.78, auc2 = 0.62, n1 = 80, n2 = 80)
  expect_true(r2$outputs$power > 0.4)

  r3 <- power_compute(
    "diagnostic_acc", analysis = "post_hoc",
    sensitivity = 0.9, specificity = 0.9, n_pos = 80, n_neg = 80
  )
  expect_true(r3$outputs$power > 0.5)

  r4 <- power_compute(
    "survival_logrank", analysis = "post_hoc",
    hazard_ratio = 0.6, event_rate = 0.5, total_n = 200
  )
  expect_true(r4$outputs$power > 0.5)

  r5 <- power_compute("cox_regression", analysis = "post_hoc", hazard_ratio = 1.6, events = 120)
  expect_true(r5$outputs$power > 0.5)

  r6 <- power_compute(
    "discovery_fdr", analysis = "post_hoc",
    m_tests = 500, pi0 = 0.85, effect_d = 0.6, n = 40
  )
  expect_true(r6$outputs$power > 0)

  r7 <- power_compute("ttest_biomarker", analysis = "post_hoc", d = 0.6, n1 = 40, n2 = 40)
  expect_true(r7$outputs$power > 0.5)
})

test_that("biomarker a priori and sensitivity solvers run", {
  r1 <- power_compute("roc_auc_one", analysis = "a_priori", auc = 0.75, auc0 = 0.5, power = 0.8)
  expect_true((r1$inputs$n_positive + r1$inputs$n_negative) >= 4)

  r2 <- power_compute(
    "survival_logrank", analysis = "sensitivity",
    hazard_ratio = 0.7, event_rate = 0.5, total_n = 200, power = 0.8
  )
  expect_true(r2$outputs$hazard_ratio > 0)
})
