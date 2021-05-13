#' Spectral data for LEDs of different colors
#' 
#' Names of datasets containing the wavelengths and tabulated values spectral emittance 
#' for the light emitting diodes (LEDs) from various suppliers. 
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @aliases 'leds by color' 
#' 
#' @examples 
#' uv_leds
#' blue_leds
#' green_leds
#' amber_leds
#' red_leds
#' white_leds
#' multichannel_leds
#' 
#' # select LEDs emitting in the amber, yellow, orange region
#' leds.mspct[amber_leds]
#' 
#' @seealso \code{\link{leds.mspct}}
#' 
"uv_leds"

#' @rdname uv_leds
"amber_leds"

#' @rdname uv_leds
"blue_leds"

#' @rdname uv_leds
"green_leds"

#' @rdname uv_leds
"red_leds"

#' @rdname uv_leds
"white_leds"

#' @rdname uv_leds
"multichannel_leds"

