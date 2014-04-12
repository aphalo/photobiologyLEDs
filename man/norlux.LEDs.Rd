\docType{data}
\name{norlux.LEDs}
\alias{Norlux_B.data}
\alias{Norlux_G.data}
\alias{Norlux_R.data}
\alias{norlux.LEDs}
\title{Spectral data for LEDs array supplied by Norlux}
\format{A data frame with 1637 observations (200 nm to 900 nm, at steps < 1 nm)}
\description{
Datasets containing the wavelengths and tabulated values
spectral emittance for different light emitting diodes
(LEDs) arrays from Norlux (USA). Absolute values are not
meaningful as the measuring distances are variable, and in
most cases unknown.
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

