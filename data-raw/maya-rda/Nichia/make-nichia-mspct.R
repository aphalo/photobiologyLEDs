library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Nichia",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.spct")

type2name.map <- c(
  NVSU233B_U365 = "lumitronix.power.bar.365nm.spct",
  NVSU119C_U385 = "lumitronix.power.bar.385nm.spct",
  NFSW757G_Rsp0a = "Nichia.horticulture.5000K.spct",
  NFSL757GT_Rsp0a = "Nichia.horticulture.30000K.spct",
  NFCWL036B_V3_Rfcb0  = "Nichia.Optisolis.NFCWL036B_V3.spct",
  NF2W757GT_F1_sm505_Rfc00  = "Nichia.OptiSolis.5000K.spct",
  unknown_757 = "Q36_4000K.spct",
  NS6L183AT_H1_sw = "nichia.NS6L183AT_H1.spct"
)

name2type.map <- names(type2name.map)
names(name2type.map) <- type2name.map

type2wlchar.map <- c(
  NVSU233B_U365 = "365nm",
  NVSU119C_U385 = "385nm",
  NFSW757G_Rsp0a = "5000K horticulture",
  NFSL757GT_Rsp0a = "30000K horticulture",
  NF2W757GT_F1_sm505_Rfc00 = "50000K CRI95",
  NFCWL036B_V3_Rfcb0  = "5000K CRI94",
  unknown_757 = "4000K CRI80",
  NS6L183AT_H1_sw = "2700K CRI90"
)

type2pwrchar.map <- c(
  NVSU233B_U365 = "6W",
  NVSU119C_U385 = "5W",
  NFSW757G_Rsp0a = "600mW",
  NFSL757GT_Rsp0a = "600mW",
  NF2W757GT_F1_sm505_Rfc00 = "330mW",
  NFCWL036B_V3_Rfcb0  = "10W",
  unknown_757 = "39W",
  NS6L183AT_H1_sw = "3W"
)

type2pkgchar.map <- c(
  NVSU233B_U365 = "12 x SMD PowerBar V3",
  NVSU119C_U385 = "12 x SMD PowerBar V3",
  NFSW757G_Rsp0a = "52 x SMD LinearZ",
  NFSL757GT_Rsp0a = "52 x SMD LinearZ",
  NF2W757GT_F1_sm505_Rfc00 = "52 x SMD LinearZ",
  NFCWL036B_V3_Rfcb0  = "COB",
  unknown_757 = "36 x SMD Q36 SmartArray",
  NS6L183AT_H1_sw = "1 x SMD starboard"
)

new.names <- paste("Nichia", name2type.map, sep = "_")
names(new.names) <- type2name.map

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 350 mA."

nichia.mspct <- source_mspct()
for (s in type2name.map) {
  comment.text <- paste("LED type",
                        name2type.map[s], "from Nichia (https://www.nichia.co.jp/)\nin", 
                        type2pwrchar.map[name2type.map[s]], type2pkgchar.map[name2type.map[s]], 
                        "from Lumitronix (https://www.lumitronix.com/en_gb/) ca. 2015-2019.")
  what.measured <- paste("LED type", name2type.map[s], "from Nichia")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, c(330, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  if (is.na(getWhenMeasured(temp.spct))) {
    setWhenMeasured(temp.spct, ymd_hm("2016-09-14 19:19", tz = "EET"))
  }
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  nichia.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

load("data-raw/maya-rda/Nichia/digitized/hortisolis.rda")
nichia.mspct[["Nichia_NFSW757G_V3_Rs060"]] <- Nichia_Hortisolis.spct

autoplot(nichia.mspct)

Nichia_leds <- names(nichia.mspct)

save(Nichia_leds, nichia.mspct, file = "data-raw/rda2merge/nichia-mspct.rda")
