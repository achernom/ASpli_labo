# Los objetos de ejemplo (inst/extdata/aspli_example_objects.rds) se obtuvieron
# corriendo el pipeline sobre los datos de inst/extdata. Se verifica que cada
# funcion devuelva la clase esperada y que el pipeline siga produciendo
# objetos compatibles con ellos.

test_that("las funciones de ejemplo devuelven objetos de la clase esperada", {
  expect_s4_class( aspliCountsExample(),            "ASpliCounts" )
  expect_s4_class( aspliASexample(),                "ASpliAS" )
  expect_s4_class( aspliDUexample1(),               "ASpliDU" )
  expect_s4_class( aspliDUexample2(),               "ASpliDU" )
  expect_s4_class( aspliJunctionDUexample(),        "ASpliJDU" )
  expect_s4_class( aspliSplicingReportExample(),    "ASpliSplicingReport" )
  expect_s4_class( aspliIntegratedSignalsExample(), "ASpliIntegratedSignals" )
})

test_that("los targets de los ejemplos apuntan a BAMs existentes del paquete", {
  for ( obj in list( aspliCountsExample(), aspliASexample() ) ) {
    bams <- obj@targets$bam
    expect_length( bams, 6 )
    expect_true( all( file.exists( bams ) ) )
  }
  # en el .rds los paths se guardan sin directorio (se completan al cargar)
  raw <- readRDS( system.file( "extdata", "aspli_example_objects.rds", package = "ASpli" ) )
  expect_equal( raw$counts@targets$bam, basename( raw$counts@targets$bam ) )
  expect_equal( raw$as@targets$bam,     basename( raw$as@targets$bam ) )
})

test_that("los objetos de ejemplo coinciden con el pipeline mini", {
  p <- mini_pipeline()
  expect_equal( dim( countsg( aspliCountsExample() ) ), dim( countsg( p$gbcounts ) ) )
  expect_equal( dim( countsb( aspliCountsExample() ) ), dim( countsb( p$gbcounts ) ) )
  expect_equal( dim( joint( aspliASexample() ) ),       dim( joint( p$asd ) ) )
  expect_equal( dim( genesDE( aspliDUexample1() ) ),    dim( genesDE( p$gb ) ) )
})

test_that("los ejemplos de DUreport.norm/offset y rds funcionan sobre el objeto de ejemplo", {
  counts <- aspliCountsExample()
  expect_s4_class( suppressMessages( DUreport.norm( counts, contrast = c( -1, 1 ) ) ), "ASpliDU" )
  expect_s4_class( suppressMessages( DUreport.offset( counts, contrast = c( -1, 1 ) ) ), "ASpliDU" )
  expect_s4_class( rds( counts, counts@targets[ , c( "bam", "f1" ) ] ), "ASpliCounts" )
})
