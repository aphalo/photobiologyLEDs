library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

oldwd <-
  setwd("~/RPackages/photobiologyLEDs/data-raw/maya-rda/Nichia/dimming-COB")

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
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, c(330, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- "Comparison of reflectors at close range (159 mm) rather than design distance. This is most likely why highest irradiance is not observed with the narrowest beam reflector, but with a wider one."
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:how")))
  COB_dimming.mspct[[s]] <- temp.spct
  readline("next:")
}

autoplot(COB_dimming.mspct)
summary(COB_dimming.mspct)
cat(comment(COB_dimming.mspct))
irrads <- q_irrad(COB_dimming.mspct, scale.factor = 1e6)
irrads$Q_Total_rel <- irrads$Q_Total / max(irrads$Q_Total) * 100
irrads

save(COB_dimming.mspct, file = "./data/COB-dimming-mspct.rda")
