\name{ASpli-defunct}
\alias{ASpli-defunct}
\alias{DUreport}
\alias{DUreportBinSplice}
\alias{junctionDUreport}
\alias{filterDU}
\alias{mergeBinDUAS}
\alias{plotGenomicRegions}
\alias{readCounts}
\alias{AsDiscover}
\alias{loadBAM}

\title{Defunct functions in package \sQuote{ASpli}: migrating from the v1 workflow}

\description{
  The functions listed below belonged to the workflow of \sQuote{ASpli} 1.x. 
  They had been deprecated since the introduction of the new pipeline 
  (\sQuote{ASpli} 2.0) and have now been removed from the package. This page
  explains which functions replace them and how to convert a script written
  for the old workflow. Older Bioconductor releases of \sQuote{ASpli}, which 
  still contain these functions, can be installed by users that cannot migrate
  immediately.
}

\details{
  \tabular{ll}{
    \bold{Removed function} \tab \bold{Replacement} \cr
    \code{loadBAM}, \code{readCounts} \tab \code{\link{gbCounts}} \cr
    \code{AsDiscover} \tab \code{\link{jCounts}} \cr
    \code{DUreport}, \code{DUreportBinSplice} \tab \code{\link{gbDUreport}} \cr
    \code{junctionDUreport} \tab \code{\link{jDUreport}} \cr
    \code{mergeBinDUAS}, \code{filterDU} \tab \code{\link{splicingReport}}, \code{\link{integrateSignals}} and \code{\link{filterSignals}} \cr
    \code{plotGenomicRegions} \tab \code{\link{exportSplicingReports}} and \code{\link{exportIntegratedSignals}} \cr
  }

  \itemize{
    \item \code{loadBAM} and \code{readCounts}: \code{gbCounts} reads the bam
      files listed in \code{targets} one by one, so it is no longer needed to
      load all the alignments in memory first (there is no \code{bams} object
      anymore). \code{readLength} was renamed to \code{minReadLength}, and the
      new arguments \code{libType} (\code{"SE"} or \code{"PE"}) and 
      \code{strandMode} control how the reads are loaded. The \code{cores} 
      argument was dropped.
    \item \code{AsDiscover}: \code{jCounts} takes the \code{ASpliCounts} object 
      returned by \code{gbCounts} (it does not need \code{targets} nor bams) 
      and returns an \code{ASpliAS} object. \code{readLength} is now 
      \code{minReadLength}.
    \item \code{DUreport} and \code{DUreportBinSplice}: differential gene 
      expression and bin usage are estimated by \code{gbDUreport}, which 
      uses \code{edgeR} and accepts either a \code{contrast} or a model 
      \code{formula}. \code{\link{DUreport.norm}} and 
      \code{\link{DUreport.offset}} remain available.
    \item \code{junctionDUreport}: \code{jDUreport} analyses differential 
      junction usage starting from the \code{ASpliAS} object produced by
      \code{jCounts}, and returns an \code{ASpliJDU} object.
    \item \code{mergeBinDUAS} and \code{filterDU}: bin and junction results are 
      combined with \code{splicingReport}, and the combined signals are 
      summarised along genomic regions by \code{integrateSignals}. Filtering is
      done on the resulting objects with \code{filterSignals}.
    \item \code{plotGenomicRegions}: the plots of genomic regions are now 
      produced, together with the tables, by \code{exportSplicingReports} and 
      \code{exportIntegratedSignals} as HTML reports. \code{\link{plotBins}} 
      is still available.
  }
}

\section{Migrating the v1 workflow}{
  A script written for \sQuote{ASpli} 1.x looked like this:

  \preformatted{
  features <- binGenome( genomeTxDb )
  bams     <- loadBAM( targets )
  counts   <- readCounts( features, bams, targets, cores = 1, 
                          readLength = 100, maxISize = 50000 )
  du       <- DUreport.norm( counts, targets, contrast = c(-1, 1) )
  as       <- AsDiscover( counts, targets, features, bams, 
                          readLength = 100, threshold = 5, cores = 1 )
  merged   <- mergeBinDUAS( du, as, targets, contrast = c(-1, 1) )
  plotGenomicRegions( merged, genomeTxDb, features, targets )
  }

  The equivalent code for the current workflow is:

  \preformatted{
  features <- binGenome( genomeTxDb )
  gbcounts <- gbCounts( features = features, targets = targets, 
                        minReadLength = 100, maxISize = 50000 )
  asd      <- jCounts( counts = gbcounts, features = features, 
                       minReadLength = 100 )
  gb       <- gbDUreport( gbcounts, contrast = c(-1, 1) )
  jdur     <- jDUreport( asd, contrast = c(-1, 1) )
  sr       <- splicingReport( gb, jdur, counts = gbcounts )
  is       <- integrateSignals( sr, asd )
  exportIntegratedSignals( is, sr = sr, output.dir = "aspliExample",
                           counts = gbcounts, features = features, 
                           asd = asd, mergedBams = mBAMs )
  }

  Here \code{mBAMs} is a data frame with the columns \code{bam} (merged bam 
  file of each condition) and \code{condition}. See the package vignette for 
  a complete description of the workflow.
}

\value{ None. These functions no longer exist. }

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz }

\seealso{
  \code{\link{gbCounts}}, \code{\link{jCounts}}, \code{\link{gbDUreport}}, 
  \code{\link{jDUreport}}, \code{\link{splicingReport}}, 
  \code{\link{integrateSignals}}, \code{\link{filterSignals}},
  \code{\link{exportSplicingReports}}, \code{\link{exportIntegratedSignals}}
}

\examples{
  # Current workflow, first steps: annotation features and targets
  features <- aspliFeaturesExample()
  targets  <- aspliTargetsExample()
  class( features )
  head( targets, 3 )
}
