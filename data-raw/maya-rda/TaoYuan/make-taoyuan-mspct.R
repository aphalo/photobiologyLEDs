library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/TaoYuan",
                    pattern = ".mspct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

names(taoyuan.mspct) <- "TaoYuan_LED_310nm"

uncollect2spct(taoyuan.mspct)

taoyuan <- "TaoYuan_LED_310nm"

how_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- 
  "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED current 18 mA."
what_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- 
  "SMD LED 310nm from TaoYuan"
when_measured(taoyuan.mspct[["TaoYuan_LED_310nm"]]) <- ymd("2015-07-30")

autoplot(taoyuan.mspct)

save(taoyuan, taoyuan.mspct, file = "data-raw/rda2merge/taoyuan-mspct.rda")
