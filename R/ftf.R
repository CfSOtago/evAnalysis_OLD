# --- Code to support analysis of FlipTheFleet data --- #


#' Creates useful derived variables and returns dt
#'
#' \code{createDerivedFtF}:
#'
#'    sets proper dates and times for R;
#'    guesses 'home' by looking at location from 01:00 - 04:00. A future version might try geocoding other
#'    locations (e.g public charging points) via lat/long look-up
#'
#'
#' adds new derived variables to the passed data.table and returns it
#'
#' @import data.table
#' @import lubridate
#' @import hms
#'
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#'
createDerivedFtF <- function(dt){
  # dates and times
  dt <- dt[, rDate := lubridate::dmy(`Date (GPS)`)] # fix date, some will be NA if no GPS signal
  dt <- dt[, rTime := hms::parse_hms(`Time (GPS)`)] # fix Time, some will be NA if no GPS signal
  dt <- dt[, rDateTime := lubridate::ymd_hms(paste0(rDate, rTime))] # set full dateTime
  dt$rTime <- NULL # to avoid space & confusion - easy to recreate later
  dt$rDate <- NULL # as above
  # infer location
  # could use a fancy bounding box but...
  # find bb for the hours of 01:00 - 05:00: we assume this is 'home'
  dt <- dt[, obsHour := lubridate::hour(rDateTime)]
  dt <- dt[, homeMinLat := min(dt[obsHour > 1 & obsHour < 5]$Latitude), by = .(`Reg No`)] # do this for each value of reg no so bbox is different for each one
  dt <- dt[, homeMaxLat := max(dt[obsHour > 1 & obsHour < 5]$Latitude), by = .(`Reg No`)]
  dt <- dt[, homeMinLon := min(dt[obsHour > 1 & obsHour < 5]$Longitude), by = .(`Reg No`)]
  dt <- dt[, homeMaxLon := max(dt[obsHour > 1 & obsHour < 5]$Longitude), by = .(`Reg No`)]
  dt <- dt[, derivedLocation := ifelse((Latitude >= homeMinLat & Latitude <= homeMaxLat) &
                                         (Longitude >= homeMinLon & Longitude <= homeMaxLon), "Home?", "Not home?"), # set home if within bb at any time
           by = .(`Reg No`)]
  dt$obsHour <- NULL # as above
  return(dt)
}


#' Remove disclosive variables
#'
#' \code{createSafeFtF} creates a new uhnique EV ID byhashing the `Reg No` and then removes the following disclosive variables:
#'  `Reg No`
#'  `Latitude`
#'  `Longitude`
#'  `Course (deg)`
#'
#'  These should be removed prior to any data sharing.
#'
#' @import openssl
#'
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#'
createSafeFtF <- function(dt){
  dt <- dt[, evID := openssl::md5(`Reg No`)] # hash the reg number to get a unique anonymous id - see https://en.wikipedia.org/wiki/MD5 and ?openssl::md5
  safeDT <- dt[, c("Reg No", "Latitude", "Longitude", "Course (deg)") := NULL]
  return(safeDT)
}
