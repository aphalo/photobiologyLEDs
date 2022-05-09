#' Spectral data for LEDs for different uses
#' 
#' The collection of spectra \code{\link{leds.mspct}} contains spectra for light
#' emitting diodes (LEDs) designed for specific uses as well as for general 
#' illumination. The character
#' vectors described here contain the names of the spectra for LEDs sold for
#' specific uses to facilitate their extraction from the collection. One
#' additional vector, \code{led_use} contains the wording of uses as 
#' in the names of the spectra in the collection.
#' 
#' Most LEDs can be useful in different situations individually or in 
#' combination with other types. The lists are thus not exclusive but rather
#' indicate a typical use.
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @examples
#' led_uses
#' plant_grow_leds
#' 
#' @seealso \code{\link{leds.mspct}}
#' 
#' @family uses
#' 
"led_uses"

#' @rdname led_uses
#' 
#' @section Plant grow:
#' The character vector \code{plant_grow_leds} contains the names of the spectra
#' to facilitate their extraction from the collection. This includes LEDs
#' designed to be the only light sources as well as LEDs designed to be used
#' together with other LEDs to assemble luminaires used for plant cultivation,
#' either as only light source or to supplement natural light.
#' 
"plant_grow_leds"

#' @rdname led_uses
#' 
#' @section High color reproduction index:
#' The character vector \code{high_CRI_leds} contains the names of the spectra
#' to facilitate their extraction from the collection. This includes white LEDs
#' with a high color reproduction index (CRI). Nowadays these types of LEDs are
#' not only advertised as good from illumination in museums, exhibitions and as
#' light sources for video and photography, but also as less stressful to human
#' vision and in some cases as good for the entraining of the human circadian
#' clock. In practice this means an emission spectrum covering most of visible
#' light with only minor peaks and valleys.
#' 
"high_CRI_leds"

