## ------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ------------------------------------------------------------------------
library(photobiology)
library(photobiologyWavebands)
library(photobiologyLEDs)
library(ggplot2)
library(ggspectra)

## ------------------------------------------------------------------------
options(photobiology.plot.annotations =
          c("boxes", "labels", "colour.guide", "peaks", "title"))

## ------------------------------------------------------------------------
names(leds.mspct)

## ------------------------------------------------------------------------
plot(leds.mspct$TY_UV310nm)
plot(leds.mspct$UVMAX305)

## ------------------------------------------------------------------------
plot(leds.mspct$UVMAX340)
plot(leds.mspct$G_P30R140A1_XT)
plot(leds.mspct$XSL365)
plot(leds.mspct$XSL370)
plot(leds.mspct$UV395)

## ------------------------------------------------------------------------
plot(leds.mspct$LED405)
plot(leds.mspct$LED435_66_60)
plot(leds.mspct$HPR40E_48K30BG)
plot(leds.mspct$CB30)
plot(leds.mspct$HLMB_CB30)
plot(leds.mspct$HLMP_CB31)

## ------------------------------------------------------------------------
plot(leds.mspct$HLMP_CM30)
plot(leds.mspct$LY5436)
plot(leds.mspct$HLMP_DL32)

## ------------------------------------------------------------------------
plot(leds.mspct$HLMP_DJ32)
plot(leds.mspct$BS436)
plot(leds.mspct$B5_436_30D)
plot(leds.mspct$QDDH66002)
plot(leds.mspct$QDDH68002)
plot(leds.mspct$QDDH70002)
plot(leds.mspct$LED740_01AV)
plot(leds.mspct$QDDH73502)
plot(leds.mspct$FR_OLD)

## ------------------------------------------------------------------------
plot(leds.mspct$white)
plot(leds.mspct$Q36_4000K)

## ------------------------------------------------------------------------
plot(leds.mspct$NHXRGB090_R)
plot(leds.mspct$NHXRGB090_G)
plot(leds.mspct$NHXRGB090_B)

## ------------------------------------------------------------------------
ggplot(leds.mspct$NHXRGB090) + 
  aes(color = channel) +
  geom_line() +
  labs(x = "Wavelength (nm)", y = "Normalized spectral irradiance",
       title = "leds.mspct$NHXRGB090")

