## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(fig.width=8, fig.height=4)

## ----message=FALSE------------------------------------------------------------
library(photobiology)
library(photobiologyLEDs)
# Are the packages used in examples installed?
eval_bands <- requireNamespace("photobiologyWavebands", quietly = TRUE)
if (eval_bands) library(photobiologyWavebands)
eval_plots <- eval_bands && requireNamespace("ggspectra", quietly = TRUE)
if (eval_plots) library(ggspectra)

## -----------------------------------------------------------------------------
blue_leds

## -----------------------------------------------------------------------------
LedEngin_leds

## -----------------------------------------------------------------------------
names(COB_reflectors.mspct)

## -----------------------------------------------------------------------------
names(COB_dimming.mspct)

## -----------------------------------------------------------------------------
names(leds.mspct)

## -----------------------------------------------------------------------------
leds.mspct$Roithner_UV395

## -----------------------------------------------------------------------------
leds.mspct[["Roithner_UV395"]]

## -----------------------------------------------------------------------------
leds.mspct["Roithner_UV395"]

## -----------------------------------------------------------------------------
leds.mspct[Norlux_leds]

## -----------------------------------------------------------------------------
leds.mspct[grep("QDDH", names(leds.mspct))]

## -----------------------------------------------------------------------------
leds.mspct$LedEngin_LZ1_10R302_740nm

## -----------------------------------------------------------------------------
cat(getWhatMeasured(leds.mspct$LedEngin_LZ1_10R302_740nm))

## -----------------------------------------------------------------------------
getWhenMeasured(leds.mspct$LedEngin_LZ1_10R302_740nm)

## -----------------------------------------------------------------------------
getInstrDesc(leds.mspct$LedEngin_LZ1_10R302_740nm)

## -----------------------------------------------------------------------------
getInstrSettings(leds.mspct$LedEngin_LZ1_10R302_740nm)

## -----------------------------------------------------------------------------
is_normalized(leds.mspct$LedEngin_LZ1_10R302_740nm)

## -----------------------------------------------------------------------------
leds.mspct$Roithner_UVMAX305

## -----------------------------------------------------------------------------
is_normalized(leds.mspct$Roithner_UVMAX305)

## -----------------------------------------------------------------------------
my.spct <- fscale(leds.mspct$Roithner_UV395,
                  range = c(315, 400),
                  e_irrad,
                  target = 10
                  )
e_irrad(my.spct, waveband(c(315,400)))

## -----------------------------------------------------------------------------
my.spct <- fscale(leds.mspct$Roithner_UV395,
                  range = c(315, 400),
                  e_irrad,
                  target = 1
                  )
integrate_spct(my.spct)

## -----------------------------------------------------------------------------
setScaled(my.spct)
getScaled(my.spct)

## -----------------------------------------------------------------------------
e_irrad(my.spct, waveband(c(315,400)))

## -----------------------------------------------------------------------------
my.UV395 <- leds.mspct$Roithner_UV395
setNormalized(my.UV395)
e_irrad(my.UV395)

## -----------------------------------------------------------------------------
q_ratio(leds.mspct$Roithner_UV395, UVB(), UVA())

## ----eval=eval_plots----------------------------------------------------------
autoplot(leds.mspct$LedEngin_LZ1_10R302_740nm, annotations = c("+", "wls"), )

## ----eval=eval_plots----------------------------------------------------------
ggplot(leds.mspct$LedEngin_LZ1_10R302_740nm) +
  geom_line()

## -----------------------------------------------------------------------------
head(as.data.frame(leds.mspct$LedEngin_LZ1_10R302_740nm))

## ----eval=eval_bands----------------------------------------------------------
attach(leds.mspct)
q_ratio(Roithner_UV395, UVB(), UVA())
detach(leds.mspct)

## -----------------------------------------------------------------------------
attach(leds.mspct)
with(Roithner_UV395, max(w.length))
detach(leds.mspct)

## ----eval=eval_bands----------------------------------------------------------
with(leds.mspct, q_ratio(Roithner_UV395, UVB(), UVA()))

