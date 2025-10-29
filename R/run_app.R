#' Launch the Bushfire Explorer App
#'
#' This function launches the Shiny web application bundled in the package.
#' It provides an interactive interface to explore the relationship between
#' Fire Weather Index (FWI) and burned area using the packaged dataset.
#'
#' @return Opens the Shiny app in your browser.
#' @examples
#' if (interactive()) {
#'   run_app()
#' }
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "quanyu")
  if (app_dir == "") {
    stop("App not found. Re-install or reload the package.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}

