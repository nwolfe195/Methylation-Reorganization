library(methylumi)
library(minfi)

baseExtractor <- function(file){
  #print(file)
  split <- unlist(strsplit(file, "_"))
  split <- split[-length(split)]
  return(paste(split, collapse = "_"))
}

path <- "/proj/regeps/regep00/studies/CAMP/data/methylation/CAMP_27K/raw_data/HARVARD IDAT FILES 110426"
directories <- list.files(path = path)

for (dir in directories){
  print(dir)
  files <- unlist(file.path(path,dir,list.files(file.path(path, dir))))
  basenames <- unique(unlist(lapply(files, baseExtractor)))
  rgset <- read.metharray(basenames, verbose = TRUE)
  mset <- preprocessRaw(rgset)
  methout <- paste("/proj/regeps/regep00/studies/CAMP/data/methylation/CAMP_27K/exports/",dir,"_meth.txt",sep = "")
  unmethout <- paste("/proj/regeps/regep00/studies/CAMP/data/methylation/CAMP_27K/exports/",dir,"_unmeth.txt",sep = "")
  write.table(getMeth(mset), file = methout)
  write.table(getUnmeth(mset), file = unmethout)
}

