library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Ledguhon",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names = c("LEDGUHON.COB.67mm.350mA.38.1V.spct" = "Ledguhon_10WBVG14G24_Y6C_T4", 
              "LEDGUHON.WFR.4000K.65mm.350mA.36.6V.spct" = "Ledguhon_10WBVGIR14G24_Y6C_T4")

# new.names <- gsub(".350mA.spct", "14G24_Y6C_T4", spectra)
# new.names <- gsub("LEDGUHON.", "Ledguhon_", new.names)
# names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 70 mm; LED current 700 mA."
comment.text <- "10W white 4000K COB 1414 (13.5x13.5mm square) LED from Bridgelux (?) https://www.bridgelux.com\nSupplied by AliExpress seller 'LEDGUHON (Guangzhou Juhong Optoelectronics, https://www.ledguhon.com/)' in 2022\nmounted on heat sink.\nType denomination is from LEDGUHON, spectrum matches that of Brigelux 'Thrive' series."
what.measured <- "10W 4000K COB LED from LEDGUHON"

ledguhon.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
  temp.spct <- fshift(temp.spct, c(320, 350))
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(320, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  ledguhon.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

Ledguhon_leds <- names(ledguhon.mspct)

autoplot(ledguhon.mspct)

cat("Saving:", Ledguhon_leds, sep = "\n")

save(Ledguhon_leds, ledguhon.mspct, file = "data-raw/rda2merge/ledguhon-mspct.rda")
