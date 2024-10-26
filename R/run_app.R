#' Run the jobsatrisk Shiny App
#'
#' This function launches the interactive Shiny app for exploring the AIriskjobs dataset.
#' @export
run_app <- function() {
  shiny::runApp(system.file("shinyapp", package = "AIriskjobs"))
}
