library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

oldwd <-
  setwd("~/RPackages/photobiologyLEDs/data-raw/maya-rda/Nichia/reflectors-COB")

load("OptisolisRflNone.spct.Rda")
load("OptisolisRfl35.spct.Rda")
load("OptisolisRfl25.spct.Rda")
load("OptisolisRfl15.spct.Rda")

setwd(oldwd)

COB_reflectors.mspct <- 
  collect2mspct()
rm(list = ls(pattern = "*\\.spct|*\\.raw_mspct"))

comment(COB_reflectors.mspct) <- 
  "LEDiL Mirella-G2 series 50-mm-diameter reflectors used with a Nichia NFCWL036B_V3_Rfcb0 COB LED.\n(Nominal angles of approximately 15, 25 and 35 degrees not valid at 159 mm distance as used in these measurements.)"
names(COB_reflectors.mspct) <- 
  gsub("Optisolis", "", names(COB_reflectors.mspct))
names(COB_reflectors.mspct) <- 
  gsub("5.spct", "5deg", names(COB_reflectors.mspct))
names(COB_reflectors.mspct) <- 
  gsub(".spct", "", names(COB_reflectors.mspct))

LED.type <- 
  "Nichia Optisolis type NFCWL036B_V3 10W COB"

type2Rfl.map <- c(
  RflNone = "no reflector",
  Rfl15deg = "LEDiL F15558_MIRELLA-G2-S reflector 15 degrees",
  Rfl25deg = "LEDiL F15559_MIRELLA-G2-M reflector 25 degrees",
  Rfl35deg = "LEDiL F15560_MIRELLA-G2-W reflector 35 degrees"
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
irrads <- q_irrad(COB_reflectors.mspct, scale.factor = 1e6)
irrads$Q_Total_rel <- irrads$Q_Total / min(irrads$Q_Total)
irrads

save(COB_reflectors.mspct, file = "./data/COB-reflectors-mspct.rda")
