library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Huey-Jann",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

HPR40E_48K30BI.spct <- led_huey_jann.mspct[["BLUE"]]
rm(led_huey_jann.mspct)

spectra <- ls(pattern = "HPR")

types <- gsub(".spct", "", spectra)
names(types) <- spectra
new.names <- paste("Huey_Jann_", types, sep = "")
names(new.names) <- spectra
when.measured <- ymd("2013-11-27", "2014-01-16")
names(when.measured) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H."

huey_jann.mspct <- source_mspct()
for (s in spectra) {
  comment.text <- paste("30W LED array type", types[s],
                        "from Huey Jann, Taiwan, out of business\n",
                        "Supplied ca. 2010\nmounted on heat sink.")
  what.measured <- paste("LED array type", types[s], "from Huey Jann")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  setWhenMeasured(temp.spct, when.measured[s])
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  huey_jann.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(huey_jann.mspct)

huey_jann <- names(huey_jann.mspct)

save(huey_jann, huey_jann.mspct, file = "data-raw/rda2merge/huey_jann-mspct.rda")
