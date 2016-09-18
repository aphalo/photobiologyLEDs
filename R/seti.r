#' Spectral data for LEDs array supplied by SETi
#'
#' Datasets containing the wavelengths and tabulated values spectral emittance
#' for the NHXRGB0905005 light emitting diodes (LEDs) arrays from Osram.
#' Data are normalized to one at the wavelength of maximum emission.
#'
#' The variables are as follows:
#' \itemize{
#'   \item w.length (nm)
#'   \item s.e.irrad (W m-2 nm-1)
#' }
#'
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#'
#' @examples
#' seti
#' leds.mspct[seti]
#'
#' @note
#' SETi (Sensor Electronic Technologies) is a supplier of high power ultraviolet
#' LEDs emitting in the UVC, UVB and UVA regions of the spectrum. Many of these
#' LEDs are also sold under different type denominations by Roithner
#' LaserTechnik.
#' \url{http://www.s-et.com/}
#'
"seti"
