mod_clinical_ui <- function(id) {
  n_tests <- nrow(ggpower_tests(module = "clinical"))
  mod_power_core_ui(
    id,
    list(
      module_filter = "clinical",
      title = "Clinical trials",
      subtitle = "Power for superiority, non-inferiority, equivalence, Simon two-stage, cluster RCT, and survival endpoints.",
      badges = list(
        list(label = paste0(n_tests, " trial designs")),
        list(label = "Phase II / III", class = "gp-badge gp-badge-accent")
      ),
      tip = "Protocol planning for randomized trials. Use non-inferiority or equivalence when the goal is similarity rather than superiority."
    )
  )
}

mod_clinical_server <- function(id, protocol = NULL) {
  mod_power_core_server(
    id,
    list(module_filter = "clinical"),
    protocol = protocol
  )
}
