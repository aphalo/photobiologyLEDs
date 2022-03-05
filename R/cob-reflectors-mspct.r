#' @title LEDs with reflectors
#'
#' @description A collection of emission spectra of a light-emitting-diode
#'   when combined with different reflectors.
#'
#' @details The \code{"COB_reflectors.mspct"} object contains \code{"source_spct"}
#'   objects with spectral irradiance data.
#'   Distance from LED to cosine diffuser was 159 mm. Spectra are not normalized.
#'   It needs to be taken into account
#'   than even in these cases measurements have not been done in an optical 
#'   bench, so values of spectral irradiance are subject to small errors due to
#'   possible misalignment.
#'   
#'   The spectral data are not expressed at constant wavelength intervals. Not
#'   only the intervals vary in the raw data from the array spectrometer, but in
#'   addition function \code{\link[photobiology]{thin_wl}} has been applied to
#'   reduce the storage space needed. In brief the wavelength interval has been
#'   increased as much as possible in those regions of the spectrum that lack
#'   detailed features (such as linear slopes and wavelength regions with zero
#'   light emission).
#'
#' @note Please see the metadata in each spectrum. The metadata is
#' stored in attributes and can accessed with functions 
#' \code{\link[photobiology]{getWhatMeasured}},
#' \code{\link[photobiology]{getWhenMeasured}}, 
#' \code{\link[photobiology]{getInstrDesc}} and
#' \code{\link[photobiology]{getInstrSettings}}.
#'
#' @docType data
#' @keywords datasets
#' @format A \code{"source_mspct"} object containing 51
#'   \code{"source_spct"} objects.
#' 
#' In each of the member spectra, the variables are as follows:
#' \itemize{
#'   \item w.length (nm)  
#'   \item s.e.irrad (W m-2 nm-1)
#' }
#'
#' @examples
#' library(photobiology)
#' library(ggspectra)
#' 
#' names(COB_reflectors.mspct)
#' 
#' irrads <- q_irrad(COB_reflectors.mspct, scale.factor = 1e6)
#' irrads$Q_Total_rel <- irrads$Q_Total / min(irrads$Q_Total)
#' irrads
#' 
#' autoplot(COB_reflectors.mspct)

"COB_reflectors.mspct"
