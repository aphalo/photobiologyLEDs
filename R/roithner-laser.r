#' Spectral data for LEDs supplied by Roithner Laser
#'
#' Datasets containing the wavelengths and tabulated values for spectral
#' emittance for different light emitting diodes (LEDs) and LED arrays supplied
#' by Roithner Laser (Austria). Data are normalized to one at the wavelength of
#' maximum emission.
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
#' roithner_laser
#' leds.mspct[roithner_laser]
#'
#' @note
#' Roithner LaserTechnik is a distributor and reseller of LEDs, LED arrays and
#' lasers. They have a very extensive catalogue covering almost wavelengths for
#' which LEDs are manufactured.
#' \url{http://www.roithner-laser.com/}
#'
"roithner_laser"
