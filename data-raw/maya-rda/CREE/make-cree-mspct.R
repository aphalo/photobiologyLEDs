library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/CREE",
                    pattern = "LED.spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names <- gsub(".650mA.2nd.LED.spct", "", spectra)
new.names <- gsub("[.]", "_", new.names)
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; LED current 650 mA."
comment.text <- "3W SMD LED from CREE https://cree-led.com/\nSupplied by AliExpress seller ' OTdiode Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED type XPE R3 from CREE"

cree.mspct <- source_mspct()
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
  cree.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(cree.mspct)

keepers <- "CREE_XPE_480nm"
cat("Keeping only:", keepers)

cree.mspct <- cree.mspct[keepers]

CREE_leds <- names(cree.mspct)

save(CREE_leds, cree.mspct, file = "data-raw/rda2merge/cree-mspct.rda")
