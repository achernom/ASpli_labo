\name{plotBins}

\alias{plotBins}

\title{
  Draw plots of gene counts, bin counts, PSI/PIR value, inclusion and exclusion
  junctions for selected bins. 
}

\description{ Creates a plot with gene counts, bin counts, PSI/PIR value, 
  inclusion and exclusion junctions for selected bins and conditions. }

\usage{
  plotBins( counts, 
            as,
            bin, 
            factorsAndValues, 
            targets,
            main            = NULL,
            colors          = c( '#2F7955', '#79552F', '#465579', 
                                 '#A04935', '#752020', '#A07C35') ,
            panelTitleColors = '#000000',
            panelTitleCex   = 1,
            innerMargins    = c( 2.1, 3.1, 1.1, 1.1 ),
            outerMargins    = c( 0, 0, 2.4, 0 ), 
            useBarplots     = NULL,
            barWidth        = 0.9,
            barSpacer       = 0.4,
            las.x           = 2,
            useHCColors     = FALSE,
            legendAtSide    = TRUE,
            outfolder       = NULL,
            outfileType     = c( 'png', 'bmp', 'jpeg', 'tiff', 'pdf')[1],
            deviceOpt       = NULL ) 
}

\arguments{
  
  \item{counts}{ An object of class \code{ASpliCounts} }
  
  \item{as}{ An object of class \code{ASpliAS} }
  
  \item{bin}{ A character vector with the names of the bins to be plotted. }
  
  \item{factorsAndValues}{ A list containing the factor and the values for each
    factor to be plotted. The order of the factors will modify how the 
    conditions are grouped in the plot. \code{factorsAndValues} must be a named
    list, where the name of each element is a factor and the list element itself
    is a character vector of the values of this factor in the order to be 
    plotted. See examples for more details.
  }
    
  \item{targets}{ A data frame containing sample, bam files and experimental 
    factor columns 
  }
  
  \item{main}{ Main title of the plot. If \code{NULL} the bin name is used as
    title.
  }
  
  \item{colors}{ A vector of character colors for lines and bar plots. }
  
  \item{panelTitleColors}{ A vector of character colors for the titles of each
    plot panel.
  }
  
  \item{panelTitleCex}{ Character size expansion for panel titles.}
  
  \item{innerMargins}{ A numerical vector of the form c(bottom, left, top, 
    right) which gives the size of each plot panel margins. Defaults to c( 2.1, 
    3.1, 1.1, 1.1 ) }
  
  \item{outerMargins}{ A numerical vector of the form c(bottom, left, top, 
    right) which gives the size of margins. Defaults to c( 0, 0, 2.4, 0 ) }

  \item{useBarplots}{ A logical value that indicates the type of plot to be 
    used. If \code{TRUE} bar plots are used, if \code{FALSE} lines are used. If
    \code{NULL} the type is bar plot if there just two conditions and lines if 
    there are more than two conditions.}
  
  \item{barWidth}{ The width of the bars in bar plots. \code{barWidth} must be 
    in (0,1] range. Default value is 0.9.}
  
  \item{barSpacer}{ Fraction of \code{barwidth} used as spacer between bar plot 
    groups. Defaule value is 0.4.}
  
  \item{las.x}{ Text orientation of x-axis labels. }
  
  \item{useHCColors}{ A logical value. If \code{TRUE} \code{panelTitleColors}} 
    are not used, instead panel title are automatically chosen to have high 
    contrast against \code{colors}.

  \item{legendAtSide}{ A logical value that forces panel title to be shown on 
    the y-axis, instead of over the plot. }

  \item{outfolder}{ Path to output folder to write plot images. Is \code{NULL},
    plot are rendered on the default device }
    
  \item{outfileType}{ File format of the output files used if \code{outfolder} 
    is not \code{NULL}. Accepted values are 'png', 'jpeg', 'tiff', 'pdf'. Each
    value selects the graphic device of the same name. The name of the image
    file is the name of bin with the corresponding extension given by the chosen
    type }
  
  \item{deviceOpt}{A list of named options to be passed to the graphic device 
    selected in \code{outfileType}}
    
}

\value{
Returns a png for each selected bin }

\author{ Estefania Mancini, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, Ariel Chernomoretz  }

\seealso{
  \code{\link{exportSplicingReports}}, \code{\link{exportIntegratedSignals}}
}

\examples{
  # Example ASpliCounts and ASpliAS objects, obtained running the workflow on
  # the example data (control versus treatment, factor f1).
  counts  <- aspliCountsExample()
  as      <- aspliASexample()
  targets <- targets( counts )[ , c( "bam", "f1" ) ]

  # Plot the data of a bin, one png file per bin written into a temporary folder.
  outfolder <- file.path( tempdir(), "plotBins" )
  dir.create( outfolder )
  plotBins( counts, as, 'GENE03:E002', 
    factorsAndValues = list( f1 = c( 'control', 'treatment' ) ),
    targets = targets,
    las.x = 1,
    legendAtSide = TRUE,
    useHCColors = TRUE,
    barWidth = 0.95,
    innerMargins = c( 2.1, 4.1, 1.1, 1.1 ),
    outfolder = outfolder )
  list.files( outfolder )
}
