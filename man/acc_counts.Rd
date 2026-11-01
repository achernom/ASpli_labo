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
# Get data tables from an ASpliCounts object
counts <- aspliCountsExample()

cb   <- countsb( counts )
ce1i <- countse1i( counts )
cg   <- countsg( counts )
cie2 <- countsie2( counts )
cj   <- countsj( counts )
rg   <- rdsg( counts )
rb   <- rdsb( counts )
co   <- condition.order( counts )
tg   <- targets( counts )

# Set data tables to an ASpliCounts object
counts2 <- new( 'ASpliCounts' )
countsb( counts2 )   <- cb
countse1i( counts2 ) <- ce1i
countsg( counts2 )   <- cg
countsie2( counts2 ) <- cie2
countsj( counts2 )   <- cj
rdsg( counts2 )      <- rg
rdsb( counts2 )      <- rb
}


