\name{integratedSignals accessors}
\alias{signals}
\alias{signals<-}
\alias{filters}
\alias{filters<-}


\title{Accessors for ASpliIntegratedSignals object}

\description{ Accessors for ASpliIntegratedSignals object }
\usage{ 
  signals( x )
  filters( x )
}

\arguments{
  \item{ x }{ An ASpliIntegratedSignals object }
}

\value{ Returns dataframes }

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz }

\examples{
# Empty object; see ?integrateSignals for a complete example.
is <- new( 'ASpliIntegratedSignals' )
signals( is )
filters( is )
}
