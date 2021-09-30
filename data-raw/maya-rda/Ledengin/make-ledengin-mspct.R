library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Ledengin",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "LedEngin_LZ")
spectra <- grep("[.]spct", spectra, value = TRUE)

types <- gsub("LedEngin_|_700mA_4cm.spct|_700mA_12cm.spct.Rda", "", basename(files))

new.names <- 
names(new.names) <- spectra
names(types) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 40 mm; LED current 700 mA."

ledengin.mspct <- source_mspct()
for (s in spectra) {
  comment.text <- paste("4W SMD LED type",
                        types[s],
                        "from Ledengin (now Osram)\nSupplied by Mouser or Digkey ca. 2015\n",
                        "soldered on 20 mm starboard mounted on heat sink.")
  what.measured <- paste("4W SMD LED type", types[s], "from Ledengin")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  setWhenMeasured(temp.spct, ymd("2017-09-27"))
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  ledengin.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(ledengin.mspct)

ledengin <- names(ledengin.mspct)

save(ledengin, ledengin.mspct, file = "data-raw/rda2merge/ledengin-mspct.rda")
