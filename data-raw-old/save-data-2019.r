# scrip used to recompute some old data from Maya 2000Pro
# also adds metadata to some data without recomputing it

library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

rm(list = ls(pattern = "*"))
# recompute spectra using current ooacquire
# remove noise
# add metadata
path <- "data-raw/Maya/examples/"

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

# a.method <- MAYP11278_simple.mthd
a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2012-05-06"))
led_lowpower.lst <- list()
for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", 
              "XSL365", "XSL370", "XSL375", "white")) {
  temp.spct <- 
    s_irrad_corrected(list(
      light = paste(path, led, ".txt", sep = ""), 
      dark = paste(path, led, "dark.txt", sep = "")), 
      correction.method = a.method,
      descriptor = a.descriptor) %>%
    smooth_spct() %>%
    clean() %>%
 #   thin_wl() %>%
    normalize()
  setWhatMeasured(temp.spct, led)
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  led_lowpower.lst[[led]] <- temp.spct
#  assign(paste(led, "spct", sep="."), temp.led.spct)
}
led_lowpower.mspct <- source_mspct(led_lowpower.lst)
comment(led_lowpower.mspct) <- paste("Object created on ", today(), " with 'ooacquire' ", packageVersion('ooacquire'),
                                     " and 'photobiology' ", packageVersion('photobiology'), ".", sep = "")
comment(led_lowpower.mspct)
save(led_lowpower.mspct, file = "./data-raw/Rda/led-lowpower-mspct.rda")

rm(list = ls(pattern = "*"))
# read processed data (could be recomputed...)
# add metadata
#
Norlux_R.df <- read.table("data-raw/NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.df <- read.table("data-raw/NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.df <- read.table("data-raw/NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_R.spct <- as.source_spct(Norlux_R.df)
Norlux_R.spct <- trim_spct(Norlux_R.spct, range = c(250,900), byref = TRUE) %>%
  smooth_spct() %>%
  clean() %>%
#  thin_wl() %>%
  normalize()
comment(Norlux_R.spct) <- "Norlux 90 die LED array type NHXRGB0905005, red channel"
setWhatMeasured(Norlux_R.spct, "Norlux NHXRGB0905005, red channel")
setWhenMeasured(Norlux_R.spct, ymd("2013-11-27"))
setHowMeasured(Norlux_R.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")

Norlux_G.spct <- setSourceSpct(Norlux_G.df)
Norlux_G.spct <- trim_spct(Norlux_G.spct, range = c(250,900), byref = TRUE) %>%
  smooth_spct() %>%
  clean() %>%
#  thin_wl() %>%
  normalize()
comment(Norlux_G.spct) <- "Norlux 90 die LED array type NHXRGB0905005, green channel"
setWhatMeasured(Norlux_R.spct, "Norlux NHXRGB0905005, green channel")
setWhenMeasured(Norlux_R.spct, ymd("2013-11-27"))
setHowMeasured(Norlux_R.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")

Norlux_B.spct <- setSourceSpct(Norlux_B.df)
Norlux_B.spct <- trim_spct(Norlux_B.spct, range = c(250,900), byref = TRUE) %>%
  smooth_spct() %>%
  clean() %>%
#  thin_wl() %>%
  normalize()
comment(Norlux_B.spct) <- "Norlux 90 die LED array type NHXRGB0905005, blue channel"
setWhatMeasured(Norlux_R.spct, "Norlux NHXRGB0905005, blue channel")
setWhenMeasured(Norlux_R.spct, ymd("2013-11-27"))
setHowMeasured(Norlux_R.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")

Norlux_RGB.mspct <- source_mspct(list(red = Norlux_R.spct, 
                                      green = Norlux_G.spct, 
                                      blue = Norlux_B.spct))
save(Norlux_RGB.mspct,
     file = "./data-raw/Rda/Norlux_RGB.spct.rda")

rm(list = ls(pattern = "*"))
# recalculate spectral irradiance
# add metadata
path <- "./data-raw/Maya/Huey_Jann/"

a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2013-11-26"))
comments <- c(BLUE = "Blue LED (GaInN/GaN) array 30W type HPR40E-48K30BI from Huey-Jann (Taiwan)")
whats <- c(BLUE = "Huey-Jann HPR40E-48K30BI")
led_huey_jann.lst <- list()
for (led in c("BLUE")) {
  temp.spct <- 
    s_irrad_corrected(list(
      light = c(paste(path, led, "_short.txt", sep = ""), paste(path, led, "_long.txt", sep = "")),
      dark = c(paste(path, led, "_dark_short.txt", sep = ""), paste(path, led, "_dark_long.txt", sep = "")), 
      filter = c(paste(path, led, "_PC_short.txt", sep = ""), paste(path, led, "_PC_long.txt", sep = ""))),
      correction.method = a.method,
      descriptor = a.descriptor) %>%
    smooth_spct() %>%
    clean() %>%
#    thin_wl() %>%
    normalize()
  # as.source_spct(temp.led.df, time.unit = "second")
  comment(temp.spct) <- comments[led]
  setWhatMeasured(temp.spct, whats[led])
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  led_huey_jann.lst[[led]] <- temp.spct
  #  assign(paste(led, "spct", sep="."), temp.led.spct)
}

led_huey_jann.mspct <- source_mspct(led_huey_jann.lst)
comment(led_huey_jann.mspct) <- paste("Object created on ", today(), " with 'ooacquire' ", packageVersion('ooacquire'),
                                     " and 'photobiology' ", packageVersion('photobiology'), ".", sep = "")
comment(led_huey_jann.mspct)
save(led_huey_jann.mspct, file = "./data-raw/Rda/led-huey-jann-mspct.rda")


rm(list = ls(pattern = "*"))
# recalculate spectral irradiance
# add metadata
path <- "./data-raw/Maya/Shenzhen_Weili/"

a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2014-01-16"))
comments <- c(BLUE = "UVA LED array type G-P30R140A1-XT from Shenzhen Weili (China) url:https://www.leds-global.com/")
whats <- c(BLUE = "Shenzhen Weili G-P30R140A1-XT")
led_weili.lst <- list()
for (led in c("UVA")) {
  temp.spct <- 
    s_irrad_corrected(list(
      light = c(paste(path, led, "_short.txt", sep = ""), paste(path, led, "_long.txt", sep = "")),
      dark = c(paste(path, led, "_dark_short.txt", sep = ""), paste(path, led, "_dark_long.txt", sep = "")), 
      filter = c(paste(path, led, "_PC_short.txt", sep = ""), paste(path, led, "_PC_long.txt", sep = ""))),
      correction.method = a.method,
      descriptor = a.descriptor) %>%
    smooth_spct() %>%
    clean() %>%
#    thin_wl() %>%
    normalize()
  # as.source_spct(temp.led.df, time.unit = "second")
  comment(temp.spct) <- comments[led]
  setWhatMeasured(temp.spct, whats[led])
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  led_weili.lst[[led]] <- temp.spct
  #  assign(paste(led, "spct", sep="."), temp.led.spct)
}

led_weili.mspct <- source_mspct(led_weili.lst)
comment(led_weili.mspct) <- paste("Object created on ", today(), " with 'ooacquire' ", packageVersion('ooacquire'),
                                      " and 'photobiology' ", packageVersion('photobiology'), ".", sep = "")
comment(led_weili.mspct)
autoplot(led_weili.mspct)

save(led_weili.mspct, file = "./data-raw/Rda/led-weili-mspct.rda")


rm(list = ls(pattern = "*"))
# reformat data without recalculation (no raw data available)
# add metadata
path <- "./data-raw/Maya/LED_measurements_11_2014/"

load(paste(path, "uvb_led_tao_yuan.cal.spcs.Rda", sep = ""))

TaoYuan18mA.cal.spc %>%
  dplyr::select(-s.e.irrad.good) %>%
  as.source_spct() %>%
  smooth_spct() %>%
  clean() %>%
#  thin_wl() %>%
  normalize() -> taoyuan_UV310.spct

setWhatMeasured(taoyuan_UV310.spct, "TaoYuan LED 310nm")
setHowMeasured(taoyuan_UV310.spct, "Ocean Optics Maya 2000Pro")
comment(taoyuan_UV310.spct) <- "UVB LED from TaoYuan Optoelectronics (China) @ 18 mA current, SMD package, no window, no lens."

taoyuan.mspct <- source_mspct(list(taoyuan_UV310.spct))
comment(taoyuan.mspct) <- paste("Object created on ", today(), " with 'photobiology' ", packageVersion('photobiology'), ".", sep = "")
comment(taoyuan.mspct)
autoplot(taoyuan.mspct, span = 21)

save(taoyuan.mspct, file="./data-raw/Rda/taoyuan-mspct.rda")


