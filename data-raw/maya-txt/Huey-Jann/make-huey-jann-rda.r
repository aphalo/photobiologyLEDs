library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

rm(list = ls(pattern = "*"))
# compute spectra using current ooacquire
# remove noise
# add metadata

path <- "data-raw/maya-txt/Huey-Jann/"
files <- list.files(path, pattern = "_dark.txt")
# some files have missing headers!!
files <- files[grepl("30W", files)]
files <- gsub("_dark.txt", "", files)

a.method <- MAYP11278_sun.mthd
a.descriptor <- which_descriptor(ymd("2013-07-18"),
                                 descriptors = ooacquire::MAYP11278_descriptors,
                                 verbose = TRUE)

huey_jann.mspct <- source_mspct()
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
  temp.spct <- thin_wl(temp.spct, max.wl.step = 5, max.slope.delta = 0.0005, span = 15)
  temp.spct <- trim_spct(temp.spct, low.limit = 380, fill = 0)
  setWhatMeasured(temp.spct, "30W LED array from Huey-Jann, Taiwan; ca. 2005.")
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  huey_jann.mspct[[f]] <- temp.spct
}

summary(huey_jann.mspct)

for (s in huey_jann.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when")))
  readline("next:")
}

save(huey_jann.mspct, file = "data-raw/rda2merge/huey-jann-mspct.rda")

