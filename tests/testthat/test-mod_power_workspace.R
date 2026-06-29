test_that("power workspace ui renders", {
  ui <- mod_power_workspace_ui("workspace")
  expect_s3_class(ui, "shiny.tag.list")
})

test_that("power workspace server calculates a result", {
  testthat::skip_if_not_installed("shiny")

  protocol <- shiny::reactiveVal(character())
  shiny::testServer(
    mod_power_workspace_server,
    args = list(id = "workspace", protocol = protocol),
    {
      session$setInputs(
        family = "t tests",
        test = "t_one_sample",
        analysis = "post_hoc",
        tails = "two",
        d = 0.5,
        alpha = 0.05,
        n = 40
      )
      session$setInputs(calculate = 1)

      expect_length(protocol(), 1L)
      expect_match(protocol()[[1]], "one sample case")
    }
  )
})
