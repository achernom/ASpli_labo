\name{AS accessors}

\alias{altPSI}
\alias{esPSI}
\alias{irPIR}
\alias{joint}
\alias{junctionsPIR}
\alias{junctionsPJU}
\alias{altPSI<-}
\alias{esPSI<-}
\alias{irPIR<-}
\alias{joint<-}
\alias{junctionsPIR<-}
\alias{junctionsPJU<-}

\title{ Accessors for ASpliAS object }

\description{ Methods to retrieve and set data in ASpliAS object. Setting data 
into an ASpliAS object is not a typical task and must be done with care, because
it can affect the integrity of the object. }

\usage{
altPSI( x )
esPSI( x )
irPIR( x )
joint( x )
junctionsPIR( x )
junctionsPJU( x )
}

\arguments{
  \item{ x }{ An ASpliAS object }
}
\value{ Returns dataframes with genomic metadata and  PSI and PIR metrics }

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\examples{
# Create an empty ASpliAS object and access its (empty) data tables.
# See the ASpli vignette for a complete workflow producing a populated object.
as <- new( 'ASpliAS' )

altPSI( as )
esPSI( as )
irPIR( as )
joint( as )
junctionsPIR( as )
junctionsPJU( as )

# Set data tables to an ASpliAS object
altPSI( as ) <- data.frame()
}

