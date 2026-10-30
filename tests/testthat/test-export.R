test_that("exportIntegratedSignals usa analysis_name como subdirectorio", {
  p <- mini_pipeline()
  out <- withr::local_tempdir()

  quiet( exportIntegratedSignals( p$is, sr = p$sr, output.dir = out,
                                  counts = p$gbcounts, features = p$features,
                                  asd = p$asd, mergedBams = p$mBAMs,
                                  makeGraphs = FALSE, analysis_name = "myrun" ) )

  expect_true( dir.exists( file.path( out, "myrun" ) ) )
  expect_true( file.exists( file.path( out, "myrun", "integratedSignals.html" ) ) )
})

test_that("exportIntegratedSignals sin analysis_name usa el nombre del contraste", {
  p <- mini_pipeline()
  out <- withr::local_tempdir()

  quiet( exportIntegratedSignals( p$is, sr = p$sr, output.dir = paste0( out, "/" ),
                                  counts = p$gbcounts, features = p$features,
                                  asd = p$asd, mergedBams = p$mBAMs,
                                  makeGraphs = FALSE ) )

  contrast_dir <- paste0( names( p$sr@contrast )[ p$sr@contrast != 0 ], collapse = "-" )
  expect_true( dir.exists( file.path( out, contrast_dir ) ) )
})

test_that("exportSplicingReports respeta analysis_name", {
  p <- mini_pipeline()
  out <- withr::local_tempdir()
  quiet( exportSplicingReports( p$sr, output.dir = out, analysis_name = "sr1" ) )
  expect_true( dir.exists( file.path( out, "sr1" ) ) )
})

test_that("writeSplicingReport escribe las tres tablas", {
  p <- mini_pipeline()
  out <- withr::local_tempdir()
  quiet( writeSplicingReport( p$sr, output.dir = out ) )
  expect_setequal( list.files( out ),
                   c( "anchorbased.txt", "binbased.txt", "localebased.txt" ) )
})
