library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Luminus",
                    pattern = "mA.spct.[Rr]da$",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "*\\.spct")

new.names = c("Luminous.Purple.COB.350mA.spct" = "Luminus_CXM_14_HS_12_36_AC30")

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 65 mm; LED current 350 mA."
comment.text <- "25W Purple COB 1919 (19x19mm square, type CXM-14-HS-12-36-AC30) LED from Luminus Devices https://www.luminus.com/\n bought in 2022\nmounted on heat sink."
what.measured <- "25W Purple (blue + red) COB LED from Luminus"

luminus.mspct <- source_mspct()
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
  luminus.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

Luminus_leds <- names(luminus.mspct)

autoplot(luminus.mspct)

cat("Saving:", Luminus_leds, sep = "\n")

save(Luminus_leds, luminus.mspct, file = "data-raw/rda2merge/luminus-mspct.rda")
