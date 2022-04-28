#' @title Constant-current dimming of LEDs
#'
#' @description A collection of emission spectra of a light-emitting-diode
#'   driven at different constant current.
#'
#' @details The \code{"COB_dimming.mspct"} object contains \code{"source_spct"}
#'   objects with spectral irradiance data with the same Optisolis COB LED from
#'   Nichia driven at different values of constant current. Distance from LED to
#'   cosine diffuser was 159 mm; a reflector was attached to the LED to make the
#'   light beam narrower. Spectra are not normalized. The position for
#'   the LED with respect to the entrace optics did not vary among measurements.
#'   
#'   The COB LED used is the chip-on-board (COB) Optisolis type 
#'   NFCWL036B-V3-Rfcb0 from Nichia with CRI > 95. Nominal electrical power of
#'   10.3 W at nominal current of 270 mA. So, two spectra are for the COB 
#'   over-driven, which is possible with enough cooling, but not recommended.
#'   
#'   The spectral data are not expressed at constant wavelength intervals. Not
#'   only the intervals vary in the raw data from the array spectrometer, but in
#'   addition function \code{\link[photobiology]{thin_wl}} has been applied to
#'   reduce the storage space needed. In brief the wavelength interval has been
#'   increased as much as possible in those regions of the spectrum that lack
#'   detailed features (such as linear slopes and wavelength regions with zero
#'   light emission).
#'
#' @note Please see the metadata in each spectrum. These metadata are
#' stored as attributes of the individual \code{source_spct} objects and can accessed with functions 
#' \code{\link{comment}},
#' \code{\link[photobiology]{getWhatMeasured}},
#' \code{\link[photobiology]{getWhenMeasured}}, 
#' \code{\link[photobiology]{getHowMeasured}}, 
#' \code{\link[photobiology]{getInstrDesc}} and
#' \code{\link[photobiology]{getInstrSettings}}.
#' See also the \code{\link{comment}} attribute of the \code{COB_dimming.mspct} 
#' object.
#'
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing 8
#'   \code{"source_spct"} objects.
#' 
#' In each of the member spectra, the variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#' }
#' 
#' @references \url{https://www.ledil.com/} \url{https://www.nichia.co.jp/en/}
#'
#' @examples
#' library(photobiology)
#' 
#' names(COB_dimming.mspct)
#' 
#' # photon irradiance in umol m-2 s-1, and relative to maximum
#' irrads <- q_irrad(COB_dimming.mspct, scale.factor = 1e6)
#' irrads$Q_Total_rel <- irrads$Q_Total / max(irrads$Q_Total)
#' irrads
#' 
"COB_dimming.mspct"
