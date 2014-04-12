#' Spectral data for LEDs supplied by Roithner Laser
#'
#' Datasets containing the wavelengths and
#' tabulated values for spectral emittance for different light emitting diodes (LEDs)
#' and LED arrays. Absolute values are
#' not meaningful as the measuring distances and driving current are variable, and in most cases unknown.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1) 
#' }
#' 
#' @note
#' Instrument used: Ocean Optics Maya2000 Pro single-monochromator array spectroradiometer with
#' a cosine corrected input optics. With a complex set of corrections and calibrated in an
#' optical bench. Raw spectral data processed with R package MayaCalc. Dataframes have
#' comments with additional information for each measurement.
#' Measurements done by Pedro J. Aphalo.
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 1425 observations (250 nm to 900 nm, at steps < 1 nm)
#' @name roithner.LEDs
#' @aliases 
#'  BS436.data CB30.data LED405.data LED740.data UV395.data XSL365.data XSL370.data XSL375.data
NULL

#' Spectral data for LEDs array supplied by Shezhen Weili Optical
#'
#' Datasets containing the wavelengths and
#' tabulated values spectral emittance for different light emitting diodes (LEDs) arrays
#' from Shezhen Weili Optical Ltd.
#' Absolute values are not meaningful as the measuring distances are variable, and in most cases unknown.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1) 
#' }
#' 
#' @note
#' Instrument used: Ocean Optics Maya2000 Pro single-monochromator array spectroradiometer with
#' a cosine corrected input optics. With a complex set of corrections and calibrated in an
#' optical bench. Raw spectral data processed with R package MayaCalc. Dataframes have
#' comments with additional information for each measurement.
#' Measurements done by Pedro J. Aphalo.
#'
#' @references
#' 
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 1425 observations (250 nm to 900 nm, at steps < 1 nm)
#' 
#' @name shezhen.weili.LEDs
#' @aliases 
#'  SW_UVA365.data
NULL

#' Spectral data for LEDs array supplied by Norlux
#'
#' Datasets containing the wavelengths and
#' tabulated values spectral emittance for different light emitting diodes (LEDs) arrays
#' from Shezhen Weili Optical Ltd.
#' Absolute values are not meaningful as the measuring distances are variable, and in most cases unknown.
#' 
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#'   \item s.q.irrad (mol m-2 s-1 nm-1) 
#' }
#' 
#' @note
#' Instrument used: Ocean Optics Maya2000 Pro single-monochromator array spectroradiometer with
#' a cosine corrected input optics. With a complex set of corrections and calibrated in an
#' optical bench. Raw spectral data processed with R package MayaCalc. Dataframes have
#' comments with additional information for each measurement.
#' Measurements done by Pedro J. Aphalo.
#'
#' @references
#' 
#' 
#' @docType data
#' @keywords datasets
#' @format A data frame with 1637 observations (200 nm to 900 nm, at steps < 1 nm)
#' 
#' @name norlux.LEDs
#' @aliases 
#' Norlux_R.data Norlux_G.data Norlux_B.data
NULL
