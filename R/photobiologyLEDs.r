#' @details
#' Data for emission spectra of different types of LEDs and LED arrays.
#'
#' The package contains one collection of spectra for different LEDs available
#' as electronic components requiring separate electronic driver modules or
#' circuits for their use. Data for LED bulbs are included in package 
#' \code{\link[photobiologyLamps]{photobiologyLamps-package}}. 
#' 
#' In addition to the spectra the package provides character vectors of names
#' to be used as indexes to subset groups of spectra. In all cases spectral
#' data are normalized to spectral energy irradiance equal to one at the
#' wavelength of maximum spectral energy irradiance (strongest emission peak).
#' In most cases the multiplier used for normalization can be obtained by
#' quering the object. However, this is useful only in those cases where the
#' distance from source to entrance optics of the spectrometer and alignment 
#' were recorded. 
#'
#' All LEDs have been measured at room temperature mounted on passive heatsinks
#' and driven at or below their maximum current rating. High precision power
#' supplies or LED drivers were used to drive them.
#' 
#' The number of different LED types available is enormous, and this collection
#' attempts only to provide examples for some of them. Which types are included
#' is the result of what has been bought for specific uses at my lab or out of
#' curiosity since 1995 to the present. Which brands and LED types are included,
#' should not be interpreted as endorsement of them.
#' 
#' @references
#' Aphalo, Pedro J. (2015) The r4photobiology suite. UV4Plants Bulletin, 2015:1,
#' 21-29. \doi{10.19232/uv4pb.2015.1.14}.
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
#' library(ggspectra)
#' 
#' names(leds.mspct)
#' 
#' led_brands
#' 
#' white_leds
#' 
#' q_ratio(leds.mspct$Nichia_NS6L183AT_H1_sw, Blue(), Red())
#' 
#' autoplot(leds.mspct$Nichia_NS6L183AT_H1_sw)
#' 
#' \dontrun{
#' autoplot(leds.mspct$Nichia_NS6L183AT_H1_sw, unit.out = "photon")
#' }
#' 
#' \dontrun{
#' autoplot(leds.mspct$Nichia_NS6L183AT_H1_sw, 
#'      range = VIS(), 
#'      w.band = VIS_bands(),
#'      span = 101)
#' }
#' 
#' is_normalized(leds.mspct$Nichia_NS6L183AT_H1_sw)
#' 
#' cat(comment(leds.mspct$Nichia_NS6L183AT_H1_sw))
#' 
#' when_measured(leds.mspct$Nichia_NS6L183AT_H1_sw)
#' 
#' how_measured(leds.mspct$Nichia_NS6L183AT_H1_sw)
#' 
"_PACKAGE"
