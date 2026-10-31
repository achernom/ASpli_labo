\name{DU accessors}
\alias{genesDE}
\alias{genesDE<-}
\alias{binsDU}
\alias{binsDU<-}
\alias{junctionsDU}
\alias{junctionsDU<-}

\title{Accessors for ASpliDU object}

\description{ Accessors for ASpliDU object }
\usage{ 
  genesDE( x )
  binsDU( x )
  junctionsDU( x )
}

\arguments{
  \item{ x }{ An ASpliDU object }
}

\value{ Returns dataframes with genomic metadata and logFC and pvalue }


\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\examples{
# Create an empty ASpliDU object and access its (empty) data tables.
# See the ASpli vignette for a complete workflow producing a populated object.
du <- new( 'ASpliDU' )

genesDE( du )
binsDU( du )
junctionsDU( du )

# Set data tables to an ASpliDU object
genesDE( du ) <- data.frame()
}


