#' @export
runShiny <- function() {
  appDir <- system.file("shinyapp", package = "IPAG")
  if (appDir == "") {
    stop("Could not find shinyapp directory. Try re-installing `IPAG`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
