#' ggpower_two_sample UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ggpower_two_sample_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::sliderInput(
      ns("n_range"),
      "Sample Size per Group:",
      min = 10, max = 100, value = c(10, 100), step = 5
    ),
    shiny::numericInput(
      ns("d"),
      "Effect Size (Cohen's d):",
      value = 0.5
    ),
    shiny::numericInput(
      ns("alpha"),
      "Alpha:",
      value = 0.05, min = 0, max = 1, step = 0.01
    ),
    shiny::plotOutput(ns("powerPlot"))
  )
}

#' ggpower_two_sample Server Functions
#'
#' @noRd
mod_ggpower_two_sample_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    output$powerPlot <- shiny::renderPlot({
      # Create a sequence of sample sizes per group based on the slider input
      n_seq <- seq(input$n_range[1], input$n_range[2], by = 5)
      # Generate and return the ggplot power curve for two-sample t-test.
      ggpower_ttest(d = input$d, alpha = input$alpha, n_range = n_seq)
    })
  })
}

## To be copied in the UI
# mod_ggpower_two_sample_ui("ggpower_two_sample_1")

## To be copied in the server
# mod_ggpower_two_sample_server("ggpower_two_sample_1")
