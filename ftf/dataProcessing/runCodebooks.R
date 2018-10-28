### ----- About ----
# Run codebooks for all file supplied
####

print(paste0("#-> Load dkUtils package"))
library(dkUtils) # my utils :-) get this via devtools::install_github("dataknut/dkUtils")
print(paste0("#-> Done "))

# Load libraries needed in this script ----
localLibs <- c("data.table",
               "rmarkdown",
               "bookdown"
               )
dkUtils::loadLibraries(localLibs)

# Local functions ----

# Local parameters ----

GREENGrid::setup()

dataLoc <- path.expand("/Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/")
rmdFile <- paste0(ggParams$repoLoc, "/dataProcessing/ftf/ftFBlackBoxTestDataCodebook.Rmd")
outputLoc <- path.expand(paste0(ggParams$repoLoc, "/dataProcessing/"))

# --- Code ---

# --- Set files to run over ---
path <- paste0(dataLoc, "raw/")
fileNames <- list.files(path = path , pattern = "EVBlackBox*")
fListDT <- data.table::as.data.table(fileNames)
fListDT <- fListDT[, fullPath := path.expand(paste0(path, fileNames))]

# --- Run codebook(s) ----
for(f in fListDT$fullPath){
  fileName <-  fListDT[fullPath == f, fileNames ]
  rmarkdown::render(input = rmdFile,
                    output_format = "html_document2",
                    params = list(dataLoc = dataLoc, iFile = f, fileName = fileName),
                    output_file = paste0(outputLoc,"ftf/codebook_", fileName, ".html")
  )
}

