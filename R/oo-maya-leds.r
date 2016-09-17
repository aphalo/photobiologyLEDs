#' @title Spectra acquired with Ocean Optics Maya2000 Pro
#'
#' @description Dataset containing the wavelengths and tabulated values spectral
#'   emittance for LEDs. Data for both low power single-die devices and high
#'   power LEDs arrays are included. The data are normalized to the peak of
#'   maximum spectral energy irardiance.
#'
#' @details \code{oo_maya_leds} is a character vector with indexes to members of 
#'   \code{\link{leds.mspct}}.
#'
#' The variables in each member spectrum are as follows: \itemize{ \item
#' w.length (nm) \item s.e.irrad (relative energy based units) }
#'
#' @note Instrument used: Ocean Optics Maya2000 Pro single-monochromator array 
#'   spectroradiometer with a Bentham cosine corrected input optics. A complex 
#'   set of corrections and calibration procedure used. Raw spectral data 
#'   processed with R packages 'MayaCalc' or 'ooacquire'. The \code{source_spct}
#'   object contains a comment with additional information on the measurement
#'   and data processing. Measurements done by Pedro J. Aphalo.
#'
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#'
#' @examples
#' leds.mspct[oo_maya_leds]
#' leds.mspct[["white"]]
#' leds.mspct$white
#'
"oo_maya_leds"
