#--- Makes a safe version of all data files we hold ---
# Follows same basic process as the codebook:
# - make safe
# - creates derived vars for later use
library(dkUtils)
library(readr)
library(data.table)

dataLoc <- path.expand("/Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/")
iPath <- paste0(dataLoc, "raw/")
oPath <- paste0(dataLoc, "safe/")

# get file list ----
fileNames <- list.files(path = iPath , pattern = "EVBlackBox*")
fListDT <- data.table::as.data.table(fileNames)
fListDT <- fListDT[, fullPath := path.expand(paste0(iPath, fileNames))]

# load the data into 1 data table ----
ftfDT <- rbindlist(lapply(fListDT$fullPath,
                            function(f)
                              data.table::as.data.table(readr::read_csv(f,
                                                                        progress = FALSE)
                                                        )
                            ), fill = TRUE
                     )

# create derived
ftfDT <- evAnalysis::ftfCreateDerived(ftfDT) # any parsing failures are NA dates

# make it safe
ftfSafeDT <- evAnalysis::ftfCreateSafe(ftfDT)

# save safe data out  ----
of <- path.expand(paste0(dataLoc, "safe/ftfSafeLatestAll.csv"))

data.table::fwrite(ftfSafeDT, of)

dkUtils::gzipIt(of)

message("Saved and gzipped ", of)
