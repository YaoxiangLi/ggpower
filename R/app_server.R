#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  protocol <- shiny::reactiveVal(character())

  mod_power_workspace_server("power_workspace", protocol = protocol)
  mod_biomarker_server("biomarker", protocol = protocol)
  mod_clinical_server("clinical", protocol = protocol)
  mod_calculator_server("calculator")
  mod_protocol_server("protocol", protocol = protocol)
  mod_help_server("help")
}
