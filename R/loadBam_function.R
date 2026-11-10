.loadBAM <- function( targets, libType, strandMode ) {
    datac <- lapply( as.character(targets$bam), function(x){

    #option to load as SE o PE, default PE:
    if(libType=="SE"){ 
      r <- readGAlignments(x) 
    }
    else {
      r <- readGAlignmentPairs(x, strandMode=strandMode) 
    }
      #Normalize seqnames. If . present in name, changes it to _ and warns the user
      if(length(grep("[.]", seqlevels(r)) > 0)){
        seqlevels(r) <- gsub("[.]", "_", seqlevels(r))
        warning("Some seqnames had a '.' present in their names. ASpli had to normalize them using '_'.")
      }
      return(r)
    })
  names( datac ) <- rownames(targets)
  
  return(datac)
  
}
