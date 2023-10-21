library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Samsung",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names = c("Samsung.4000K.CRI80.350mA.65mm.34.1V.spct" = "Samsung_SPHWHAHDND25YZT3D3")

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 65 mm; LED current 350 mA."
comment.text <- "12.2W white 4000K COB CRI80 LED (19x19mm square, type SPHWHAHDND25YZT3D3) from Samsung https://www.samsung.com/led/\nSupplied by AliExpress seller 'LEDGUHON (Guangzhou Juhong Optoelectronics, https://www.ledguhon.com/)' in 2022\nmounted on heat sink.\nType denomination is from LEDGUHON, spectrum matches that of Brigelux 'Thrive' series."
what.measured <- "12.2W 4000K CRI80 COB LED from Samsung"

samsung.mspct <- source_mspct()
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
  samsung.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

Samsung_leds <- names(samsung.mspct)

photon_as_default()
autoplot(samsung.mspct)

cat("Saving:", Samsung_leds, sep = "\n")

save(Samsung_leds, samsung.mspct, file = "data-raw/rda2merge/samsung-mspct.rda")
