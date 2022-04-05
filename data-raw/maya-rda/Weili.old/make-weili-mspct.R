library(photobiology)
library(ggspectra)
library(lubridate)

# photon_as_default()

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Weilli",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spct.names <- ls(pattern = "*[.]spct")[c(1, 3, 4, 5, 6, 7, 8)]
# spct.names <- gsub(".[Rr]da", "", basename(files))
names <- gsub(".spct", "", spct.names)

weili.mspct <- source_mspct(mget(spct.names))
names(weili.mspct) <- names
names(weili.mspct)

for (s in names) {
  how_measured(weili.mspct[[s]]) <-
    "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 18 mA."

 print(autoplot(weili.mspct[[s]], annotations(c("+", "title"))))
  readline("next: ")
}

how_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- 
  "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 18 mA."
what_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- 
  "SMD LED 310nm from TaoYuan, China; ca. 2012"
when_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- ymd("2015-07-30")

autoplot(taoyuan.mspct)

save(taoyuan, taoyuan.mspct, file = "data-raw/rda2merge/taoyuan-mspct.rda")
