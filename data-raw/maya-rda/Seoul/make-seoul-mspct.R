library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Seoul",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.spct")

type2name.map <- c(
  STW9C2SB_S = "SunLike.5000K.spct"
)

name2type.map <- names(type2name.map)
names(name2type.map) <- type2name.map

type2wlchar.map <- c(
  STW9C2SB_S = "50000K CRI95"
)

type2pwrchar.map <- c(
  STW9C2SB_S = "1300mW"
)

type2pkgchar.map <- c(
  NFSW757G_Rsp0a = "52 x SMD LinearZ"
)

new.names <- paste("SeoulSemicon", name2type.map, sep = "_")
names(new.names) <- type2name.map

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 350 mA."

seoul.mspct <- source_mspct()
for (s in type2name.map) {
  comment.text <- paste("LED type",
                        name2type.map[s], "SunLike series from Seoul Semiconductor (https://www.seoulsemicon./)\nin", 
                        type2pwrchar.map[name2type.map[s]], type2pkgchar.map[name2type.map[s]], 
                        "from Lumitronix, Germany; ca. 2018-2019.")
  what.measured <- paste("LED type", name2type.map[s], "from Seoul Semiconductor")
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
  seoul.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(seoul.mspct)

SeoulSemicon_leds <- names(seoul.mspct)

save(SeoulSemicon_leds, seoul.mspct, file = "data-raw/rda2merge/seoul-mspct.rda")
