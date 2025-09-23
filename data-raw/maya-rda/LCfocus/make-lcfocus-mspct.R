library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

energy_as_default()

files <- list.files(path = "data-raw/maya-rda/LCfocus",
                    pattern = "\\.spct\\.[Rr]da",
                    full.names = TRUE)

files <- files[grepl("LCFOCUS.", basename(files))]

for (f in files) {
  load(f)
}

new.names <- c(
  "LCFOCUS.high.CRI.COB.10W.60mm.350mA.37.9V.spct" = "LCFOCUS_LC_10FS504_G24",
  "LCFOCUS.LC_10FSCOB1917_4000.spct" = "LCFOCUS_LC_10FSCOB1917_4000",
  "LCFOCUS.low.CRI.cw.COB.10W.60mm.350mA.21.7V.spct" = "LCFOCUS_LC_10FSCOB1411_6000",
  "LCFOCUS.low.CRI.ww.COB.10W.60mm.350mA.31.4V.spct" = "LCFOCUS_LC_10FSCOB1411_2700"
)

comment.text <- c(
    "10W cool white COB LED 5000K type LC-10FS504-G24 (size 1414, LS 11mm, 4000K, CRI 96-99, \"full spectrum\") from LCFOCUS bought AliExpress in 2022",
    "10W neutral white COB LED 4000K 10W type LC-10FSCOB1917-4000 (size 1919, LS 17mm, 4000K, CRI 90+, \"full spectrum\") from LCFOCUS bought AliExpress in 2022",
    "10W cool white COB LED type LC-10FSCOB1411-6000 (size 1414, LS 11mm, 6000K, CRI 90+, \"full spectrum\") from LCFOCUS bought AliExpress in 2022",
    "10W warm white COB LED type LC-10FSCOB1411-2700 (size 1414, LS 11mm, 2700K, CRI 90+, \"full spectrum\") from LCFOCUS bought AliExpress in 2022"
)
names(comment.text) <- unname(new.names)

what.measured <- c("10W cool white COB LED from LCFOCUS",
                   "10W neutral white COB LED from LCFOCUS",
                   "10W cool white COB LED from LCFOCUS",
                   "10W warm white COB LED from LCFOCUS")
names(what.measured) <- unname(new.names)

spectra <- ls(pattern = "*\\.spct")

how.measured <- 
  rep("Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 55 to 60 mm; LED current 350 mA.", 4)
names(how.measured) <- new.names

lcfocus.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 6, span = 15, max.slope.delta = 0.0005)
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
