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

COB_dimming.mspct <- 
  collect2mspct()
rm(list = ls(pattern = "*\\.spct|*\\.raw_mspct"))

comment(COB_dimming.mspct) <- 
  "Constant current (CC) dimming of a Nichia NFCWL036B_V3_Rfcb0 COB LED."
names(COB_dimming.mspct) <- 
  gsub("OptisolisRfl25", "CC", names(COB_dimming.mspct))
names(COB_dimming.mspct) <- 
  gsub("144mA", "350mA", names(COB_dimming.mspct))
names(COB_dimming.mspct) <- 
  gsub(".spct", "", names(COB_dimming.mspct))

LED.type <- 
  "Nichia Optisolis type NFCWL036B_V3 10W COB with 25 degrees nomical LEDiL reflector."

type2Rfl.map <- c(
  RflNone = "no reflector",
  Rfl15deg = "reflector 15 degrees",
  Rfl25deg = "reflector 25 degrees",
  Rfl35deg = "reflector 35 degrees"
)

how.measured <- 
  "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 159 mm; LED current 350 mA."

for (s in names(COB_reflectors.mspct)) {
  comment.text <- paste("Nichia Optisolis type NFCWL036B_V3 10W COB", "from Nichia (https://www.nichia.co.jp/)\n", 
                        "With", type2Rfl.map[s])
  what.measured <- paste("COB LED with ", type2Rfl.map[s])
  temp.spct <- COB_reflectors.mspct[[s]]
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, c(330, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- "Comparison of reflectors at close range (159 mm) rather than design distance. This is most likely why highest irradiance is not observed with the narrowest beam reflector, but with a wider one."
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  COB_reflectors.mspct[[s]] <- temp.spct
  readline("next:")
}

autoplot(COB_reflectors.mspct)
summary(COB_reflectors.mspct)
cat(comment(COB_reflectors.mspct))
irrads <- q_irrad(COB_dimming.mspct, scale.factor = 1e6)
irrads$Q_Total_rel <- irrads$Q_Total / max(irrads$Q_Total) * 100
irrads

save(COB_dimming.mspct, file = "./data/COB-dimming-mspct.rda")
