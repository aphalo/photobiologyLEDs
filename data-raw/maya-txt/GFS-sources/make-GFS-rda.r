library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

rm(list = ls(pattern = "*"))
# compute spectra using current ooacquire
# remove noise
# add metadata

path <- "data-raw/maya-txt/GFS-sources/"
files <- list.files(path, pattern = "_PC.txt")
files <- gsub("_PC.txt", "", files)

a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2012-04-12"),
                                 descriptors = ooacquire::MAYP11278_descriptors,
                                 verbose = TRUE)

GFS_source.mspct <- source_mspct()
for (f in files) {
  temp.spct <- 
    s_irrad_corrected(list(
      light = paste(path, f, ".txt", sep = ""), 
      dark = paste(path, f, "_dark.txt", sep = "")), 
      correction.method = a.method,
      descriptor = a.descriptor)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- clean(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setWhatMeasured(temp.spct, "Custom LED light source for Walz GFS-3000")
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  GFS_source.mspct[[f]] <- temp.spct
}

summary(GFS_source.mspct)

for (s in GFS_source.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when")))
  readline("next:")
}

save(GFS_source.mspct, file = paste(path,
                                    "GFS-source-mspct.rda", 
                                    sep = ""))

