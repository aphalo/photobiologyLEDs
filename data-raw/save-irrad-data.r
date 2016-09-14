library(photobiology)
library(dplyr)


oldwd <- setwd("data-raw/Rda/")

leds <- paste(c("BS436", "CB30", "LED405", "LED740", "UV395", "white", 
                "XSL365", "XSL370", "XSL375", 
                "UVMAX340", "UVMAX305", "TY_UV310nm",
                "white", "Q36_4000K",
                "G_P30R140A1_XT", "HPR40E_48K30BG",
                "NHXRGB090_R", "NHXRGB090_G", "NHXRGB090_B"), ".spct", sep = "")

led.files <- paste(leds,".rda", sep = "")
for (l in led.files) {
  load(file = l)
  print(l)
}

led.spct.lst <- mget(leds)
names(led.spct.lst) <- sub(".spct", "", names(led.spct.lst))

leds.mspct <- source_mspct(led.spct.lst)

save(leds.mspct, file = "leds-mspct.rda")

# merge

load(file = "shafi-mspct.rda")

setwd(oldwd)

leds.mspct <- c(leds.mspct, shafi.mspct) 

roithner_laser <- 
  c("BS436", "CB30", "LED405", "LED740", "UV395", "LED435_66_60",
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
norlux <- c("NHXRGB090_R", "NHXRGB090_G", "NHXRGB090_B")
shenzhen_weilli <- leds_global <- ("G_P30R140A1_XT")
huey_jann <- "HPR40E-48K30BG"
led_engin <- NA

uv_leds <- c("UVMAX340", "UVMAX305", "XSL365", "XSL370", "XSL375",
             "G_P30R140A1_XT")
red_leds <- c("QDDH66002", "QDDH68002", "QDDH70002", "QDDH73502",
              "NHXRGB090_R", "LED740_01AV", "FR_OLD")
amber_leds <- c("LY5436")
green_leds <- c("NHXRGB090_G")
blue_leds <- c("NHXRGB090_B", "LED435_66_60")

save(leds.mspct, roithner_laser, seti, tao_yuan, unknown, lumitronix,
     hewlett_packard, quantum_devices, osram, norlux, shenzhen_weilli,
     leds_global, huey_jann, led_engin,
     uv_leds, red_leds, amber_leds, green_leds, blue_leds,
     file = "data/leds-mspct.rda")



