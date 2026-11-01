# ASpli (versión in-house `ASpli_labo`)

Paquete de R/Bioconductor para análisis de splicing alternativo a partir de RNA-seq
(binning del genoma, conteo de reads/junctions, DU de bins y junctions, reportes
integrados). El paquete se llama `ASpli` (campo `Package:` de DESCRIPTION) aunque el
directorio sea `ASpli_labo`. Mantenedor: Ariel Chernomoretz. Idioma de trabajo: español
(código, comentarios y docs del paquete en inglés).

## Remotes y flujo de trabajo git

- `origin`   = git@github.com:achernom/ASpli_labo.git (código + historia propia)
- `upstream` = git@git.bioconductor.org:packages/ASpli.git (Bioconductor; rama `devel`)

Ciclo normal (ver también `aspliLaboBioc.d` en el directorio padre):

1. `git checkout main && git pull origin main`
2. `git fetch upstream devel && git merge upstream/devel` (Bioc bumpea versiones por su cuenta)
3. Hacer los cambios (preferir una rama por tarea; mergear a `main` sólo con tests y check en verde)
4. Subir versión `x.y.z` -> `x.y.z+1` en DESCRIPTION. **`y` debe ser impar** (devel). Actualizar `Date:` y NEWS
5. `devtools::test()`, luego `R CMD build .` y `R CMD check --no-manual ASpli_*.tar.gz` (idealmente también `BiocCheck`)
6. `git push origin main`
7. `git push upstream main:devel`  <- **sólo lo hace el usuario, nunca Claude**

Reglas para Claude: no hacer push a ningún remote, no commitear sin pedido explícito,
no tocar `upstream`. Los commits de Claude llevan la línea Co-Authored-By estándar.

## Estructura

- `R/` (~10.500 líneas, S4). Archivos grandes: `plotBins_functions.R`, `ASpli_methods.R`
  (clases, genéricos y métodos `setGeneric`/`setMethod`), `splicingReport_functions.R`,
  `DUreport_functions.R`, `jDUreport_functions.R`
- `man/*.Rd` escritos a mano (no hay roxygen): si se cambia una firma, editar el `.Rd` a mano
- `NAMESPACE` a mano, con `export()` explícito (ya no hay `exportPattern`). Una función o genérico
  nuevo exportado hay que agregarlo a mano a `export()`/`exportMethods()`; los helpers internos empiezan con `.`
- `inst/extdata/`: 12 BAMs mini + `genes.mini.gtf` (10 genes artificiales). No modificar. `aspli_example_objects.rds` guarda los objetos del pipeline mini (`counts`, `du`, `as`, `jdu`, `sr`, `is`, con los BAM como basenames) y lo leen `aspliCountsExample()`, `aspliSplicingReportExample()`, etc. vía `.loadASpliExample()`. Si cambian las clases o el pipeline, regenerarlo a partir de `mini_pipeline()`
- `inst/doc/ASpli.Rnw`: viñeta (Sweave). Pipeline del quick start: `binGenome` -> `gbCounts`
  -> `jCounts` -> `gbDUreport` -> `jDUreport` -> `splicingReport` -> `integrateSignals`
  -> `exportIntegratedSignals`
- `NEWS`: una entrada por versión, formato `CHANGES IN VERSION x.y.z` (mantenerla coherente con DESCRIPTION)
- `aspli_test.R`: script de exploración personal (ignorado por git, no es parte del paquete)

## Comandos

```r
devtools::load_all()          # cargar el paquete
devtools::test()              # tests (≈1-2 min: el pipeline mini corre una sola vez)
devtools::test(filter = "export")
devtools::check()             # equivalente a R CMD check
```

```bash
R CMD build . && R CMD check --no-manual ASpli_*.tar.gz
Rscript -e 'BiocCheck::BiocCheck("ASpli_*.tar.gz")'   # si BiocCheck está instalado
```

## Tests

- `tests/testthat/helper-pipeline.R` define `mini_pipeline()`, que corre el quick start
  completo sobre `inst/extdata` y cachea los objetos (`features`, `gbcounts`, `asd`, `gb`,
  `jdur`, `sr`, `is`). Usarlo en lugar de recalcular.
- `test-pipeline-regression.R` son tests de **caracterización**: fijan dimensiones y algunos
  valores de la salida actual. Si fallan tras un cambio, decidir si es un bug o un cambio
  intencional (en ese caso actualizar los valores y anotarlo en NEWS). No "arreglar" el test
  para que pase sin entender por qué cambió el resultado.
- `test-export.R` cubre `exportIntegratedSignals`, `exportSplicingReports` y `writeSplicingReport`
  (usar `makeGraphs = FALSE` para no generar imágenes; escribir siempre en `withr::local_tempdir()`).
- Bug nuevo -> primero un test que lo reproduce, después el fix.

## Convenciones y cuidados

- Estilo del código existente: `function ( arg )` con espacios, `setMethod( f = ..., signature = ..., definition = ... )`. Imitar el estilo del archivo que se edita
- Ante cambios de firma de un método S4: actualizar `setGeneric`, `setMethod`, el `.Rd` y NEWS
- Cuidado con `readline()` en `exportIntegratedSignals` (pregunta interactivamente si hay
  muchos `mergedBams`; el umbral está hoy fijo en 6, marcado como provisorio en el commit `fcb2673`)
- `gbCounts`/`jCounts` usan procesamiento paralelo (`pbmcapply`); en tests no hace falta configurar nada
- Dependencias nuevas: agregarlas a `Imports` en DESCRIPTION y a NAMESPACE; sólo paquetes de CRAN/Bioconductor
- `Depends` incluye edgeR/limma/AnnotationDbi; evitar ampliarlo

## Estado conocido / pendientes

- Se eliminaron las funciones del flujo v1 (`DUreport`, `readCounts`, `AsDiscover`, `loadBAM`, `mergeBinDUAS`, `filterDU`, `plotGenomicRegions`, ...). `readCounts`, `AsDiscover` y `loadBAM` quedaron como helpers internos (`.readCounts`, `.AsDiscover`, `.loadBAM`). La guía de migración está en `man/ASpli-defunct.Rd`. No usar `.Deprecated()`/`.Defunct()` en `R/` (BiocCheck da WARNING)
- El umbral `nrow(mergedBams) > 6` en `exportIntegratedSignals` es provisorio
- `exportIntegratedSignals` trunca `output.dir` a 255 caracteres; `exportSplicingReports` no
- No hay cobertura de tests de las funciones de graficado (`plotBins_functions.R`, `plotGenomeRegions_functions.R`)
