mod_help_ui <- function(id) {
  ns <- shiny::NS(id)
  articles <- .gp_vignette_index()

  shiny::div(
    class = "gp-window gp-page gp-page-fit",
    gp_page_header_ui(
      title = "Help",
      subtitle = "Guides and reference articles for every workflow.",
      compact = TRUE
    ),
    shiny::div(
      class = "gp-page-panel gp-help-panel gp-help-fit",
      do.call(
        shiny::tabsetPanel,
        c(
          list(id = ns("section"), type = "pills"),
          lapply(names(articles), function(section) {
            shiny::tabPanel(
              title = section,
              shiny::div(
                class = "gp-help-grid",
                lapply(articles[[section]], function(article) {
                  shiny::div(
                    class = "gp-help-card",
                    shiny::h4(article$title),
                    shiny::p(article$summary),
                    shiny::tags$a(
                      class = "gp-help-link",
                      href = article$url,
                      target = "_blank",
                      shiny::icon("arrow-up-right-from-square"),
                      "Read article"
                    )
                  )
                })
              )
            )
          })
        )
      )
    )
  )
}

mod_help_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    invisible(NULL)
  })
}

.gp_vignette_index <- function() {
  base <- "https://yaoxiangli.github.io/ggpower/articles"
  list(
    "Getting started" = list(
      list(title = "Choosing a power analysis", summary = "Pick the test family, module, and analysis mode.", url = paste0(base, "/choosing-a-power-analysis.html")),
      list(title = "Getting started with the GUI", summary = "Navigate modules, wide-screen layout, and workflow tips.", url = paste0(base, "/getting-started-gui.html")),
      list(title = "Scenario guide", summary = "Which module and test for your study design.", url = paste0(base, "/scenario-guide.html")),
      list(title = "Reference validation", summary = "Golden examples with expected outputs.", url = paste0(base, "/reference-validation.html"))
    ),
    "Test families" = list(
      list(title = "t Tests", summary = "One-sample, paired, two-sample, point-biserial, slopes.", url = paste0(base, "/t-tests.html")),
      list(title = "Workspace test families", summary = "ANOVA, exact tests, correlations, GLM, nonparametric.", url = paste0(base, "/workspace-test-families.html")),
      list(title = "ANOVA and regression", summary = "F tests, ANOVA, multiple regression, variances.", url = paste0(base, "/anova-regression.html")),
      list(title = "Exact and proportions", summary = "Binomial, Fisher, McNemar, chi-square.", url = paste0(base, "/exact-and-proportions.html")),
      list(title = "Correlation and z tests", summary = "Fisher Z, dependent correlations, GLM.", url = paste0(base, "/correlation-and-z-tests.html")),
      list(title = "Nonparametric tests", summary = "Wilcoxon signed-rank and Mann-Whitney.", url = paste0(base, "/nonparametric-tests.html")),
      list(title = "Logistic and Poisson", summary = "GLM Wald power for binary and count outcomes.", url = paste0(base, "/logistic-poisson.html"))
    ),
    "Biomarker discovery" = list(
      list(title = "Biomarker endpoints", summary = "Overview of all biomarker discovery tests.", url = paste0(base, "/biomarker-endpoints.html")),
      list(title = "Differential expression", summary = "Two-group biomarker mean differences.", url = paste0(base, "/biomarker-differential-expression.html")),
      list(title = "ROC / AUC", summary = "Diagnostic classifier discrimination power.", url = paste0(base, "/biomarker-roc-auc.html")),
      list(title = "Diagnostic accuracy", summary = "Sensitivity and specificity validation.", url = paste0(base, "/biomarker-diagnostic-accuracy.html")),
      list(title = "Survival biomarkers", summary = "Log-rank and time-to-event stratification.", url = paste0(base, "/biomarker-survival.html")),
      list(title = "Cox prognostic models", summary = "Hazard ratio power for scored biomarkers.", url = paste0(base, "/biomarker-cox-prognostic.html")),
      list(title = "Multiplicity and FDR", summary = "Omics screening under FDR control.", url = paste0(base, "/biomarker-multiplicity-fdr.html"))
    ),
    "Clinical trials" = list(
      list(title = "Clinical trials", summary = "Overview of superiority, NI, equivalence, and more.", url = paste0(base, "/clinical-trials.html")),
      list(title = "Phase III superiority", summary = "Continuous and binary superiority trials.", url = paste0(base, "/pharma-phase-iii-superiority.html")),
      list(title = "Non-inferiority", summary = "NI margins for means and proportions.", url = paste0(base, "/pharma-non-inferiority.html")),
      list(title = "Equivalence (TOST)", summary = "Bioequivalence and similarity trials.", url = paste0(base, "/pharma-equivalence-tost.html")),
      list(title = "Simon two-stage", summary = "Oncology Phase II single-arm designs.", url = paste0(base, "/pharma-simon-two-stage.html")),
      list(title = "Cluster RCT", summary = "Design effect from intraclass correlation.", url = paste0(base, "/pharma-cluster-rct.html")),
      list(title = "Survival endpoints", summary = "OS, PFS, and event-driven sample size.", url = paste0(base, "/pharma-survival-endpoints.html")),
      list(title = "Binary and count endpoints", summary = "Response rates and Poisson counts.", url = paste0(base, "/pharma-binary-and-count-endpoints.html"))
    ),
    "Reference" = list(
      list(title = "Formula reference", summary = "All power formulas in one place.", url = paste0(base, "/formula-reference.html")),
      list(title = "Support matrix", summary = "Test x mode x domain coverage table.", url = paste0(base, "/support-matrix.html")),
      list(title = "Analysis modes", summary = "Worked examples for all five modes.", url = paste0(base, "/analysis-modes.html")),
      list(title = "Effect size conversions", summary = "Helper functions with formulas.", url = paste0(base, "/effect-size-conversions.html")),
      list(title = "Calculator", summary = "Distribution-function scripts.", url = paste0(base, "/calculator.html")),
      list(title = "Approximation catalog", summary = "Parity limits and method notes.", url = paste0(base, "/approximation-catalog.html")),
      list(title = "Publication figures", summary = "Plotting and export helpers.", url = paste0(base, "/publication-figures.html"))
    )
  )
}
