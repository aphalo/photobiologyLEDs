#' Spectral data for LED array from LUMITRONIX
#' 
#' Dataset containing the wavelengths and tabulated values spectral emittance 
#' for a high power light emitting diode (LED) array from LUMITRONIX  based 
#' NICHIA's high efficiency natural white SMT LEDs. Specifications: LUMITRONIX
#' SmartArray Q36 LED-Module, 4247 lm, 4000K, 39W electrical
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
