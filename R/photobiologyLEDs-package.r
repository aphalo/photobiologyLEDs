#' @details
#' This package contains emission spectra for different types of LEDs.
#' 
#' The package contains one collection of spectra for different leds all of them
#' measured at room temperature and a series of vectors to be used as indexes to
#' extract different subsets of spectra. These spectral data are normalized to
#' spectral energy irradiance equal to one at the wavelength of maximum spectral
#' energy irradiance (strongest emission peak).
#' 
#' 
#' @examples
#' library(photobiologyWavebands)
#' names(leds.mspct)
#' q_ratio(leds.mspct$white, Blue(), Red())
#' q_ratio(leds.mspct$Q36_4000K, Blue(), Red())
#' 
#' @import photobiology
#' 
"_PACKAGE"
