#' Sets a range of parameters re-used throughout the repo by sourcing the <repo>/evParams.R file
#'
#' \code{setup} sources the <repo>/ggParams.R file which sets a range of parameters as elements of the `evParams` list. These include data sources and .Rmd include locations.
#'
#'   The parameters can be over-written in scipts if needed but do so wih care!
#'
#'   Requires the dkUtils package: devtools::install_github("dataknut/dkUtils")
#'
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @import dkUtils
#' @export
#'
setup <- function(){
  pLoc <- dkUtils::findParentDirectory("evAnalysis") # R project location
  source(paste0(pLoc, "/evParams.R"))
}
