library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/LCfocus",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

files <- files[grepl("LCFOCUS.", basename(files))]

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names <- gsub(".spct", "", spectra)
new.names <- gsub("LCFOCUS.", "LCFOCUS_", new.names)
names(new.names) <- spectra

how.measured <- c("Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 55 mm; LED current 350 mA.")
names(how.measured) <- new.names
comment.text <- c("10W COB neutral white LED type LC-10FSCOB1917-4000 (size 1919, LS 14mm, 4000K, CRI 90+, \"full spectrum\") from LCFOCUS TECH, Shenzhen\nSupplied by LCFOCUS AliExpress store in 2022\nmounted on heat sink.")
names(comment.text) <- new.names
what.measured <- c("10W neutral white COB LED from LCFOCUS")
names(what.measured) <- new.names

lcfocus.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
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
  lcfocus.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(lcfocus.mspct)

LCFOCUS_leds <- names(lcfocus.mspct)

cat("Saving:", LCFOCUS_leds, sep = "\n")

save(LCFOCUS_leds, lcfocus.mspct, file = "data-raw/rda2merge/lcfocus-mspct.rda")
