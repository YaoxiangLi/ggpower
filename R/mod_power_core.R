mod_power_core_ui <- function(id, config) {
  ns <- shiny::NS(id)
  registry <- ggpower_tests(module = config$module_filter)
  families <- unique(registry$family)
  first_family <- families[[1]]
  first_tests <- registry[registry$family == first_family, , drop = FALSE]
  first_spec <- ggpower_get_test(first_tests$id[[1]])
  first_analysis <- .gp_analysis_choices_for_modes(first_spec$modes)

  shiny::tagList(
    shiny::div(
      class = "gp-window gp-workspace",
      gp_page_header_ui(
        title = config$title,
        subtitle = config$subtitle,
        badges = lapply(config$badges, function(b) {
          shiny::span(class = b$class %||% "gp-badge", b$label)
        }),
        compact = TRUE
      ),
      if (!is.null(config$tip)) {
        gp_inline_tip_ui(config$tip)
      },
      shiny::div(
        class = "gp-selector-row gp-selector-grid",
        gp_select_ui(
          ns("family"),
          "Test family",
          choices = families,
          selected = first_family
        ),
        gp_select_ui(
          ns("test"),
          "Statistical test",
          choices = stats::setNames(first_tests$id, first_tests$label),
          selected = first_tests$id[[1]]
        ),
        gp_select_ui(
          ns("analysis"),
          "Type of power analysis",
          choices = first_analysis,
          selected = first_spec$modes[[1]]
        )
      ),
      shiny::div(
        class = "gp-main-grid",
        shiny::div(
          class = "gp-plot-panel",
          shiny::h4("Central and noncentral distributions"),
          shiny::div(
            class = "gp-plot-wrap",
            shiny::plotOutput(ns("distribution_plot"), height = "100%")
          )
        ),
        shiny::div(
          class = "gp-output-panel",
          shiny::h4("Output parameters"),
          shiny::uiOutput(ns("result_output"))
        ),
        shiny::div(
          class = "gp-input-panel",
          shiny::h4("Input parameters"),
          shiny::div(class = "gp-input-grid", shiny::uiOutput(ns("input_fields"))),
          shiny::div(
            class = "gp-action-row",
            shiny::actionButton(ns("determine"), "Determine"),
            shiny::actionButton(ns("calculate"), "Calculate", class = "btn-primary gp-btn-calculate"),
            shiny::actionButton(ns("reset"), "Reset")
          )
        ),
        shiny::div(
          class = "gp-xy-panel",
          shiny::h4("X-Y plot for a range of values"),
          shiny::div(
            class = "gp-plot-wrap gp-plot-wrap-sm",
            shiny::plotOutput(ns("xy_plot"), height = "100%")
          ),
          shiny::div(class = "gp-xy-table-wrap", shiny::tableOutput(ns("xy_table")))
        )
      )
    )
  )
}

mod_power_core_server <- function(id, config, protocol = NULL) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    registry <- ggpower_tests(module = config$module_filter)
    last_result <- shiny::reactiveVal(NULL)
    xy_data <- shiny::reactiveVal(data.frame())
    calculating <- shiny::reactiveVal(FALSE)

    shiny::observeEvent(input$family, {
      available <- registry[registry$family == input$family, , drop = FALSE]
      if (nrow(available) == 0) {
        return()
      }
      shiny::updateSelectInput(
        session,
        "test",
        choices = stats::setNames(available$id, available$label),
        selected = available$id[[1]]
      )
    }, ignoreInit = FALSE)

    shiny::observeEvent(input$test, {
      shiny::req(input$test)
      spec <- ggpower_get_test(input$test)
      choices <- .gp_analysis_choices_for_modes(spec$modes)
      selected <- if (input$analysis %in% spec$modes) input$analysis else spec$modes[[1]]
      shiny::updateSelectInput(session, "analysis", choices = choices, selected = selected)
    }, ignoreInit = TRUE)

    output$input_fields <- shiny::renderUI({
      shiny::req(input$test, input$analysis)
      spec <- ggpower_get_test(input$test)
      fields <- .gp_fields_for_mode(spec, input$analysis)
      shiny::tagList(lapply(fields, function(field) .gp_input_control(ns, field)))
    })

    shiny::observeEvent(input$determine, {
      shiny::req(input$test)
      shiny::showModal(.gp_effect_modal(input$test, ns))
    })

    shiny::observeEvent(input$reset, {
      spec <- ggpower_get_test(input$test %||% registry$id[[1]])
      for (field in spec$fields) {
        default <- .gp_field_defaults()[[field]] %||% NULL
        if (!is.null(default)) {
          shiny::updateNumericInput(session, field, value = default)
        }
      }
    })

    shiny::observeEvent(input$calculate, {
      shiny::req(input$test, input$analysis)
      calculating(TRUE)
      on.exit(calculating(FALSE))
      params <- .gp_collect_inputs(input, input$test)
      result <- tryCatch(
        do.call(power_compute, c(list(test = input$test, analysis = input$analysis), params)),
        error = function(e) e
      )

      if (inherits(result, "error")) {
        shiny::showNotification(result$message, type = "error")
        return()
      }

      last_result(result)
      if (!is.null(protocol)) {
        protocol(c(protocol(), paste(format(result), collapse = "\n")))
      }
      xy_data(.gp_make_xy_data(input$test, input$analysis, params))
    }, ignoreInit = TRUE)

    output$result_output <- shiny::renderUI({
      if (isTRUE(calculating())) {
        return(shiny::div(class = "gp-loading-state", shiny::tags$span(class = "gp-spinner"), "Recalculating..."))
      }
      result <- last_result()
      if (is.null(result)) {
        return(shiny::div(class = "gp-empty-state", "Click Calculate to run a power analysis."))
      }
      format_result_html(result)
    })

    output$distribution_plot <- shiny::renderPlot({
      result <- last_result()
      if (is.null(result)) {
        .gp_empty_plot("Run a calculation to see H0 and H1 distributions")
      } else {
        plot_distribution(result) + theme_ggpower()
      }
    })

    output$xy_plot <- shiny::renderPlot({
      dat <- xy_data()
      if (nrow(dat) == 0) {
        .gp_empty_plot("Run a calculation to generate an X-Y plot")
      } else {
        ggplot2::ggplot(dat, ggplot2::aes(x = total_n, y = power)) +
          ggplot2::geom_line(color = "#1f6f8b", linewidth = 1.1) +
          ggplot2::geom_point(color = "#c0392b", size = 2) +
          ggplot2::scale_y_continuous(limits = c(0, 1)) +
          ggplot2::labs(x = "Total sample size", y = "Power (1 - beta)") +
          theme_ggpower()
      }
    })

    output$xy_table <- shiny::renderTable({
      dat <- xy_data()
      if (nrow(dat) == 0) {
        return(NULL)
      }
      utils::head(dat, 10)
    }, digits = 4)
  })
}
