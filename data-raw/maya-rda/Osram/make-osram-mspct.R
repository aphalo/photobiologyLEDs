library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Osram",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.spct")

type2name.map <- c(
  GF_CSHPM2.24_2T4T_1 = "osram.oslom.740nm.spct",
  LY5436 = "Osram_LY5436.spct",
  GW_CSSRM3.HW = "OSLON.Horti.White.702mA.120mm.spct"
)

name2type.map <- names(type2name.map)
names(name2type.map) <- type2name.map

type2wlchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "730nm",
  LY5436 = "590nm",
  GW_CSSRM3.HW = "Horti White"
)

type2pwrchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "700 mW",
  LY5436 = "low",
  GW_CSSRM3.HW = "2 W"
)

type2pkgchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "12 x SMD PowerBar V3",
  LY5436 = "5mm epoxi",
  GW_CSSRM3.HW = "SMD 3mm x 3mm"
)

type2supplier.map  <- c(
  GF_CSHPM2.24_2T4T_1 = "from Lumitronix (https://www.lumitronix.com/en_gb/) ca. 2020.",
  LY5436 = "ca. 1995",
  GW_CSSRM3.HW = "2021"
)

new.names <- paste("Osram", name2type.map, sep = "_")
names(new.names) <- type2name.map

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 350 mA."

osram.mspct <- source_mspct()
for (s in type2name.map) {
  comment.text <- paste("LED type",
                        name2type.map[s], "from Osram (https://www.osram.com/)\nin", 
                        type2pwrchar.map[name2type.map[s]], type2pkgchar.map[name2type.map[s]], 
                        type2supplier.map[name2type.map[s]])
  what.measured <- paste("LED type", name2type.map[s], "from Osram")
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(320.1, 900.1), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  osram.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(osram.mspct)

Osram_leds <- names(osram.mspct)

save(Osram_leds, osram.mspct, file = "data-raw/rda2merge/osram-mspct.rda")
