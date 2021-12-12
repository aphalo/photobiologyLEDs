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
  GF_CSHPM2.24_2T4T_1 = "osram.oslom.740nm.spct"
)

name2type.map <- names(type2name.map)
names(name2type.map) <- type2name.map

type2wlchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "730nm"
)

type2pwrchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "700mW"
)

type2pkgchar.map <- c(
  GF_CSHPM2.24_2T4T_1 = "12 x SMD PowerBar V3"
)

new.names <- paste("Osram", name2type.map, sep = "_")
names(new.names) <- type2name.map

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 350 mA."

osram.mspct <- source_mspct()
for (s in type2name.map) {
  comment.text <- paste("LED type",
                        name2type.map[s], "from Osram (https://www.osram.com/)\nin", 
                        type2pwrchar.map[name2type.map[s]], type2pkgchar.map[name2type.map[s]], 
                        "from Lumitronix (https://www.lumitronix.com/en_gb/) ca. 2020.")
  what.measured <- paste("LED type", name2type.map[s], "from Osram")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
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

osram <- names(osram.mspct)

save(osram, osram.mspct, file = "data-raw/rda2merge/osram-mspct.rda")
