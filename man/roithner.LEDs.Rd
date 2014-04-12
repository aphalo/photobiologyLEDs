\docType{data}
\name{roithner.LEDs}
\alias{BS436.data}
\alias{CB30.data}
\alias{LED405.data}
\alias{LED740.data}
\alias{UV395.data}
\alias{XSL365.data}
\alias{XSL370.data}
\alias{XSL375.data}
\alias{roithner.LEDs}
\title{Spectral data for LEDs supplied by Roithner Laser}
\format{A data frame with 1425 observations (250 nm to 900 nm, at steps < 1 nm)}
\description{
Datasets containing the wavelengths and tabulated values
for spectral emittance for different light emitting diodes
(LEDs) and LED arrays. Absolute values are not meaningful
as the measuring distances and driving current are
variable, and in most cases unknown.
}
\details{
The variables are as follows: \itemize{ \item w.length (nm)
\item s.e.irrad (W m-2 nm-1) \item s.q.irrad (mol m-2 s-1
nm-1) }
}
\note{
Instrument used: Ocean Optics Maya2000 Pro
single-monochromator array spectroradiometer with a cosine
corrected input optics. With a complex set of corrections
and calibrated in an optical bench. Raw spectral data
processed with R package MayaCalc. Dataframes have comments
with additional information for each measurement.
Measurements done by Pedro J. Aphalo.
}
\keyword{datasets}

