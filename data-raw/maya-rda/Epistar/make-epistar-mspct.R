library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Epistar",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")
stopifnot(length(spectra) == 1)

new.names <- "Epistar_3W_Plant_Grow_LED"
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 50 mm; LED current 350 mA."
comment.text <- "3W SMD 3535 LED \"broad spectrum Plant Grow Light LED\" from Epistar https://www.epistar.com\nSupplied by AliExpress seller 'OTdiode Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED from Epistar"

epistar.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
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
  epistar.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(epistar.mspct)

Epistar_leds <- names(epistar.mspct)

cat("Saving:", Epistar_leds, sep = "\n")

save(Epistar_leds, epistar.mspct, file = "data-raw/rda2merge/epistar-mspct.rda")
