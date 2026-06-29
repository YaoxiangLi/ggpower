mod_calculator_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    class = "gp-window gp-page gp-page-fit",
    gp_page_header_ui(
      title = "Calculator",
      subtitle = "Evaluate distribution functions and statistical expressions interactively.",
      compact = TRUE
    ),
    shiny::div(
      class = "gp-page-panel gp-calculator-panel gp-calculator-split",
      shiny::div(
        class = "gp-calculator-editor",
        shiny::h4("Expression editor"),
        shiny::div(
          class = "gp-field",
          shiny::textAreaInput(
            ns("calculator_script"),
            "Expressions",
            value = "alpha <- 0.05\nnctcdf(1.699127, 29, 3.423266)",
            width = "100%",
            rows = 6
          )
        ),
        shiny::div(
          class = "gp-action-row gp-action-row-inline",
          shiny::actionButton(ns("run_calculator"), "Run", class = "btn-primary")
        )
      ),
      shiny::div(
        class = "gp-calculator-output",
        shiny::h4("Output"),
        shiny::div(
          class = "gp-terminal",
          shiny::verbatimTextOutput(ns("calculator_result"), placeholder = TRUE)
        )
      )
    )
  )
}

mod_calculator_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    calculator_result <- shiny::reactiveVal(NULL)

    output$calculator_result <- shiny::renderPrint({
      result <- calculator_result()
      if (is.null(result)) {
        return("Enter expressions and click Run.")
      }
      result
    })

    shiny::observeEvent(input$run_calculator, {
      result <- tryCatch(
        ggpower_calculator(input$calculator_script),
        error = function(e) e
      )
      if (inherits(result, "error")) {
        shiny::showNotification(result$message, type = "error")
        calculator_result(result$message)
        return()
      }
      calculator_result(result)
    })
  })
}
