\name{Counts accesors}
\alias{countsb}
\alias{countse1i}
\alias{countsg}
\alias{countsie2}
\alias{countsj}
\alias{rdsg}
\alias{rdsb}
\alias{condition.order}
\alias{targets}
\alias{countsb<-}
\alias{countse1i<-}
\alias{countsg<-}
\alias{countsie2<-}
\alias{countsj<-}
\alias{rdsg<-}
\alias{rdsb<-}

\title{
Accessors for ASpliCounts object
}
\description{
Accessors for ASpliCounts object
}
\usage{
countsb(x)
countse1i(x)
countsg(x)
countsie2(x)
countsj(x)
rdsg(x)
rdsb(x)
condition.order(x)
targets(x)
}
\arguments{
  \item{x}{   
  An ASpliCounts object 
  }
}
\value{
Returns dataframes with counts by sample and genomic metadata
}

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\examples{
# Create an empty ASpliCounts object and access its (empty) data tables.
# See the ASpli vignette for a complete workflow producing a populated object.
counts <- new( 'ASpliCounts' )

countsg( counts )
countsb( counts )
countsj( counts )
rdsg( counts )
rdsb( counts )

# Set data tables to an ASpliCounts object
countsg( counts ) <- data.frame()
}


