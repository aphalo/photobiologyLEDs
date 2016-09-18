#' Spectral data for LED array from LUMITRONIX
#' 
#' Dataset containing the wavelengths and tabulated values spectral emittance 
#' for a high power light emitting diode (LED) array from LUMITRONIX  based 
#' NICHIA's high efficiency natural white SMT LEDs. Specifications: LUMITRONIX 
#' SmartArray Q36 LED-Module, 4247 lm, 4000K, 39W electrical. Data are
#' normalized to one at the wavelength of maximum emission.
#' 
#' The variables are as follows: 
#' \itemize{
#' \item w.length (nm) 
#' \item s.e.irrad  (W m-2 nm-1) 
#' }
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#'   
#' @examples 
#' lumitronix
#' leds.mspct[lumitronix]
#' 
#' @note
#' Lumitronix is a supplier of LED arrays, and a distributor of LEDs.
#' \url{http://www.leds.de/}
#' 
"lumitronix"
