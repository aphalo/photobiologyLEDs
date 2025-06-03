library(photobiology)
library(ggspectra)
library(lubridate)

energy_as_default()

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

new.names <- paste("Weili_3W.nominal.", wavelengths, "nm", sep = "")
names(new.names) <- spct.names

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H."

weili.mspct <- source_mspct()
for (s in spct.names) {
  comment.text <- paste("LED type unknown, rated at 3W, \"bat wing\" package;\nsupplied by Shenzhen Weili Optical, Shenzhen, China; ca. 2015")
  what.measured <- "LED type unknown, rated at 3W, \"bat wing\" package"
  temp.spct <- get(s)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(300, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  weili.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(weili.mspct)
weili.mspct <- normalise(weili.mspct)

autoplot(weili.mspct)

weili_array.mspct <- source_mspct()
weili_array.mspct[["Weili_120W.array.12ch.custom.A"]] <- 
  readRDS("data-raw/maya-rda/Weili/12-channels-arrays/weili_12ch_A.rds")
weili_array.mspct[["Weili_120W.array.12ch.custom.B"]] <- 
  readRDS("data-raw/maya-rda/Weili/12-channels-arrays/weili_12ch_B.rds")

autoplot(weili_array.mspct[[1]])
autoplot(weili_array.mspct[[2]])

Weili_leds <- c(names(weili.mspct), names(weili_array.mspct))

save(Weili_leds, weili.mspct, weili_array.mspct, file = "data-raw/rda2merge/weili-mspct.rda")
