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

spectra <- ls(pattern = "*nm\\.spct")

new.names <- gsub("\\.spct", "", spectra)
new.names <- gsub("\\.unkwon|\\.unkown", "", new.names)
new.names <- gsub("epileds\\.", "Epileds_3W_", new.names)
#new.names <- paste(new.names, "_350mA_50mm", sep = "")
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 50 mm; LED current 350 mA."
comment.text <- "3W SMD LED from Epileds https://www.epileds.com.tw\nSupplied by AliExpress seller 'YTLEDONE Official Store' in 2021\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED from Epileds"

epileds.mspct <- source_mspct()
for (s in spectra) {
  cat(s, "\n")
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
  epileds.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(epileds.mspct)

keepers <- grepl("410|460|470|445", names(epileds.mspct))

epileds2.mspct <- epileds.mspct[keepers]

Epileds_leds2 <- names(epileds2.mspct)

save(Epileds_leds2, epileds2.mspct, file = "data-raw/rda2merge/epileds2-mspct.rda")
