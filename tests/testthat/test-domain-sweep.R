test_that("all domain kernels run post_hoc without error", {
  biomarker <- c(
    "roc_auc_one", "roc_auc_two", "diagnostic_acc", "survival_logrank",
    "cox_regression", "discovery_fdr", "ttest_biomarker"
  )
  clinical <- c(
    "rct_superiority_continuous", "rct_superiority_binary",
    "rct_noninferiority_continuous", "rct_noninferiority_binary",
    "rct_equivalence_continuous", "rct_equivalence_proportion",
    "simon_two_stage", "cluster_rct", "multi_arm_superiority",
    "count_endpoint_poisson", "survival_pmu"
  )

  for (test in c(biomarker, clinical)) {
    result <- power_compute(test, analysis = "post_hoc")
    expect_s3_class(result, "ggpower_result")
    expect_true(!is.null(result$outputs$power) || !is.null(result$outputs$actual_power))
  }
})

test_that("format_result_html returns shiny tag", {
  result <- power_compute("t_one_sample", analysis = "post_hoc", d = 0.5, n = 40)
  html <- format_result_html(result)
  expect_s3_class(html, "shiny.tag")
})

test_that("layout script is bundled with the app", {
  path <- system.file("app/www/layout.js", package = "ggpower")
  expect_true(file.exists(path))
  expect_true(grepl("gp-layout-hd", readLines(path, warn = FALSE)[[1]], fixed = TRUE) ||
    any(grepl("gp-layout-hd", readLines(path, warn = FALSE))))
})
