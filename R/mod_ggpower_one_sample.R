#' ggpower_one_sample UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ggpower_one_sample_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::sliderInput(
      ns("n_range"),
      "Total Sample Size:",
      min = 20, max = 200, value = c(20, 200), step = 5
    ),
    shiny::numericInput(
      ns("d"),
      "Effect Size (d):",
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

#' ggpower_one_sample Server Functions
#'
#' @noRd
mod_ggpower_one_sample_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    output$powerPlot <- shiny::renderPlot({
      # Create a sequence of total sample sizes based on the slider input
      n_seq <- seq(input$n_range[1], input$n_range[2], by = 5)
      # Generate and return the ggplot power curve for one-sample t-test
      ggpower_t_one_sample(d = input$d, alpha = input$alpha, n_range = n_seq)
    })
  })
}

## To be copied in the UI
# mod_ggpower_one_sample_ui("ggpower_one_sample_1")

## To be copied in the server
# mod_ggpower_one_sample_server("ggpower_one_sample_1")
