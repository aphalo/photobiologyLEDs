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

spct.names <- gsub("\\.[Rr]da$", "", basename(files))
split.names <- gsub("at|[_]*[AB]*001\\.spct.[Rr]da$", "",
                    basename(files)) |>
  strsplit("_", fixed = TRUE)
names(split.names) <- spct.names

base.how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H. Distance ="

weili.mspct <- source_mspct()
for (s in spct.names[c(1, 4, 6, 8, 9)]) {
  split.name <- split.names[[s]]
  new.name <- 
    paste("Weili_3W.nominal.", split.name[2], sep = "")
  how.measured <- 
    paste(base.how.measured, split.name[4], "at", split.name[3])
  comment.text <- paste("LED type unknown, nominal",
                        split.name[2],
                        "rated at 3W, \"bat wing\" package;\nsupplied by Shenzhen Weili Optical, Shenzhen, China; ca. 2015")
  what.measured <- "LED type unknown, rated at 3W, \"bat wing\" package"
  temp.spct <- get(s)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 6, span = 15, max.slope.delta = 0.0005)
  temp.spct <- trim_wl(temp.spct, range = c(300, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  print(new.name)
  weili.mspct[[new.name]] <- temp.spct
  readline("next:")
}

autoplot(weili.mspct, range = c(400, 700)) + 
  theme(legend.position = "none")
weili.mspct <- normalise(weili.mspct)

autoplot(weili.mspct, range = c(400, 700)) + 
  theme(legend.position = "none")
names(weili.mspct)

weili_array.mspct <- source_mspct()

weili_array.mspct[["Weili_120W.array.12ch.custom.A"]] <- 
  readRDS("data-raw/maya-rda/Weili/12-channels-arrays/weili_12ch_A.rds")
weili_array.mspct[["Weili_120W.array.12ch.custom.B"]] <- 
  readRDS("data-raw/maya-rda/Weili/12-channels-arrays/weili_12ch_B.rds")

weili_array.mspct[["Weili_50W.array.5ch.custom.I"]] <- 
  readRDS("data-raw/maya-rda/Weili/5-channels-arrays/weili_5ch_I.rds")
weili_array.mspct[["Weili_50W.array.5ch.custom.II"]] <- 
  readRDS("data-raw/maya-rda/Weili/5-channels-arrays/weili_5ch_II.rds")

setWhereMeasured(weili_array.mspct, na_geocode())
autoplot(weili_array.mspct[[1]])
autoplot(weili_array.mspct[[2]])
autoplot(weili_array.mspct[[3]])
autoplot(weili_array.mspct[[4]])

names(weili_array.mspct)

Weili_leds <- c(names(weili.mspct), names(weili_array.mspct))

save(Weili_leds, weili.mspct, weili_array.mspct, file = "data-raw/rda2merge/weili-mspct.rda")
