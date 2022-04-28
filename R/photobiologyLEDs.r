#' @details
#' Data for emission spectra of different types of LEDs and LED arrays.
#'
#' The package contains one main collection of spectra for different LEDs
#' available as electronic components through hole (th), surface mount devices
#' (SMD) and chip-on-board (COB) packages with no built-in driver circuitry to
#' limit the current, \code{\link{leds.mspct}}. Data for LED bulbs and LED
#' luminaires/lamps are included in package
#' \code{\link[photobiologyLamps]{photobiologyLamps-package}}. Two smaller
#' collections, provide spectra for a COB LED driven with varying current or
#' constant-current (CC) dimming, \code{\link{COB_dimming.mspct}}, and at fixed
#' current but in conbination with different reflectors,
#' \code{\link{COB_reflectors.mspct}}.
#' 
#' In addition to the spectra the package provides character vectors of names to
#' be used as indexes to subset groups of spectra from \code{leds.mspct}. In all
#' cases spectral data are normalized to spectral energy irradiance equal to one
#' at the wavelength of maximum spectral energy irradiance (strongest emission
#' peak). In most cases the multiplier used for normalization can be obtained by
#' quering the object. However, this is useful only in those cases where the
#' distance from source to entrance optics of the spectrometer and alignment
#' were recorded.
#'
#' All LEDs have been measured at room temperature mounted on passive heatsinks
#' and usually driven near their maximum current rating. Precision power
#' supplies or LED drivers were used to drive them at constant current.
#' 
#' The number of different LED types available is enormous, and this collection
#' attempts only to provide examples for some of them. Which types are included
#' is the result of what has been bought for specific uses at my lab or out of
#' curiosity since 1995 to the present. Which brands and LED types are included,
#' should not be interpreted as endorsement of any supplier.
#' 
#' @references
#' Aphalo, Pedro J. (2015) The r4photobiology suite. UV4Plants Bulletin, 2015:1,
#' 21-29. \doi{10.19232/uv4pb.2015.1.14}.
#'
#' @note Some of the LEDs were bought from AliExpress sellers while others were
#'   sourced from major electronic component distributors like Farnell, RS
#'   components, Digi-Key, Mouser, TME, Roithner-Lasertechnik, and Lumitronix/LedRise. In the case of some AliExpress
#'   sellers or smaller webstores sometimes the exact type specifications are
#'   not available. Some of the Chinese sellers package the LEDs they sell using
#'   LED dies (= chips) from major brands and provide this brand name. In very
#'   recent times this seems to have expanded in some cases to include high
#'   density COB packages. Be aware that in recent times the word COB is being
#'   used by AliExpress, Bangood and eBay sellers to describe old-style arrays
#'   where the LED chips are not directly attached to a board to maximize 
#'   thermal conductance. In this package, we use COB in its more restricted
#'   meaning and name other packages simply LED array.
#' 
#' @section Warning!: None of the spectral data included in this package are
#'   based on supplier's specifications and are only for information. The exact
#'   emission spectrum of a LED depends to some extent on testing conditions,
#'   but more importantly among individual LED dies. Spectral specifications are
#'   usually given by typical and boundary values. Furthermore, most
#'   manufacturers classify LEDs of a given type into "bins" with slightly
#'   different colour and electrical characteristics. In addition, the
#'   performance of LEDs deteriorates with use, with light output decreasing
#'   faster if driven with high current or if they overheat as a consequence of
#'   insufficient cooled. \strong{In other words, the data provided here are not
#'   a substitute for actual measurements of radiation emission and spectrum of
#'   the LEDs actually used in a given piece of scientific research or other
#'   important work.} For less demanding situations, such as planning of
#'   experiemnts or testing the sanity of independent measurements, the data are
#'   in most cases reliable enough but perfect agreement with measurements on
#'   other LEDs of the same exact type should not be expected.
#' 
#' @import photobiology
#'
#' @examples
#' library(photobiology)
#' 
#' names(leds.mspct)
#' 
#' led_brands
#' 
#' white_leds
#' 
#' qe_ratio(leds.mspct$Nichia_NS6L183AT_H1_sw) * 1e6 # umol / J
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
