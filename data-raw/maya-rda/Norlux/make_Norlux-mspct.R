library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "./data-raw/maya-rda/Norlux",
                    pattern = "RGB\\.spct\\.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.mspct")

uncollect2spct(get(spectra[1]))

setWhenMeasured(red.spct, as.POSIXct(getWhenMeasured(red.spct)))
setWhenMeasured(green.spct, getWhenMeasured(red.spct))
setWhenMeasured(blue.spct, getWhenMeasured(red.spct))

spectra <- ls(pattern = "\\.spct")

stopifnot(length(spectra) == 3)

new.names <- gsub("\\.spct", "", spectra)
new.names <- paste("Norlux_NHXRGB090S00S", new.names, sep = "_")
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H."
comment.text <- "12W Red-Green-Blue 90 die metal-core COB LED type NHXRGB090S00S from Norlux, Illinois, USA (out of bussiness)\nsupplied by Norlux ca. 2002-2005 \n."
what.measured <- "12W RGB LED COB Type NHXRGB090S00S from Norlux"
when.measured <- when_measured(red.spct)

norlux.mspct <- source_mspct()
for (s in spectra) {
  temp.spct <- get(s)
  when_measured(temp.spct) <- as.Date("2011-07-12")
  temp.spct <- setNormalised(temp.spct)
#  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 6, span = 15, max.slope.delta = 0.0005)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  setWhenMeasured(temp.spct, when.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  norlux.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(norlux.mspct)

temp.mspct <- norlux.mspct
names(temp.mspct) <- c("B", "G", "R")


RGB.spct <- rbindspct(temp.mspct,
                      idfactor = "channel")

autoplot(RGB.spct)

norlux_arrays.mspct <- source_mspct()
norlux_arrays.mspct[["Norlux_NHXRGB090S00S_RGB"]] <- RGB.spct

autoplot(norlux_arrays.mspct[["Norlux_NHXRGB090S00S_RGB"]])

Norlux_leds <- c(names(norlux.mspct), names(norlux_arrays.mspct))

cat("Saving:", Norlux_leds, sep = "\n")

save(Norlux_leds, norlux.mspct, norlux_arrays.mspct, 
     file = "data-raw/rda2merge/norlux-mspct.rda")

