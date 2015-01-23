#' @title Spectral emission data for light emitting diodes (LEDs)
#' 
#' @description This package provides data for some commercialy available LEDs. The package is designed 
#' to complement package \code{photobiology}. The LEDs have been measured in total darkness. The LEds
#' have been bought over several years time period, and some may no longer be available. All data are
#' from individual pieces, and they do not necesarily represent the typical performance. It is always
#' best to measure any light source that you have actually used. These data sets are included mainly
#' for assessing their suitability when planning experiments, or for use in training, as examples
#' for exercises.
#' 
#' @docType package
#' @keywords misc
#' @name photobiologyLEDs-package
#' @author Pedro J. Aphalo
#' @details
#' \tabular{ll}{
#' Package: \tab photobiologyLEDs\cr
#' Type: \tab Package\cr
#' Version: \tab 0.2.1\cr
#' Date: \tab 2015-01-23\cr
#' License: \tab GPL (>= 3)\cr
#' URL: \tab \url{http://uv4growth.dyndns.org},\cr \tab \url{http://openinstruments.dyndns.org},\cr
#' \tab \url{https://bitbucket.org/aphalo/photobiology}\cr
#' BugReports: \tab \url{https://bitbucket.org/aphalo/photobiology}\cr
#' }
#' 
#' @references
#' Aphalo, P. J., Albert, A., Björn, L. O., McLeod, A. R., Robson, T. M., 
#' Rosenqvist, E. (Eds.). (2012). Beyond the Visible: A handbook of best 
#' practice in plant UV photobiology (1st ed., p. xxx + 174). 
#' Helsinki: University of Helsinki, Department of Biosciences, 
#' Division of Plant Biology. ISBN 978-952-10-8363-1 (PDF), 
#' 978-952-10-8362-4 (paperback). Open access PDF download available at 
#' \url{http://hdl.handle.net/10138/37558}
#' 
#' @examples
#' library(photobiologyWavebands)
#' q_ratio(white.spct, Blue(), Red())
#' q_irrad(white.spct, PAR()) * 1e6
#' plot(s.e.irrad~w.length, data=white.spct, main="White LED 5mm", type="l")
#' plot(s.e.irrad~w.length, data=white.spct + LED740.spct, main="White + far-red LEDs", type="l")
#' 
#' @import photobiology
#' 
NULL
