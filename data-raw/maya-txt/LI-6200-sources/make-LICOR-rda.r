library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

rm(list = ls(pattern = "*"))
# compute spectra using current ooacquire
# remove noise
# add metadata

path <- "data-raw/maya-txt/LI-6200-sources/"
files <- list.files(path, pattern = "_PC.txt")
# some files have missing headers!!
files <- files[grepl("15v", files)]
files <- gsub("_PC.txt", "", files)

a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2012-04-12"),
                                 descriptors = ooacquire::MAYP11278_descriptors,
                                 verbose = TRUE)

channels.map <- c("Licor_15v_blue" = "blue",
                  "Licor_15v_green" = "green",
                  "Licor_15v_red" = "red")
names.map <- c("Licor_15v_blue" = "NHXRGB090_B",
                  "Licor_15v_green" = "NHXRGB090_G",
                  "Licor_15v_red" = "NHXRGB090_R")
norlux.mspct <- source_mspct()
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
  setWhatMeasured(temp.spct, 
                  paste("90 die RGB LED array type NHXRGB0905005, ", 
                        channels.map[f], " channel, ",
                        "from Norlux, USA; ca. 1990", sep = ""))
  setHowMeasured(temp.spct, "Array spectrometer, Ocean Optics Maya 2000 Pro, Bentham D7H cosine corrected diffuser.")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  norlux.mspct[[names.map[f]]] <- temp.spct
}

NHXRGB090.spct <- rbindspct(list(R = norlux.mspct$NHXRGB090_R,
                                 G = norlux.mspct$NHXRGB090_G,
                                 B = norlux.mspct$NHXRGB090_B),
                            idfactor = "channel")

norlux.mspct[["NHXRGB090"]] <- NHXRGB090.spct
getWhenMeasured(norlux.mspct[["NHXRGB090"]])

names(norlux.mspct)

summary(norlux.mspct)

for (s in norlux.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when:inst.sn")))
  readline("next:")
}

save(norlux.mspct, file = "data-raw/rda2merge/norlux-mspct.rda")


