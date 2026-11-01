\name{rds}
\alias{rds}

\title{
  Read density of gene and bins
}

\description{
  Read density of gene and bins is the quotient between the number of read 
  counts and the length of the feature. The results are appended into an 
  ASpliCounts object that must be given as argument. The explicit calculation 
  of read densities is usually not required because is automatically performed
  by \code{gbCounts} function.
}

\usage{
  rds( counts, targets )
}

\arguments{
  \item{counts}{ An ASpliCounts object }
  \item{targets}{ A data frame containing sample, bam and experimental factors 
    columns}
}

\value{
  An ASpliCounts object containing read densities of genes and bins.
}

\examples{
  # Example ASpliCounts object and its targets
  counts  <- aspliCountsExample()
  targets <- targets( counts )[ , c( "bam", "f1" ) ]

  # Calculate read densities of genes and bins
  counts <- rds( counts, targets )
  head( rdsg( counts ), 3 )
}

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }
