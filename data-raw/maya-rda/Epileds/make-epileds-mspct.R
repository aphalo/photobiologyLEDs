library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Epileds",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*70mm\\.spct")

new.names <- gsub("_700mA_70mm.spct", "", spectra)
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 70 mm; LED current 700 mA."
comment.text <- "3W SMD LED from Epileds https://www.epileds.com.tw\nSupplied by AliExpress seller 'YTLEDONE Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED from Epileds"

epileds.mspct <- source_mspct()
for (s in spectra) {
  if (grepl("440nm", s)) {
    cat("Skipping:", s, "\n")
    next()
  }
  cat(s, "\n")
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 6, span = 15, max.slope.delta = 0.0005)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  epileds.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(epileds.mspct)

Epileds_leds <- names(epileds.mspct)

save(Epileds_leds, epileds.mspct, file = "data-raw/rda2merge/epileds-mspct.rda")
