library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

rm(list = ls(pattern = "*"))
# compute spectra using current ooacquire
# remove noise
# add metadata

path <- "data-raw/maya-txt/Roithner/"
files <- list.files(path, pattern = "dark.txt")
# some files have missing headers!!
files <- files[!grepl("cnt", files)]
files <- gsub("dark.txt", "", files)

a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2012-05-16"),
                                 descriptors = ooacquire::MAYP11278_descriptors,
                                 verbose = TRUE)

roithner_low_power.mspct <- source_mspct()
for (f in files) {
  temp.spct <- 
    s_irrad_corrected(list(
      light = paste(path, f, ".txt", sep = ""), 
      dark = paste(path, f, "dark.txt", sep = "")), 
      correction.method = a.method,
      descriptor = a.descriptor)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- clean(temp.spct)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  setWhatMeasured(temp.spct, 
                  paste("LED: ", f, " from Roithner-Laser; ca. 2005", sep = ""))
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  roithner_low_power.mspct[[f]] <- temp.spct
}

summary(roithner_low_power.mspct)

for (s in roithner_low_power.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when")))
  readline("next:")
}

# save(roithner_low_power.mspct, 
#      file = paste(path, "roithner-low-power-mspct.rda", sep = ""))

