
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AIriskjobs

<!-- badges: start -->
<!-- badges: end -->

The goal of AIriskjobs is designed to analyze and visualize job market
trends affected by advancements in artificial intelligence. This package
aims to provide users with the tools to identify at-risk job categories,
assess the potential impact of AI on employment, and generate insights
to inform workforce planning and policy decisions. By simplifying the
data analysis process, AIriskjobs enables users to harness the power of
AI data to understand labor market dynamics effectively.

## Installation

You can install the development version of AIriskjobs from
[GitHub](https://github.com/) with:

``` r
# Install remotes if not already installed
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install AIriskjobs package from GitHub
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-Vaishhh125")
```

## Shiny App

AIriskjobs includes a Shiny application to allow interactive exploration
of the job market data. You can launch the app with the following
command:

``` r
library(AIriskjobs)
run_app()  # Launches the 'jobsatrisk' Shiny app
```

## Vignettes

For an in-depth walkthrough and additional examples, check out our
vignette by running the following command in R:

``` r
vignette("AIriskjobs_overview", package = "AIriskjobs")
```

## License

This package is licensed under the MIT License. See LICENSE for details.

## Pkgdown Site

For more information, visit the pkgdown site at
<https://etc5523-2024.github.io/assignment-4-packages-and-shiny-apps-Vaishhh125/>.
