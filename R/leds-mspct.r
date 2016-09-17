#' @title Spectral irradiance for diverse LEDs
#'   
#' @description A collection of emission spectra of light-emitting-diodes
#'   from different suppliers.
#'   
#' @details The \code{"source_mspct"} object contains \code{"source_spct"} 
#'   objects with spectral emission data.
#'   
#'   The variables in each member spectrum are as follows: \itemize{ \item 
#'   w.length (nm) \item s.e.irrad (relative energy based units) }
#'   
#' @note Please see the help corresponding to each supplier for detials.
#'   
#' @seealso \code{\link{oo_maya_leds}}
#'   
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing several
#'   \code{"source_spct"}.
#'   
#' @examples
#' names(leds.mspct)
#' leds.mspct$UV395
#' 
"leds.mspct"
