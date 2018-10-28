evParams <<- list() # params holder

# Location of data
evParams$repoLoc <- dkUtils::findParentDirectory("evAnalysis")

# Vars for Rmd
evParams$pubLoc <- "[Centre for Sustainability](http://www.otago.ac.nz/centre-sustainability/), University of Otago: Dunedin, New Zealand"
evParams$otagoHCS <- "the University of Otago's High-Capacity Central File Storage [HCS](https://www.otago.ac.nz/its/services/hosting/otago068353.html)"

# Misc
evParams$b2Kb <- 1024 #http://whatsabyte.com/P1/byteconverter.htm
evParams$b2Mb <- 1048576

