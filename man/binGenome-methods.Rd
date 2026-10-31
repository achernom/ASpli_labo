\name{binGenome-methods}

\docType{methods}

\alias{binGenome-methods}
\alias{binGenome,TxDb-method}

\title{ Feature coordinates extraction }

\description{ Feature coordinates extraction from a Transcript Database }

\section{Methods}{
  \describe{
    \item{\code{signature(genome = "TxDb")}}{
      An object of class transcriptDb (TxDb) 
    }
  }
}


\value{An \code{\linkS4class{ASpliFeatures}} object. See \code{\link{binGenome}}.}

\author{Estefania Mancini, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz }
\seealso{ \code{\link{featuresg}, \link{featuresb} , \link{featuresj} 
} 
}

\examples{
library(GenomicFeatures)
genomeTxDb <- txdbmaker::makeTxDbFromGFF( aspliExampleGTF() )
features <- binGenome( genomeTxDb )
features
}
