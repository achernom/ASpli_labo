# Tests de caracterizacion: fijan la salida actual del pipeline sobre los datos
# mini. Si un cambio los rompe, hay que decidir si es un bug nuevo o un cambio
# intencional (en ese caso, actualizar los valores de referencia y anotarlo en NEWS).

test_that("binGenome extrae las features esperadas", {
  p <- mini_pipeline()
  expect_s4_class( p$features, "ASpliFeatures" )
  expect_length( featuresg( p$features ), 10 )
  expect_length( featuresb( p$features ), 55 )
  expect_length( featuresj( p$features ), 23 )
  expect_length( transcriptExons( p$features ), 25 )
})

test_that("gbCounts devuelve matrices con las dimensiones esperadas", {
  p <- mini_pipeline()
  expect_s4_class( p$gbcounts, "ASpliCounts" )
  expect_equal( dim( countsg( p$gbcounts ) ), c( 10, 13 ) )
  expect_equal( dim( countsb( p$gbcounts ) ), c( 55, 15 ) )
  expect_equal( dim( countsj( p$gbcounts ) ), c( 23, 14 ) )
  expect_equal( nrow( rdsg( p$gbcounts ) ), 10 )
  expect_equal( nrow( rdsb( p$gbcounts ) ), 55 )
  expect_true( all( countsg( p$gbcounts )[ , grep( "^Sample", colnames( countsg( p$gbcounts ) ) ) ] >= 0 ) )
})

test_that("jCounts calcula los indices de inclusion", {
  p <- mini_pipeline()
  expect_s4_class( p$asd, "ASpliAS" )
  expect_equal( nrow( irPIR( p$asd ) ), 24 )
  expect_equal( nrow( esPSI( p$asd ) ), 3 )
  expect_equal( nrow( altPSI( p$asd ) ), 7 )
  expect_equal( nrow( junctionsPJU( p$asd ) ), 23 )
  # PIR/PSI son proporciones
  conds <- c( "control", "treatment" )
  for ( tab in list( altPSI( p$asd ), esPSI( p$asd ) ) ) {
    psi <- as.matrix( tab[ , conds ] )
    expect_true( all( psi >= 0 & psi <= 1, na.rm = TRUE ) )
  }
})

test_that("gbDUreport: expresion diferencial de genes y uso de bins", {
  p <- mini_pipeline()
  expect_s4_class( p$gb, "ASpliDU" )
  expect_equal( nrow( genesDE( p$gb ) ), 10 )
  expect_equal( nrow( binsDU( p$gb ) ), 14 )
  expect_true( all( c( "logFC", "pvalue", "gen.fdr" ) %in% colnames( genesDE( p$gb ) ) ) )

  top <- binsDU( p$gb )[ "GENE05:E002", ]
  expect_equal( top$event, "Alt5ss" )
  expect_equal( top$logFC, -1.0666, tolerance = 1e-3 )
  expect_lt( top$bin.fdr, 1e-10 )

  expect_equal( binsDU( p$gb )[ "GENE08:E002", "logFC" ], -0.6338, tolerance = 1e-3 )
  expect_equal( binsDU( p$gb )[ "GENE08:E004", "logFC" ],  0.6743, tolerance = 1e-3 )
})

test_that("jDUreport: junctions y clusters locale/anchor", {
  p <- mini_pipeline()
  expect_s4_class( p$jdur, "ASpliJDU" )
  expect_equal( dim( localej( p$jdur ) ),  c( 18, 10 ) )
  expect_equal( nrow( localec( p$jdur ) ),  7 )
  expect_equal( nrow( anchorj( p$jdur ) ),  9 )
  expect_equal( nrow( anchorc( p$jdur ) ),  9 )
  expect_equal( nrow( jir( p$jdur ) ),  9 )
  expect_equal( nrow( jes( p$jdur ) ),  2 )
  expect_equal( nrow( jalt( p$jdur ) ), 7 )
})

test_that("splicingReport integra bins y junctions", {
  p <- mini_pipeline()
  expect_s4_class( p$sr, "ASpliSplicingReport" )
  expect_equal( dim( binbased( p$sr ) ),    c( 20, 28 ) )
  expect_equal( dim( localebased( p$sr ) ), c( 23, 22 ) )
  expect_equal( dim( anchorbased( p$sr ) ), c( 12, 23 ) )
  expect_true( all( c( "bin", "bin.event", "bin.fdr", "cluster.fdr" ) %in%
                      colnames( binbased( p$sr ) ) ) )
})

test_that("integrateSignals resume las senales por region", {
  p <- mini_pipeline()
  expect_s4_class( p$is, "ASpliIntegratedSignals" )
  sig <- p$is@signals
  expect_equal( nrow( sig ), 8 )
  expect_true( "reference:4251-4350" %in% sig$region )
  expect_equal( sig$bin.event[ sig$region == "reference:4251-4350" ], "Alt5ss" )
  # las 5 primeras senales provienen de bins, las 3 restantes sólo de junctions
  expect_equal( sum( sig$b ), 5 )
  expect_equal( sum( sig$jl ), 3 )
})
