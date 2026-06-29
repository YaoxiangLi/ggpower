mod_biomarker_ui <- function(id) {
  n_tests <- nrow(ggpower_tests(module = "biomarker"))
  mod_power_core_ui(
    id,
    list(
      module_filter = "biomarker",
      title = "Biomarker discovery",
      subtitle = "Power for ROC/AUC, diagnostic accuracy, survival, Cox regression, and FDR-controlled screening.",
      badges = list(
        list(label = paste0(n_tests, " biomarker tests")),
        list(label = "Discovery workflows", class = "gp-badge gp-badge-accent")
      ),
      tip = "Biomarker validation, omics screening, and diagnostic classifiers. Start with ROC AUC or differential expression; use FDR for panel studies."
    )
  )
}

mod_biomarker_server <- function(id, protocol = NULL) {
  mod_power_core_server(
    id,
    list(module_filter = "biomarker"),
    protocol = protocol
  )
}
