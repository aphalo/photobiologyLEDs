library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Bridgelux",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

files <- files[grepl("Bridgelux", basename(files))]

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names <- gsub("_700mA_70mm.spct|.spct", "", spectra)
new.names <- gsub("Bridgelight.|Bridgelux.", "Bridgelux_", new.names)
names(new.names) <- spectra

how.measured <- c("Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 70 mm; LED current 700 mA.",
                  "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 55 mm; LED current 350 mA.")
names(how.measured) <- new.names
comment.text <- c("3W SMD LED from Bridgelux https://www.bridgelux.com\nSupplied by AliExpress seller 'YTLEDONE Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink.",
                  "21.7W COB cool white LED type BXRE-50S2001-C-73 (size 1919, LS 14mm, 5000K, CRI 95, Gen 7 V13 Thrive) from Bridgelux https://www.bridgelux.com\nSupplied by Farnell in 2022\nmounted on heat sink.")
names(comment.text) <- new.names
what.measured <- c("3W SMD LED from Bridgelux",
                   "21.7 W cool white COB LED from Bridgelux")
names(what.measured) <- new.names

bridgelux.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, unname(how.measured[new.names[s]]))
  setWhatMeasured(temp.spct, unname(what.measured[new.names[s]]))
  comment(temp.spct) <- unname(comment.text[new.names[s]])
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  bridgelux.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(bridgelux.mspct)

Bridgelux_leds <- names(bridgelux.mspct)

cat("Saving:", Bridgelux_leds, sep = "\n")

save(Bridgelux_leds, bridgelux.mspct, file = "data-raw/rda2merge/bridgelux-mspct.rda")

