# Pipeline mini de ASpli sobre los datos de inst/extdata (10 genes artificiales,
# 6 BAMs, control vs treatment). Es el mismo ejemplo del quick start de la
# vineta. Se calcula una sola vez por sesion de tests (~1 min) y se reutiliza.

.pipeline_cache <- new.env( parent = emptyenv() )

quiet <- function( expr ) {
  out <- NULL
  utils::capture.output( out <- suppressWarnings( suppressMessages( expr ) ) )
  out
}

mini_pipeline <- function() {
  if ( !is.null( .pipeline_cache$p ) ) return( .pipeline_cache$p )

  gtf      <- aspliExampleGTF()
  genomeTxDb <- quiet( txdbmaker::makeTxDbFromGFF( gtf, format = "gtf" ) )
  features <- quiet( binGenome( genomeTxDb ) )

  BAMFiles <- aspliExampleBamList()
  targets  <- data.frame( row.names = paste0( 'Sample', 1:6 ),
                          bam = BAMFiles[1:6],
                          f1  = rep( c( 'control', 'treatment' ), each = 3 ),
                          stringsAsFactors = FALSE )
  mBAMs    <- data.frame( bam = sub( "_[012]", "", targets$bam[ c( 1, 4 ) ] ),
                          condition = c( "control", "treatment" ) )

  gbcounts <- quiet( gbCounts( features = features, targets = targets,
                               minReadLength = 100, maxISize = 50000 ) )
  asd      <- quiet( jCounts( counts = gbcounts, features = features,
                              minReadLength = 100 ) )
  gb       <- quiet( gbDUreport( gbcounts, contrast = c( -1, 1 ) ) )
  jdur     <- quiet( jDUreport( asd, contrast = c( -1, 1 ) ) )
  sr       <- quiet( splicingReport( gb, jdur, counts = gbcounts ) )
  is       <- quiet( integrateSignals( sr, asd ) )

  .pipeline_cache$p <- list( features = features, targets = targets,
                             mBAMs = mBAMs, gbcounts = gbcounts, asd = asd,
                             gb = gb, jdur = jdur, sr = sr, is = is )
  .pipeline_cache$p
}
