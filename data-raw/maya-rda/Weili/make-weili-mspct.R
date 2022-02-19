library(photobiology)
library(ggspectra)
library(lubridate)

photon_as_default()

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Weili",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

wavelengths <- c(525, 555 ,500, 550)
spct.names <- ls(pattern = "*[.]spct")[c(4, 5, 6, 7)[order(wavelengths)]]
wavelengths <- sort(wavelengths)
# spct.names <- gsub(".[Rr]da", "", basename(files))
# names <- gsub(".spct", "", spct.names)
# names <- gsub("[wW]eilli", "weili", names)

names <- paste("weili.3W.nominal.", wavelengths, "nm", sep = "")
weili.mspct <- source_mspct(mget(spct.names))
names(weili.mspct) <- names
names(weili.mspct)

for (s in names) {
  how_measured(weili.mspct[[s]]) <-
    "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 50mm; LED current 350 mA."
  what_measured(weili.mspct[[s]]) <- "LED type unknown, rated at 3W, \"bat wing\" package; supplied by Shenzhen Weili Optical, Shenzhen, China; ca. 2015"
 print(autoplot(weili.mspct[[s]]) + ggtitle(s))
  readline("next: ")
}

weili <- names(weili.mspct)

save(weili, weili, file = "data-raw/rda2merge/weili-mspct.rda")
