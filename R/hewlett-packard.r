#' Spectral data for LEDs array supplied by Agilent/Hewlett Packard
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
#' hewlett_packard
#' leds.mspct[hewlett_packard]
#' 
#' @note
#' The division of Hewlett Packard which supplied these LEDs became part of
#' Agilent when this division spin-off the mother company. More recently
#' the electronic components division of Agilent became Avago Technologies
#' which still supplies some of these LEDs or similar improved types.
#' 
#' \url{http://www.avagotech.com/}
#' 
"hewlett_packard"