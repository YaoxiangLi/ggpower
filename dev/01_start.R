# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application and set some default {golem} options
##
## /!\ Note: if you want to change the name of your app during development,
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
##
golem::fill_desc(
  pkg_name = "ggpower", # The name of the golem package containing the app (typically lowercase, no underscore or periods)
  pkg_title = "Publication-Ready Power Analysis and Visualization", # What the Package Does (One Line, Title Case, No Period)
  pkg_description = "Provides a suite of functions for performing statistical power analyses and sample size calculations for various tests – including t-tests, ANOVA, regression, chi-square tests, and nonparametric tests. It also offers interactive, publication-ready visualizations using the ggplot2 framework, enabling users to explore power curves and sensitivity analyses with ease.", # What the package does (one paragraph).
  authors = person(
    given = "Yaoxiang",  # Replace with your first name
    family = "Li",  # Replace with your last name
    email = "liyaoxiang@outlook.com",  # Replace with your email
    role = c("aut", "cre")  # Your role: author and creator
  ),
  repo_url = NULL, # The URL of the GitHub Repo (optional),
  pkg_version = "0.1.1" # The Version of the package containing the App
)

## Install the required dev dependencies ----
golem::install_dev_deps()

## Create Common Files ----
## See ?usethis for more information
usethis::use_gpl3_license()
golem::use_readme_rmd(open = FALSE)
devtools::build_readme()
# Note that `contact` is required since usethis version 2.1.5
# If your {usethis} version is older, you can remove that param
usethis::use_code_of_conduct(contact = "Yaoxiang Li")
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md(open = FALSE)

## Adding dependencies
# usethis::use_package("dplyr")
usethis::use_package("ggplot2")
usethis::use_package("bs4Dash")



## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon() # path = "path/to/ico". Can be an online file.
# golem::remove_favicon() # Uncomment to remove the default favicon

## Add helper functions ----
golem::use_utils_ui(with_test = TRUE)
golem::use_utils_server(with_test = TRUE)

## Use git ----
usethis::use_git()
## Sets the remote associated with 'name' to 'url'
usethis::use_git_remote(
  name = "origin",
  url = "https://github.com/<OWNER>/<REPO>.git"
)

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile("dev/02_dev.R")
