#' @details
#' This package contains emission spectra for different types of LEDs.
#'
#' The package contains one collection of spectra for different leds all of them
#' measured at room temperature and a series of vectors to be used as indexes to
#' extract different subsets of spectra. These spectral data are normalized to
#' spectral energy irradiance equal to one at the wavelength of maximum spectral
#' energy irradiance (strongest emission peak).
#'
#' @section Warning!:
#' None of the spectral data included in this package are based on supplier's
#' specifications and are only for information. The exact emission spectrum
#' depends to some extent on testing conditions, but more importantly among
#' individual LED dies. Spectral specifications are usually given by typical and
#' boundary values. Furthermore, most manufacturers classify LEDs of a given
#' type into "bins" with slightly different optical and electrical
#' characteristics. In other words, the data provided here are not a substitute
#' for actual measurements of radiation emission and spectrum of the LEDs
#' actually used in a given piece of scientific research. For less demanding
#' situations the data are in most cases reliable enough but perfect agreement
#' with measurements on other LEDs of the same exact type should not be
#' expected.
#'
#' @import photobiology
#'
#' @examples
#' library(photobiology)
#' library(photobiologyWavebands)
#' names(leds.mspct)
#' q_ratio(leds.mspct$white, Blue(), Red())
#' q_ratio(leds.mspct$Q36_4000K, Blue(), Red())
#'
"_PACKAGE"
