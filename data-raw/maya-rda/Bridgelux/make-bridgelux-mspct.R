library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Bridgelux",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names <- gsub("_700mA_70mm.spct", "", spectra)
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 70 mm; LED current 700 mA."
comment.text <- "3W SMD LED from Bridgelux https://www.bridgelux.com\nSupplied by AliExpress seller 'YTLEDONE Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED from Bridgelux"

bridgelux.mspct <- source_mspct()
for (s in spectra) {
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
  bridgelux.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(bridgelux.mspct)

keepers <- 1
names <- "Bridgelux_3W_450nm"

cat("Keeping only:", keepers, "\n")

bridgelux.mspct <- bridgelux.mspct[keepers]
names(bridgelux.mspct) <- names

Bridgelux_leds <- names(bridgelux.mspct)

cat("Saving:", Bridgelux_leds, sep = "\n")

save(Bridgelux_leds, bridgelux.mspct, file = "data-raw/rda2merge/bridgelux-mspct.rda")
