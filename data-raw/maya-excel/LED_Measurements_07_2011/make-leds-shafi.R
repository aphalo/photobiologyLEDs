library(photobiology)
library(photobiologyWavebands)
library(lubridate)
library(ggspectra)
library(readxl)

# clear workspace
rm(list = ls(pattern = "*"))

path2files <- "data-raw/maya-excel/LED_Measurements_07_2011"
files <- list.files(path2files, pattern = "*.xlsx", full.names = TRUE)
spct.names <- gsub("Mayameasurement_slitcorrected_|.xlsx", "", 
                   list.files(path2files, pattern = "*.xlsx", full.names = FALSE))

# when <- file.mtime(files)
# best guess available
when <- "2011-07-30"

shafi.mspct <- source_mspct()

quantum_devices <- character()
agilent <- character()
osram <- character()
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
  setWhenMeasured(temp.spct, ymd(when, tz = "UTC"))
 
  if (grepl("^QDD", spct.names[i])) {
    supplier <- "Quantum Devices, USA"
    vintage <- "1995"
    new.name <- paste("QuantumDevices_", spct.names[i], sep = "")
    quantum_devices <- c(quantum_devices, new.name) 
  } else if (grepl("^HLM", spct.names[i])) {
    supplier <- "Hewlett-Packard/Agilent"
    vintage <- "1995"
    new.name <- paste("Agilent_", gsub("_take2", "", spct.names[i]), sep = "")
    agilent <- c(agilent, new.name) 
  } else if (grepl("^LY", spct.names[i])) {
    supplier <- "Osram"
    vintage <- "1995"
    new.name <- paste("Osram_", spct.names[i], sep = "")
    osram <- c(osram, new.name) 
  } else {
    # we skip those from Norlux and Roithner
    next()
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
  shafi.mspct[[new.name]] <- clean(temp.spct)
}

names(shafi.mspct)
summary(shafi.mspct)
autoplot(shafi.mspct)

for (s in shafi.mspct) {
  print(autoplot(s, annotations = c("+", "title:what:when")))
  readline("next:")
}

agilent.mspct <- shafi.mspct[agilent]
Agilent_leds <- names(agilent.mspct)
save(Agilent_leds, agilent.mspct, file = "data-raw/rda2merge/agilent-mspct.rda")

quantum_devices.mspct <- shafi.mspct[quantum_devices]
QuantumDevices_leds <- names(quantum_devices.mspct)
save(QuantumDevices_leds, quantum_devices.mspct, file = "data-raw/rda2merge/quantum-devices-mspct.rda")

assign(paste(osram, ".spct", sep = ""), shafi.mspct[[osram]])
save(list = paste(osram, ".spct", sep = ""), 
     file = paste("data-raw/maya-rda/osram/", osram, "-spct.rda", sep = ""))
