#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @importFrom shiny tagList icon tags
#' @importFrom bs4Dash bs4DashPage bs4DashNavbar bs4DashSidebar bs4DashBody bs4TabItems bs4TabItem bs4DashControlbar bs4DashFooter sidebarMenu menuItem
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    bs4Dash::bs4DashPage(
      help = FALSE,
      dark = FALSE,
      fullscreen = FALSE,
      scrollToTop = FALSE,
      header = bs4Dash::bs4DashNavbar(
        title = gp_brand_ui(grad_id = "gpLogoNav"),
        skin = "light",
        status = "white",
        border = FALSE
      ),
      sidebar = bs4Dash::bs4DashSidebar(
        width = "240px",
        skin = "dark",
        status = "dark",
        elevation = 0,
        collapsed = FALSE,
        minified = FALSE,
        expandOnHover = FALSE,
        fixed = TRUE,
        title = gp_brand_ui(compact = TRUE, grad_id = "gpLogoSide"),
        sidebarMenu(
          id = "sidebar_menu",
          menuItem("Power Workspace", tabName = "workspace", icon = icon("chart-line")),
          menuItem("Biomarker Discovery", tabName = "biomarker", icon = icon("dna")),
          menuItem("Clinical Trials", tabName = "clinical", icon = icon("pills")),
          menuItem("Calculator", tabName = "calculator", icon = icon("calculator")),
          menuItem("Protocol", tabName = "protocol", icon = icon("clipboard-list")),
          menuItem("Help", tabName = "help", icon = icon("book-open"))
        )
      ),
      body = bs4Dash::bs4DashBody(
        bs4Dash::bs4TabItems(
          bs4Dash::bs4TabItem(tabName = "workspace", mod_power_workspace_ui("power_workspace")),
          bs4Dash::bs4TabItem(tabName = "biomarker", mod_biomarker_ui("biomarker")),
          bs4Dash::bs4TabItem(tabName = "clinical", mod_clinical_ui("clinical")),
          bs4Dash::bs4TabItem(tabName = "calculator", mod_calculator_ui("calculator")),
          bs4Dash::bs4TabItem(tabName = "protocol", mod_protocol_ui("protocol")),
          bs4Dash::bs4TabItem(tabName = "help", mod_help_ui("help"))
        )
      ),
      controlbar = bs4Dash::bs4DashControlbar(disable = TRUE),
      footer = bs4Dash::bs4DashFooter(
        left = tags$span(class = "gp-footer-left", gp_brand_ui(compact = TRUE, grad_id = "gpLogoFoot")),
        right = tags$span(
          class = "gp-footer-right",
          tags$a(href = "https://yaoxiangli.github.io/ggpower/", target = "_blank", "Documentation")
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "ggpower"
    ),
    tags$link(rel = "preconnect", href = "https://fonts.googleapis.com"),
    tags$link(rel = "preconnect", href = "https://fonts.gstatic.com", crossorigin = "anonymous"),
    tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
    ),
    tags$link(rel = "stylesheet", type = "text/css", href = "www/custom.css"),
    tags$script(src = "www/layout.js")
  )
}
