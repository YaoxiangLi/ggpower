#' Shared UI components for the ggpower Shiny app
#' @noRd
gp_brand_ui <- function(compact = FALSE, grad_id = "gpLogoGrad") {
  shiny::tags$span(
    class = if (compact) "gp-brand gp-brand-compact" else "gp-brand",
    shiny::tags$span(
      class = "gp-brand-logo",
      shiny::HTML(sprintf(
        '<svg viewBox="0 0 40 40" aria-hidden="true" focusable="false" role="img">
          <defs>
            <linearGradient id="%1$s" x1="0%%" y1="0%%" x2="100%%" y2="100%%">
              <stop offset="0%%" stop-color="#0c4a6e"/>
              <stop offset="55%%" stop-color="#0e7490"/>
              <stop offset="100%%" stop-color="#22d3ee"/>
            </linearGradient>
            <linearGradient id="%1$sGlow" x1="0%%" y1="100%%" x2="100%%" y2="0%%">
              <stop offset="0%%" stop-color="#ffffff" stop-opacity="0"/>
              <stop offset="100%%" stop-color="#ffffff" stop-opacity="0.22"/>
            </linearGradient>
          </defs>
          <rect x="1" y="1" width="38" height="38" rx="11" fill="url(#%1$s)"/>
          <rect x="1" y="1" width="38" height="38" rx="11" fill="url(#%1$sGlow)"/>
          <path d="M10 27 C13.5 27, 15.5 22, 18.5 22 C21.5 22, 23 27, 27 27" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" opacity="0.35"/>
          <path d="M11 26 C14.2 24.2, 16.4 19.5, 20 16.5 C23.2 13.8, 26.5 12.5, 29.5 11.5" fill="none" stroke="#ffffff" stroke-width="2.6" stroke-linecap="round"/>
          <circle cx="29.5" cy="11.5" r="2.4" fill="#ecfeff"/>
          <rect x="11" y="24" width="3" height="6" rx="1" fill="#ffffff" opacity="0.55"/>
          <rect x="16" y="21" width="3" height="9" rx="1" fill="#ffffff" opacity="0.72"/>
          <rect x="21" y="18" width="3" height="12" rx="1" fill="#ffffff" opacity="0.9"/>
        </svg>',
        grad_id
      ))
    ),
    shiny::tags$span(
      class = "gp-brand-wordmark",
      shiny::tags$span(class = "gp-brand-gg", "gg"),
      shiny::tags$span(class = "gp-brand-power", "power")
    )
  )
}

#' @noRd
gp_page_header_ui <- function(title, subtitle, badges = NULL, compact = FALSE) {
  shiny::div(
    class = if (compact) "gp-header gp-header-compact" else "gp-header",
    shiny::div(
      class = "gp-header-copy",
      shiny::h1(class = "gp-title", title),
      if (!compact && !is.null(subtitle) && nzchar(subtitle)) {
        shiny::p(class = "gp-subtitle", subtitle)
      }
    ),
    if (!is.null(badges) && length(badges) > 0) {
      shiny::div(class = "gp-header-badges", badges)
    }
  )
}

#' @noRd
gp_inline_tip_ui <- function(text) {
  shiny::div(class = "gp-inline-tip", shiny::icon("circle-info"), shiny::span(text))
}

#' @noRd
gp_select_ui <- function(id, label, choices, selected = NULL, width = "100%") {
  shiny::div(
    class = "gp-field",
    shiny::selectInput(
      inputId = id,
      label = label,
      choices = choices,
      selected = selected,
      width = width
    )
  )
}
