library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Roithner",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.spct")

types <- gsub("[Rr]oithner\\.|\\.spct|\\.350mA.50mm|\\.2nd", "", spectra)

new.names <- paste("Roithner", types, sep = "_")
names(new.names) <- spectra
names(types) <- spectra

roithner.mspct <- source_mspct()
for (s in spectra) {
  how.measured <- paste("Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current ", 
                        ifelse(grepl("SMB1N|DUV", s), 350, "NA"), "mA.", sep = "")
  comment.text <- paste("LED type",
                        types[s],
                        "from Roithner-LaserTechnik, Austria; ca. ", ifelse(grepl("SMB1N|DUV", s), "2020-2021", "2000-2005"),
                        ".", sep = "")
  what.measured <- paste("LED type", types[s], "from Roithner-Laser")
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
  roithner.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(roithner.mspct)

Roithner_leds <- names(roithner.mspct)

save(Roithner_leds, roithner.mspct, file = "data-raw/rda2merge/roithner-mspct.rda")
