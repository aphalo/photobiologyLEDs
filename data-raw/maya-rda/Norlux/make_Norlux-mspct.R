library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Norlux",
                    pattern = "RGB\\.spct\\.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "\\.mspct")
uncollect2spct(get(spectra[1]))

spectra <- ls(pattern = "\\.spct")

stopifnot(length(spectra) == 3)

new.names <- gsub("\\.spct", "", spectra)
new.names <- paste("Norlux_NHXRGB090S00S", new.names, sep = "_")
names(new.names) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H."
comment.text <- "12W Red-Green-Blue 90 die metal-core COB LED type NHXRGB090S00S from Norlux, Illinois, USA (out of bussiness)\nsupplied by Norlux ca. 2002-2005 \n."
what.measured <- "12W RGB LED COB Type NHXRGB090S00S from Norlux"

norlux.mspct <- source_mspct()
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
  norlux.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(norlux.mspct)
autoplot(Norlux_RGB.mspct)
attributes(Norlux_RGB.mspct$red)
norlux <- names(norlux.mspct)

cat("Saving:", norlux, sep = "\n")

save(norlux, norlux.mspct, file = "data-raw/rda2merge/norlux-mspct.rda")
