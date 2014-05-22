#' Spectral data for LEDs array of unknwon manufacturer
#'
#' Datasets containing the wavelengths and
#' tabulated values spectral emittance for different light emitting diodes (LEDs)
#' from without type specifications. Bought from shops like Chlass Ohlson or hobby targetted
#' electronic suppliers.
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
#' @docType data
#' @keywords datasets
#' @format A data table with 1425 observations (250 nm to 900 nm, at steps < 1 nm)
#' 
#' @name generic.LEDs
#' @aliases 
#'  white.dt
NULL
