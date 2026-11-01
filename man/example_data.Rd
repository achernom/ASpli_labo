\name{Example data}

\alias{aspliASexample}
\alias{aspliCountsExample}
\alias{aspliDUexample1}
\alias{aspliDUexample2}
\alias{aspliExampleBamList}
\alias{aspliExampleGTF}
\alias{aspliFeaturesExample}
\alias{aspliIntegratedSignalsExample}
\alias{aspliJunctionDUexample}
\alias{aspliSplicingReportExample}
\alias{aspliTargetsExample}


\title{
  Example Aspli objects
}
\description{
  ASpli includes functions to easily build ASpli objects, used in examples in 
  the vignette and man pages.
}

\details{
  The objects returned by \code{aspliCountsExample}, \code{aspliASexample},
  \code{aspliDUexample1}, \code{aspliDUexample2}, \code{aspliJunctionDUexample}, 
  \code{aspliSplicingReportExample} and \code{aspliIntegratedSignalsExample} are 
  the result of running the ASpli workflow (see the vignette) on the example
  data of the package (6 bam files, \sQuote{control} versus \sQuote{treatment}, 
  factor \code{f1}): \code{ASpliCounts}, \code{ASpliAS}, \code{ASpliDU} 
  (genes and bins; both \code{aspliDUexample1} and \code{aspliDUexample2} return
  it), \code{ASpliJDU}, \code{ASpliSplicingReport} and 
  \code{ASpliIntegratedSignals} objects. The targets stored in them are those 
  of \code{aspliTargetsExample()[1:6, ]} with the factor \code{f1}.
}

\usage{
  aspliASexample()
  aspliCountsExample()
  aspliDUexample1()
  aspliDUexample2()
  aspliExampleBamList()
  aspliExampleGTF()
  aspliFeaturesExample()
  aspliIntegratedSignalsExample()
  aspliJunctionDUexample()
  aspliSplicingReportExample()
  aspliTargetsExample()
}

\value{ An ASpli object with example data.}

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\examples{
gtffile  <- aspliExampleGTF()
bamfiles <- aspliExampleBamList()
targets  <- aspliTargetsExample()
features <- aspliFeaturesExample()

counts <- aspliCountsExample()
as     <- aspliASexample()
du     <- aspliDUexample1()
jdu    <- aspliJunctionDUexample()
sr     <- aspliSplicingReportExample()
is     <- aspliIntegratedSignalsExample()
}
