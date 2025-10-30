#' Launch the Bushfire Explorer App
#'
#' This function launches the interactive **Bushfire Explorer** Shiny web application
#' included in the `quanyu` package. The app provides an interface for exploring
#' the relationship between **Fire Weather Index (FWI)** and **burned area** using
#' the built-in dataset `se_fire_monthly`.
#'
#' @details
#' The app allows users to:
#' - Filter records by month and minimum FWI value
#' - Visualize the positive relationship between FWI and burned area
#' - Hover to view point-level details
#' - Explore results interactively with custom CSS styling
#'
#' @return Launches the Shiny app in the browser window.
#' @examples
#' \dontrun{
#'   run_app()
#' }
#'
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "quanyu")
  if (app_dir == "") {
    stop("App not found. Re-install or reload the package.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}

