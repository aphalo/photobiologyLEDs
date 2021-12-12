library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Marktech",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "5120\\.spct")
stopifnot(length(spectra) == 1)

new.names <- gsub("\\.spct", "", spectra)
new.names <- gsub("marktech\\.", "Marktech_", new.names)
new.names <- paste(new.names, "340nm", sep = "_")
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 50 mm; LED current 350 mA."
comment.text <- "2W SMD LED type MTSM340UV_F5120 from Marktech https://marktechopto.com/\nSupplied by Digikey in 2018-2019\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "2W SMD UV LED from Marktech"

marktech.mspct <- source_mspct()
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
  marktech.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(marktech.mspct)

marktech <- names(marktech.mspct)

cat("Saving:", marktech, sep = "\n")

save(marktech, marktech.mspct, file = "data-raw/rda2merge/marktech-mspct.rda")
