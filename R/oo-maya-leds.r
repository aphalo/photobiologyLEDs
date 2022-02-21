#' Spectra acquired with an Ocean Optics Maya2000 Pro spectrometer
#'
#' The collection of spectra \code{\link{leds.mspct}} contains spectra for some
#' COB arrays of light emitting diodes (LEDs) from multiple sources. Most of
#' them were measured with the same spectrometer. Data are normalized to one at
#' the wavelength of maximum emission. The character vector \code{oo_maya_leds}
#' contains the names of the spectra to facilitate their extraction from the
#' collection. The vector \code{oo_maya_leds} contains the names of
#' the spectra acquired with an Ocean Optics Maya2000
#' Pro spectrometer to facilitate their extraction from the collection..
#' 
#' @details Instrument used is an Ocean Optics Maya2000 Pro single-monochromator array
#'   spectroradiometer with a Bentham cosine corrected input optics. A complex
#'   set of corrections and calibration procedure used. Raw spectral data
#'   were acquired and/or processed with R package 'ooacquire'.
#'   
#' @note Ocean Optics is now named Ocean Insight.
#' 
#' @references \url{https://www.oceaninsight.com/}
#'
#' @docType data
#' @keywords datasets internal
#' @format A vector of character strings.
#'
#' @examples
#' oo_maya_leds
#'
#' @seealso \code{\link{leds.mspct}}
#' 
"oo_maya_leds"
