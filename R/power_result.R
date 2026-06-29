#' Create a ggpower result object
#'
#' @param test,analysis Character labels for the selected test and analysis.
#' @param inputs Named list of input parameters.
#' @param outputs Named list of computed output values.
#' @param notes Character vector with assumptions, warnings, or method notes.
#' @param distribution Named list describing the H0/H1 distributions.
#'
#' @return An object of class `ggpower_result`.
#' @export
ggpower_result <- function(test, analysis, inputs, outputs,
                           notes = character(), distribution = list()) {
  structure(
    list(
      test = test,
      analysis = analysis,
      inputs = inputs,
      outputs = outputs,
      notes = notes,
      distribution = distribution
    ),
    class = "ggpower_result"
  )
}

#' @export
print.ggpower_result <- function(x, ...) {
  cat("ggpower result\n")
  cat("Test: ", x$test, "\n", sep = "")
  cat("Analysis: ", x$analysis, "\n\n", sep = "")

  if (length(x$inputs) > 0) {
    cat("Input parameters\n")
    cat(.format_named_values(x$inputs), sep = "\n")
    cat("\n\n")
  }

  if (length(x$outputs) > 0) {
    cat("Output parameters\n")
    cat(.format_named_values(x$outputs), sep = "\n")
    cat("\n")
  }

  if (length(x$notes) > 0) {
    cat("\nNotes\n")
    cat(paste0("- ", x$notes), sep = "\n")
    cat("\n")
  }

  invisible(x)
}

format.ggpower_result <- function(x, ...) {
  capture.output(print(x))
}

.format_named_values <- function(values) {
  vapply(names(values), function(name) {
    value <- values[[name]]

    if (length(value) > 1) {
      value <- paste(format(value, digits = 7), collapse = ", ")
    } else if (is.numeric(value)) {
      value <- format(value, digits = 7)
    } else {
      value <- as.character(value)
    }

    paste0("  ", name, ": ", value)
  }, character(1))
}

#' Format a ggpower result as structured HTML for Shiny UI
#'
#' @param x A `ggpower_result` object.
#' @return A `shiny.tag` list for `renderUI`.
#' @export
format_result_html <- function(x) {
  power_val <- x$outputs$power %||% x$outputs$actual_power
  metrics <- list()
  if (!is.null(power_val)) {
    metrics <- c(metrics, list(list(label = "Power", value = format(power_val, digits = 4), accent = TRUE)))
  }
  if (!is.null(x$outputs$total_sample_size)) {
    metrics <- c(metrics, list(list(label = "Total N", value = as.character(x$outputs$total_sample_size))))
  }
  if (!is.null(x$outputs$alpha)) {
    metrics <- c(metrics, list(list(label = "Alpha", value = format(x$outputs$alpha, digits = 4))))
  }
  if (!is.null(x$outputs$beta)) {
    metrics <- c(metrics, list(list(label = "Beta", value = format(x$outputs$beta, digits = 4))))
  }

  metric_cards <- if (length(metrics) > 0) {
    shiny::div(
      class = "gp-metric-row",
      lapply(metrics, function(m) {
        shiny::div(
          class = paste("gp-metric-card", if (isTRUE(m$accent)) "gp-metric-accent"),
          shiny::div(class = "gp-metric-label", m$label),
          shiny::div(class = "gp-metric-value", m$value)
        )
      })
    )
  }

  shiny::div(
    class = "gp-result-panel",
    shiny::div(class = "gp-result-title", x$test),
    shiny::div(class = "gp-result-meta", paste("Analysis:", x$analysis)),
    metric_cards,
    if (length(x$inputs) > 0) {
      shiny::div(
        class = "gp-result-block",
        shiny::div(class = "gp-result-block-title", "Inputs"),
        shiny::tags$pre(class = "gp-result-pre", paste(.format_named_values(x$inputs), collapse = "\n"))
      )
    },
    if (length(x$outputs) > 0) {
      shiny::div(
        class = "gp-result-block",
        shiny::div(class = "gp-result-block-title", "Outputs"),
        shiny::tags$pre(class = "gp-result-pre", paste(.format_named_values(x$outputs), collapse = "\n"))
      )
    },
    if (length(x$notes) > 0) {
      shiny::div(
        class = "gp-result-notes",
        shiny::tags$ul(lapply(x$notes, shiny::tags$li))
      )
    }
  )
}

.gp_result <- function(test, analysis, inputs, outputs,
                       notes = character(), distribution = list()) {
  ggpower_result(
    test = test,
    analysis = analysis,
    inputs = inputs,
    outputs = outputs,
    notes = notes,
    distribution = distribution
  )
}
