mod_protocol_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    class = "gp-window gp-page gp-page-fit",
    gp_page_header_ui(
      title = "Protocol",
      subtitle = "Session log of every power analysis run in this workspace.",
      compact = TRUE
    ),
    shiny::div(
      class = "gp-page-panel gp-protocol-panel gp-protocol-scroll",
      shiny::div(
        class = "gp-panel-toolbar",
        shiny::h4("Session protocol"),
        shiny::downloadButton(ns("download_protocol"), "Download", class = "btn-primary btn-sm")
      ),
      shiny::div(class = "gp-protocol-body", shiny::uiOutput(ns("protocol_cards")))
    )
  )
}

mod_protocol_server <- function(id, protocol) {
  shiny::moduleServer(id, function(input, output, session) {
    output$protocol_cards <- shiny::renderUI({
      entries <- protocol()
      if (length(entries) == 0) {
        return(shiny::div(class = "gp-empty-state", "No calculations yet. Run an analysis from any module."))
      }
      shiny::tagList(lapply(seq_along(entries), function(i) {
        shiny::div(
          class = "gp-protocol-card",
          shiny::div(class = "gp-protocol-card-title", paste("Analysis", i)),
          shiny::tags$pre(class = "gp-protocol-card-body", entries[[i]])
        )
      }))
    })

    output$download_protocol <- shiny::downloadHandler(
      filename = function() paste0("ggpower-protocol-", Sys.Date(), ".txt"),
      content = function(file) {
        writeLines(paste(protocol(), collapse = "\n\n---\n\n"), file)
      }
    )
  })
}
