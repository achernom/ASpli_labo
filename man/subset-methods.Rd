\name{Subset ASpli objects}

\alias{subsetBams}
\alias{subsetTargets}
\alias{subset}

\title{ Subset ASpli objects }

\description{
  ASpli provides utility functions to easy subset ASpliCounts objects, 
  ASpliAS objects, targets data frame and lists of GAlignments objects (one
  per sample). The subset can be done selecting some of the experimental 
  conditions or samples names ( but not both ).
}

\usage{
  subset( x, ... )
  subsetBams( x, targets, select )
  subsetTargets( targets, select, removeRedundantExpFactors )
}

\arguments{
  \item{ x }{ 
    An ASpliCount or ASpliAS object for subset function, or list of GAlignments 
    for subsetrBams function.
  }
  \item{ targets }{
    A dataframe containing sample, bam and experimental factor columns.
  }
  \item{ select }{
    A character vector specifying the conditions or samples to be kept after 
    subset operation. It's assumed that condition names are different from 
    sample names. 
  }
  \item{ removeRedundantExpFactors }{
    When sub-setting the targets data frame, one or more experimental factors 
    can have only one value. If this argument is TRUE those experimental 
    factors are absent in the resulting target data frame. 
  }
  \item{ ... }{ Subsetting ASpliCounts and ASpliAS objects sub subset method 
    requires a targets argument and a select argument with the same 
    specifications that the arguments with the same name in subsetBams and 
    subsetTargets functions }
  
}
\value{ A data frame similar to x ( or targets for subsetTargets) with only the
 containing only the selected elements. }

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\examples{
  # Example ASpliCounts and ASpliAS objects, and their targets
  counts  <- aspliCountsExample()
  as      <- aspliASexample()
  targets <- targets( counts )[ , c( "bam", "f1" ) ]

  # Define selection
  select <- c( 'Sample1', 'Sample2', 'Sample4', 'Sample5' )

  # Subset target
  targets2 <- subsetTargets( targets, select )

  # Subset ASpliCounts object
  counts2 <- subset( counts, targets, select )

  # Subset ASpliAS object
  as2 <- subset( as, targets, select )
}

