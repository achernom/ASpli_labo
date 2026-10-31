\name{write-methods}

\alias{writeRds-methods}
\alias{writeCounts-methods}
\alias{writeAS-methods}
\alias{writeDU-methods}
\alias{writeJDU-methods}
\alias{writeSplicingReport-methods}
\alias{writeAll,ANY-method}

\title{ Write results }

\description{ Export tab delimited files in structured output}

\details{ Tab delimited files are exported in a tidy manner into output folder }

\value{Called for its side effect of writing tab delimited files into \code{output.dir}; the return value is not meant to be used.}

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\seealso{ \code{ \link{jCounts}, \link{binGenome},\link{DUreport.norm}, \link{DUreport.offset} } }

\examples{
# Write an (empty) ASpliCounts object into a temporary folder
counts <- new( 'ASpliCounts' )
outdir <- file.path( tempdir(), "counts" )
writeCounts( counts, output.dir = outdir )
list.files( outdir )
}
