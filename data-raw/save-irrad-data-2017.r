library(photobiology)
library(dplyr)


oldwd <- setwd("data-raw/Rda/")

led.names <- c("BS436", "CB30", "LED405", "LED740", "UV395",
               "XSL365", "XSL370", "XSL375", 
               "UVMAX340", "UVMAX305", "TY_UV310nm",
               "white", "Q36_4000K",
               "G_P30R140A1_XT", 
               "weili430nm", "weili540nm", "weili665nm", "weili740nm",
               "HPR40E_48K30BG",
               "NHXRGB090_R", "NHXRGB090_G", "NHXRGB090_B")

led.whats <- list("BS436" = "", 
                  "CB30" = "", 
                  "LED405" = "", 
                  "LED740" = "", 
                  "UV395" = "",
                  "XSL365" = "", 
                  "XSL370" = "", 
                  "XSL375" = "", 
                  "UVMAX340" = "UVA LED 340nm Roithner-Laser (SeTi UVCLEAN) type UVMAX340-HL-15 (hemispherical lens), measured at 100 mm distance from cosine difuser",
                  "UVMAX305" = "UVA LED 310nm Roithner-Laser (SeTi UVCLEAN) type UVMAX305-HL-15 (hemispherical lens), measured at 100 mm distance from cosine difuser", 
                  "TY_UV310nm" = "",
                  "white" = "White LED from hardware store\nsupplier Clas Ohlsson, Finland", 
                  "Q36_4000K" = "",
                  "G_P30R140A1_XT" = "", 
                  "weili430nm" = "", 
                  "weili540nm" = "", 
                  "weili665nm" = "", 
                  "weili740nm" = "",
                  "HPR40E_48K30BG" = "",
                  "NHXRGB090_R" = "", 
                  "NHXRGB090_G" = "", 
                  "NHXRGB090_B" = "")

leds.objs <- paste(led.names, ".spct", sep = "")
led.files <- paste(leds.objs,".rda", sep = "")

for (l in led.files) {
  load(file = l)
  print(l)
}

led.spct.lst <- source_mspct(mget(leds.objs))

names(led.spct.lst) <- led.names

stopifnot(length(led.spct.lst) == length(leds.objs))

for (n in led.names) {
  temp <- led.spct.lst[[n]]
  temp <- q2e(temp, action = "replace")
  if ("s.e.irrad.good" %in% names(temp)) {
     temp[["s.e.irrad.good"]] <- NULL
  }
  what <- led.whats[[n]]
  if (what == "" && is.na(getWhatMeasured(temp))) {
    what <- comment(temp)
  }
  if (what[1] != "") {
    temp <- setWhatMeasured(temp, what[1])
  }
  print(n)
  print(getWhatMeasured(temp))
  led.spct.lst[[n]] <- temp
}

# names(led.spct.lst) <- led.names
# 
# leds.mspct <- source_mspct(led.spct.lst)

leds.mspct <- normalize(led.spct.lst)

NHXRGB090.spct <- rbindspct(list(R = leds.mspct$NHXRGB090_R,
                                 G = leds.mspct$NHXRGB090_G,
                                 B = leds.mspct$NHXRGB090_B),
                            idfactor = "channel")

leds.mspct[["NHXRGB090"]] <- NHXRGB090.spct

save(leds.mspct, file = "leds-mspct.rda")

rm(list = leds.objs)
rm(temp, l, what)

# merge

load(file = "shafi-mspct.rda")
load(file = "LEDEngin2017.mspct.rda")
load(file = "Nichia_white.mspct.rda")
load(file = "weili_3W.mspct.rda")
load(file = "Marktech.mspct.rda")

setwd(oldwd)

shafi.mspct <- normalize(shafi.mspct)

leds.mspct <- c(leds.mspct, shafi.mspct, LEDEngin2017.mspct, Nichia_white.mspct, weili_3w.mspct, Marktech.mspct) 

length(leds.mspct)

roithner_laser <- 
  c("BS436", "LED405", "LED740", "UV395", "LED435_66_60",
    "LED740_01AV", "B5_436_30D", "UVMAX340", "UVMAX305", 
    "XSL365", "XSL370", "XSL375")
seti <- c("UVMAX340", "UVMAX305", "XSL365", "XSL370", "XSL375")
tao_yuan <- "TY_UV310nm"
unknown <- c("white", "FR_OLD")
lumitronix <- "Q36_4000K"
hewlett_packard <- agilent <- c("HLMB_CB30", "HLMP_CB31", "HLMP_CM30", 
                                "HLMP_CM31", "HLMP_DJ32", "HLMP_DL32")
quantum_devices <- c("QDDH66002", "QDDH68002", "QDDH70002", "QDDH73502")
osram <- "LY5436"
norlux <- c("NHXRGB090_R", "NHXRGB090_G", "NHXRGB090_B", "NHXRGB090")
shenzhen_weili <- leds_global <- 
  c("G_P30R140A1_XT", "weili430nm", "weili540nm", "weili665nm", "weili740nm", weili_3W_names)
huey_jann <- "HPR40E_48K30BG"
led_engin <- LEDEngin2017_names
marktech <- Marktech_names
nichia <- Nichia_white_names

all.mfct <- unique(c(roithner_laser, seti, tao_yuan, unknown, lumitronix, hewlett_packard, 
             quantum_devices, osram, norlux, shenzhen_weili, huey_jann, led_engin, marktech))
setdiff(all.mfct, names(leds.mspct))

uv_leds <- c("UVMAX340", "UVMAX305", "XSL365", "XSL370", "XSL375",
             "G_P30R140A1_XT", "LZ1_10UA00_00U4", "LZ1_10UV00", marktech)
red_leds <- c("QDDH66002", "QDDH68002", "QDDH70002", "QDDH73502", 
              "weili740nm", "weili665nm",
              "NHXRGB090_R", "LED740_01AV", "FR_OLD", "LZ1_10R302", "LZ4_10R208")
amber_leds <- c("LY5436")
green_leds <- c("NHXRGB090_G", "weili540nm", "G_P3V140A1_YG", "G_P3V140A1_YG1")
cyan_leds <- c("G_P3V140B1_G" , "G_P3V140B1_GT")
blue_leds <- c("NHXRGB090_B", "LED435_66_60", "weili430nm", "LZ1_10UA00_00U8", "LZ1_10DB00")
violet_leds <- c("LZ1_10UA00_U4", "LZ1_10UA00_U8")
white_leds <- c("white", "Q36_4000K")
multichannel_leds <- c("NHXRGB090")

oo_maya_leds <- names(leds.mspct)

save(leds.mspct, roithner_laser, seti, tao_yuan, unknown, lumitronix,
     hewlett_packard, quantum_devices, osram, norlux, shenzhen_weili,
     leds_global, huey_jann, led_engin, nichia, marktech, oo_maya_leds,
     uv_leds, violet_leds, red_leds, amber_leds, green_leds, cyan_leds, blue_leds,
     white_leds, multichannel_leds,
     file = "data/leds-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))


