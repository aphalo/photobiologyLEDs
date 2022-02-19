library(photobiology)
library(photobiologyWavebands)
library(lubridate)
library(ggspectra)
library(readxl)

path2files <- "data-raw/maya-excel/LED_Measurements_07_2011"
files <- list.files(path2files, pattern = "*.xlsx", full.names = TRUE)
spct.names <- gsub("Mayameasurement_slitcorrected_|.xlsx", "", 
                   list.files(path2files, pattern = "*.xlsx", full.names = FALSE))

when <- file.mtime(files)

shafi.mspct <- source_mspct()

for (i in seq_along(files)) {
  if (i %in% c(2,10)) {
    next()
  }
  temp.spct <- read_xlsx(files[i],
                         sheet = "front",
                         range = "H125:I1581",
                         col_names = c("w.length", "s.e.irrad"),
                         col_types = "numeric") 
  setSourceSpct(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(250,900)) # calibration range
  temp.spct <- normalize(temp.spct)
  setWhenMeasured(temp.spct, ymd_hms(when[i], tz = "EET"))
 
  if (grepl("^QDD", spct.names[i])) {
    supplier <- "Quantum Devices, USA"
    vintage <- "1995"
  } else if (grepl("^HLM", spct.names[i])) {
    supplier <- "Hewlett-Packard/Agilent"
    vintage <- "1995"
  } else if (grepl("^NHX", spct.names[i])) {
    supplier <- "Norlux, USA"
    vintage <- "1995"
  } else if (grepl("^LY", spct.names[i])) {
    supplier <- "Osram"
    vintage <- "1995"
  } else {
    supplier <- "Roithner-Laser, Austria"
    vintage <- "2005"
  }
  what.text <- paste("LED, type: ", 
                     gsub("_", "-", spct.names[i], fixed = TRUE),
                     " from ", supplier, "; ca. ", vintage, sep = "")
  print(what.text)
  setWhatMeasured(temp.spct, what.text)
  setHowMeasured(temp.spct, 
                 "Array spectrometer, Ocean Optics Maya 2000 Pro, Bentham D7H cosine corrected diffuser.")
  comment(temp.spct) <-
    "Measured by Shafiuddin Ahmed\nat SenPEP, OEB, FBES, Univ. of Helsinki"
  temp.spct <- clean(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  shafi.mspct[[spct.names[i]]] <- clean(temp.spct)
}

summary(shafi.mspct)
autoplot(shafi.mspct)

for (s in shafi.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when")))
  readline("next:")
}

save(shafi.mspct, file = "data-raw/rda2merge/shafi-mspct.rda")

