% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/led_uses.r
\docType{data}
\name{led_uses}
\alias{led_uses}
\alias{plant_grow_leds}
\alias{high_CRI_leds}
\title{Spectral data for LEDs for different uses}
\format{
A vector of character strings.

An object of class \code{character} of length 7.

An object of class \code{character} of length 9.
}
\usage{
led_uses

plant_grow_leds

high_CRI_leds
}
\description{
The collection of spectra \code{\link{leds.mspct}} contains spectra for light
emitting diodes (LEDs) designed for specific uses as well as for general 
illumination. The character
vectors described here contain the names of the spectra for LEDs sold for
specific uses to facilitate their extraction from the collection. One
additional vector, \code{led_use} contains the wording of uses as 
in the names of the spectra in the collection.
}
\details{
Most LEDs can be useful in different situations individually or in 
combination with other types. The lists are thus not exclusive but rather
indicate a typical use.
}
\section{Plant grow}{

The character vector \code{plant_grow_leds} contains the names of the spectra
to facilitate their extraction from the collection. This includes LEDs
designed to be the only light sources as well as LEDs designed to be used
together with other LEDs to assemble luminaires used for plant cultivation,
either as only light source or to supplement natural light.
}

\section{High color reproduction index}{

The character vector \code{high_CRI_leds} contains the names of the spectra
to facilitate their extraction from the collection. This includes white LEDs
with a high color reproduction index (CRI > 95) as computed from the actual
measured spectra. Nowadays some of these types of LEDs are not only
advertised as good from illumination in museums, exhibitions and as light
sources for video and photography, but also as less stressful to human vision
and in some cases as good for the entraining of the human circadian clock. In
practice this means an emission spectrum covering most of visible light with
only minor peaks and valleys.
}

\examples{
led_uses
plant_grow_leds

}
\seealso{
\code{\link{leds.mspct}}
}
\concept{uses}
\keyword{datasets}
