# Map vignette slug to example power_compute call
examples <- list(
  "biomarker-differential-expression" = 'power_compute("ttest_biomarker", "post_hoc", d = 0.6, n1 = 40, n2 = 40)',
  "biomarker-diagnostic-accuracy" = 'power_compute("diagnostic_acc", "post_hoc", sensitivity = 0.9, specificity = 0.9, n_pos = 80, n_neg = 80)',
  "biomarker-survival" = 'power_compute("survival_logrank", "post_hoc", hazard_ratio = 0.65, event_rate = 0.5, total_n = 200)',
  "biomarker-cox-prognostic" = 'power_compute("cox_regression", "post_hoc", hazard_ratio = 1.5, events = 100)',
  "biomarker-multiplicity-fdr" = 'power_compute("discovery_fdr", "post_hoc", m_tests = 500, pi0 = 0.9, effect_d = 0.5, n = 30)',
  "pharma-non-inferiority" = 'power_compute("rct_noninferiority_continuous", "post_hoc", d = 0, ni_margin = 0.2, n1 = 80, n2 = 80)',
  "pharma-equivalence-tost" = 'power_compute("rct_equivalence_continuous", "post_hoc", d = 0, eq_margin = 0.25, n1 = 60, n2 = 60)',
  "pharma-simon-two-stage" = 'power_compute("simon_two_stage", "post_hoc", p0 = 0.2, p1 = 0.35, n1 = 15, r1 = 4, n2 = 20, r = 10)',
  "pharma-cluster-rct" = 'power_compute("cluster_rct", "post_hoc", d = 0.5, icc = 0.05, cluster_size = 10, n_clusters = 20)',
  "pharma-survival-endpoints" = 'power_compute("survival_pmu", "post_hoc", hazard_ratio = 0.7, event_rate = 0.6, total_n = 250)',
  "pharma-binary-and-count-endpoints" = 'power_compute("count_endpoint_poisson", "post_hoc", exp_beta1 = 1.3, base_rate = 0.85, total_n = 120)'
)

vdir <- "vignettes"
for (slug in names(examples)) {
  path <- file.path(vdir, paste0(slug, ".Rmd"))
  if (!file.exists(path)) next
  lines <- readLines(path, warn = FALSE)
  idx <- grep("^```\\{r example", lines)
  if (length(idx) == 0) next
  end <- grep("^```$", lines[(idx[1] + 1):length(lines)])[1] + idx[1]
  new_block <- c(
    "```{r example, eval=FALSE}",
    examples[[slug]],
    "```"
  )
  lines <- c(lines[1:(idx[1] - 1)], new_block, lines[(end + 1):length(lines)])
  writeLines(lines, path, useBytes = TRUE)
  file.copy(path, file.path("articles", basename(path)), overwrite = TRUE)
}
cat("Updated", length(examples), "vignettes\n")
