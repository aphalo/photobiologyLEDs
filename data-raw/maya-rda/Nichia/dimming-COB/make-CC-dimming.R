library(photobiology)
library(ggspectra)
library(lubridate)
library(dplyr)

# clear workspace
rm(list = ls(pattern = "*"))

oldwd <-
  setwd("./data-raw/maya-rda/Nichia/dimming-COB")

files <- list.files(pattern = "\\.spct.Rda")

for (f in files) {
  load(f)
}

setwd(oldwd)

COB_dimming.mspct <- collect2mspct()
rm(list = ls(pattern = "*\\.spct|*\\.raw_mspct"))

comment(COB_dimming.mspct) <- 
  "Constant current (CC) dimming of a Nichia NFCWL036B_V3_Rfcb0 COB LED with a LEDiL F15559_MIRELLA-G2-M 25 degrees nominal 50-mm-diameter reflector. Current and voltage were measured simultaneously with spectral irradiance."
names(COB_dimming.mspct) <- 
  gsub("OptisolisRfl25", "CC", names(COB_dimming.mspct))
names(COB_dimming.mspct) <- 
  gsub("144mA", "350mA", names(COB_dimming.mspct))
names(COB_dimming.mspct) <- 
  gsub(".spct", "", names(COB_dimming.mspct))

formatted.conditions <- gsub("CC.", "", names(COB_dimming.mspct))
formatted.conditions <- gsub("mA.","mA and ", formatted.conditions)
names(formatted.conditions) <- names(COB_dimming.mspct)

LED.type <- 
  "Nichia Optisolis type NFCWL036B_V3 10W COB with LEDiL F15559_MIRELLA-G2-M 25 degrees nominal 50-mm-diameter reflector."

how.measured <- 
  "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 159 mm."

for (s in names(COB_dimming.mspct)) {
  comment.text <- paste("LED current and voltage:", formatted.conditions[s],
                        ".\nOptisolis type NFCWL036B_V3 10W COB", 
                        "from Nichia (https://www.nichia.co.jp/)\n", 
                        "WithLEDiL F15559_MIRELLA-G2-M reflector 25 degrees")
  what.measured <- paste("10W Optisolis COB LED driven at ",  formatted.conditions[s])
  temp.spct <- COB_dimming.mspct[[s]]
  temp.spct <- thin_wl(temp.spct, max.wl.step = 5, max.slope.delta = 0.0005, span = 15)
  temp.spct <- trim_wl(temp.spct, c(330, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:how")))
  COB_dimming.mspct[[s]] <- temp.spct
  readline("next:")
}

ordering <- order(q_irrad(COB_dimming.mspct, scale.factor = 1e6)$Q_Total,
                  decreasing = TRUE)
COB_dimming.mspct <- COB_dimming.mspct[ordering]
names(COB_dimming.mspct) <- gsub("\\.*3[0-9]\\.[0-9][0-9]*[vV]$", "", names(COB_dimming.mspct))

q_irrad(COB_dimming.mspct, scale.factor = 1e6)

print(autoplot(COB_dimming.mspct))
summary(COB_dimming.mspct)
cat(comment(COB_dimming.mspct))

photons.tb <- q_irrad(COB_dimming.mspct, scale.factor = 1e6)
energy.tb <- e_irrad(COB_dimming.mspct, scale.factor = 1)

COB_dimming.tb <- full_join(photons.tb, energy.tb)
COB_dimming.tb$Q_Total_rel <- COB_dimming.tb$Q_Total / max(COB_dimming.tb$Q_Total) * 100
COB_dimming.tb$E_Total_rel <- COB_dimming.tb$E_Total / max(COB_dimming.tb$E_Total) * 100

COB_dimming.tb$mA <- as.numeric(gsub("^CC.|mA$", "", COB_dimming.tb$spct.idx))
comment(COB_dimming.tb) <- paste("Constant current dimming. LED current (mA),",
                                 "photon irradiance (Q_Total), energy irradiance (E_Total),",
                                 "name of spectrum in 'COB_dimming.mspct' (spct.idx).",
                                 "LED: Optisolis type NFCWL036B_V3 10W COB", 
                                 "from Nichia (https://www.nichia.co.jp/)\n", 
                                 "With LEDiL F15559_MIRELLA-G2-M reflector 25 degrees.")
COB_dimming.tb

print(ggplot(COB_dimming.tb, aes(mA, Q_Total_rel)) +
  geom_line())

save(COB_dimming.mspct, COB_dimming.tb, file = "./data/COB-dimming-mspct.rda")
