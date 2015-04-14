#' Spectral data for LED array from LUMITRONIX
#' 
#' Datasets containing the wavelengths and tabulated values spectral emittance
#' for different light emitting diodes (LEDs) from LUMITRONIX. A 39 W
#' (electrical power ) array of NICHIA natural white LEDs.
#' 
#' Absolute values are not meaningful as the measuring distances are variable,
#' and in most cases unknown.
#' 
#' The variables are as follows: 
#' \itemize{
#' \item w.length (nm) 
#' \item s.e.irrad  (W m-2 nm-1) 
#' \item s.q.irrad (mol m-2 s-1 nm-1) }
#' 
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array
#' spectroradiometer with a cosine corrected input optics from Bentham. With a
#' complex set of corrections and calibrated in an optical bench. Raw spectral
#' data processed with R package MayaCalc. Dataframes have comments with
#' additional information for each measurement. Measurements done by Pedro J.
#' Aphalo.
#' 
#' @docType data
#' @keywords datasets
#' @format A source.spct with 1425 observations (250 nm to 900 nm, at steps < 1
#'   nm)
#'   
#' @name LUMITRONIX.LEDs
#' @aliases LUMITRONIX_white.spct
NULL
