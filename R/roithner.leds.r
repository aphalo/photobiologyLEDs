#' Spectral data for LEDs supplied by Roithner Laser
#'
#' Datasets containing the wavelengths and tabulated values for spectral
#' emittance for different light emitting diodes (LEDs) and LED arrays supplied
#' by Roithener Laser (Austria). Absolute values are not meaningful as the
#' measuring distances and driving current are variable, and in most cases
#' unknown.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1) 
#' }
#' 
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#' spectroradiometer with a cosine corrected input optics. With a complex set of
#' corrections and calibrated in an optical bench. Raw spectral data processed
#' with R package MayaCalc. Dataframes have comments with additional information
#' for each measurement. Measurements done by Pedro J. Aphalo.
#' 
#' @docType data
#' @keywords datasets
#' @format A source.spct with 1425 observations (250 nm to 900 nm, at steps < 1
#'   nm)
#' @name roithner.LEDs
#' @aliases BS436.spct CB30.spct LED405.spct LED740.spct UV395.spct XSL365.spct
#' XSL370.spct XSL375.spct UVMAX305.spct UVMAX340.spct
NULL
