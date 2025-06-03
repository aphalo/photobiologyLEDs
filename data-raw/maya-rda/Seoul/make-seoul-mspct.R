library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

energy_as_default()

files <- list.files(path = "data-raw/maya-rda/Seoul",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.spct")

type2name.map <- c(
  STW9C2SB_S = "SunLike.5000K.spct",
  S4SM_1564359736_0B500H3S_00001 = "Sunlike.15W.COB.CRI97.3500K.350mA.35.4V.60mm.spct",
  S4SM_1564509736_0B500H3S_00001 = "Sunlike.15W.COB.CRI97.3500K.60mm.350mA.35.7V.spct"
)

name2type.map <- names(type2name.map)
names(name2type.map) <- type2name.map

type2wlchar.map <- c(
  STW9C2SB_S = "5000K CRI95",
  S4SM_1564359736_0B500H3S_00001 = "3500K CRI97",
  S4SM_1564509736_0B500H3S_00001 = "5000K CRI97"
)

type2pwrchar.map <- c(
  STW9C2SB_S = "1300mW",
  S4SM_1564359736_0B500H3S_00001 = "15W",
  S4SM_1564509736_0B500H3S_00001 = "15W"
)

type2pkgchar.map <- c(
  STW9C2SB_S = "52 x SMD LinearZ",
  S4SM_1564359736_0B500H3S_00001 = "COB 19x19mm LS 14.5mm",
  S4SM_1564509736_0B500H3S_00001 = "COB 19x19mm LS 14.5mm"
)

new.names <- paste("SeoulSemicon", name2type.map, sep = "_")
names(new.names) <- type2name.map

how.measured <- c(
  STW9C2SB_S = "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 350 mA.",
  S4SM_1564359736_0B500H3S_00001 = "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 60mm; LED current 350 mA.",
  S4SM_1564509736_0B500H3S_00001 = "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 60mm; LED current 350 mA."
)

supplier <- c(
  STW9C2SB_S = "Lumitronix, Germany, ca. 2018-2019",
  S4SM_1564359736_0B500H3S_00001 = "Future Electronics, Germany/UK, 2022",
  S4SM_1564509736_0B500H3S_00001 = "Future Electronics, Germany/UK, 2022"
)

seoul.mspct <- source_mspct()
for (s in type2name.map) {
  comment.text <- paste("LED type",
                        name2type.map[s], "SunLike series from Seoul Semiconductor (https://www.seoulsemicon./)\nin", 
                        type2pwrchar.map[name2type.map[s]], type2pkgchar.map[name2type.map[s]], 
                        "supplier:", supplier[name2type.map[s]])
  what.measured <- paste("LED type", name2type.map[s], "from Seoul Semiconductor")
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct, norm = "max")
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured[name2type.map[s]])
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  seoul.mspct[[new.names[s]]] <- temp.spct
  autoplot(seoul.mspct[[new.names[s]]])
  readline("next:")
}

autoplot(seoul.mspct, unit.out = "energy")

SeoulSemicon_leds <- names(seoul.mspct)

save(SeoulSemicon_leds, seoul.mspct, file = "data-raw/rda2merge/seoul-mspct.rda")
