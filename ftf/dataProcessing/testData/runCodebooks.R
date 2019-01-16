### ----- About ----
# Run codebooks for all file supplied
####

print(paste0("#-> Load dkUtils package"))
library(dkUtils) # my utils :-) get this via devtools::install_github("dataknut/dkUtils")
print(paste0("#-> Done "))

# Load libraries needed in this script ----
localLibs <- c("data.table",
               "rmarkdown",
               "bookdown",
               "evAnalysis"
               )
dkUtils::loadLibraries(localLibs)

# Se global parameters for the package
evAnalysis::setup() # creates evParams list

# Local functions ----

# Set local parameters ----

dataLoc <- path.expand("/Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/")
rmdFile <- paste0(evParams$repoLoc, "/ftf/dataProcessing/testData/ftFBlackBoxTestDataCodebook.Rmd")


# --- Code ---

# --- Set files to run over ---
dVersion <- "v0.1"
idPath <- paste0(dataLoc, "raw/testData/", dVersion, "/") # input data location
odPath <- paste0(paste0(dataLoc, "safe/testData/", dVersion, "/")) # where to put safe data

fileNames <- list.files(path = idPath , pattern = ".csv.gz$") # assumes data has this ending
fListDT <- data.table::as.data.table(fileNames)
fListDT <- fListDT[, fullPath := path.expand(paste0(idPath, fileNames))]

# --- Run codebook(s) ----
for(f in fListDT$fullPath){
  fileName <-  fListDT[fullPath == f, fileNames ]
  codebook <- paste0(idPath, "codebook_", fileName, ".html" ) # save codebooks to data folder
  iFile = f
  oFile = paste0(odPath, fileName, "_safe.csv")
  rmarkdown::render(input = rmdFile,
                    output_format = "html_document2", # required for skim to work
                    params = list(iFile = iFile,
                                  fileName = fileName,
                                  oFile = oFile),
                    output_file = codebook # save codebooks to data location
  )
}

