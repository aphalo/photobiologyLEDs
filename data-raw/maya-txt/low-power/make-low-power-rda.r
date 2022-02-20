library(ooacquire)
library(photobiology)
library(lubridate)
library(dplyr)

##!!!! The spectra for UV LEDs are very noisy or clipped
## Should be measured again
##!!!! VIS and FR ones are repeated in Shafi's data and redundant

rm(list = ls(pattern = "*"))
# recompute spectra using current ooacquire
# remove noise
# add metadata
path <- "data-raw/maya-txt/low-power/"

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

# a.method <- MAYP11278_simple.mthd
a.method <- MAYP11278_ylianttila.mthd
a.descriptor <- which_descriptor(ymd("2012-05-06"))


led_lowpower.mspct <- source_mspct()
for (led in c("BS436", "CB30", "LED740")) {
  # , "LED405", "UV395", "XSL365", "XSL370", "XSL375", "white"
  temp.spct <- 
    s_irrad_corrected(list(
      light = paste(path, led, ".txt", sep = ""), 
      dark = paste(path, led, "dark.txt", sep = "")), 
      correction.method = a.method,
      descriptor = a.descriptor)
  temp.spct <-smooth_spct(temp.spct)
  temp.spct <-clean(temp.spct)
  temp.spct <-normalize(temp.spct)
  temp.spct <-thin_wl(temp.spct)
  setWhatMeasured(temp.spct, paste("LED type", led, "from Roithner Laser, Austria; ca. 2005"))
  setHowMeasured(temp.spct, "Ocean Optics Maya 2000Pro")
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  led_lowpower.mspct[[led_names[led]]] <- temp.spct
#  assign(paste(led, "spct", sep="."), temp.led.spct)
}

summary(led_lowpower.mspct)

for (i in seq_along(led_lowpower.mspct)) {
  print(autoplot(led_lowpower.mspct[[i]], annotations = c("+", "title:what:when")))
  readline("next:")
}

save(led_lowpower.mspct, file = "./data-raw/rda2merge/led-lowpower-mspct.rda")

