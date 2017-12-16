library(photobiology)
library(dplyr)


oldwd <- setwd("data-raw/Rda/")

leds <- paste(c("BS436", "CB30", "LED405", "LED740", "UV395", "white", 
                "XSL365", "XSL370", "XSL375", 
                "UVMAX340", "UVMAX305", "TY_UV310nm",
                "white", "Q36_4000K",
                "LZ1_10DB00", "LZ1_10UA00_00U8", "LZ1_10UA00_00U4", 
                "LZ1_10UV00", "LZ1_10R302", 
                "G_P30R140A1_XT", 
                "weili430nm", "weili540nm", "weili665nm", "weili740nm",
                "HPR40E_48K30BG",
                "NHXRGB090_R", "NHXRGB090_G", "NHXRGB090_B"), ".spct", sep = "")

led.files <- paste(leds,".rda", sep = "")
for (l in led.files) {
  load(file = l)
  print(l)
}

led.spct.lst <- mget(leds)

names(led.spct.lst) <- sub(".spct", "", names(led.spct.lst))

leds.mspct <- source_mspct(led.spct.lst)

leds.mspct <- normalize(leds.mspct)

NHXRGB090.spct <- rbindspct(list(R = leds.mspct$NHXRGB090_R,
                                 G = leds.mspct$NHXRGB090_G,
                                 B = leds.mspct$NHXRGB090_B),
                            idfactor = "channel")

leds.mspct[["NHXRGB090"]] <- NHXRGB090.spct

save(leds.mspct, file = "leds-mspct.rda")

# merge

load(file = "shafi-mspct.rda")

setwd(oldwd)

shafi.mspct <- normalize(shafi.mspct)

leds.mspct <- c(leds.mspct, shafi.mspct) 

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
  c("G_P30R140A1_XT", "weili430nm", "weili540nm", "weili665nm", "weili740nm")
huey_jann <- "HPR40E_48K30BG"
led_engin <- c("LZ1_10DB00", "LZ1_10UA00_00U8", "LZ1_10UA00_00U4", 
               "LZ1_10UV00", "LZ1_10R302")

uv_leds <- c("UVMAX340", "UVMAX305", "XSL365", "XSL370", "XSL375",
             "G_P30R140A1_XT", "LZ1_10UA00_00U4", "LZ1_10UV00")
red_leds <- c("QDDH66002", "QDDH68002", "QDDH70002", "QDDH73502", 
              "weili740nm", "weili665nm",
              "NHXRGB090_R", "LED740_01AV", "FR_OLD", "LZ1_10R302")
amber_leds <- c("LY5436")
green_leds <- c("NHXRGB090_G", "weili540nm")
blue_leds <- c("NHXRGB090_B", "LED435_66_60", "weili430nm", "LZ1_10UA00_00U8")
white_leds <- c("white", "Q36_4000K")
multichannel_leds <- c("NHXRGB090")

oo_maya_leds <- names(leds.mspct)

save(leds.mspct, roithner_laser, seti, tao_yuan, unknown, lumitronix,
     hewlett_packard, quantum_devices, osram, norlux, shenzhen_weili,
     leds_global, huey_jann, led_engin, oo_maya_leds,
     uv_leds, red_leds, amber_leds, green_leds, blue_leds,
     white_leds, multichannel_leds,
     file = "data/leds-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
