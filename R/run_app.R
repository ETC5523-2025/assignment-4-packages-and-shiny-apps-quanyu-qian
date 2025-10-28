#' Launch the Shiny app bundled in this package
#'
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "quanyu")
  if (app_dir == "") {
    stop("App not found. Re-install or reload the package.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
