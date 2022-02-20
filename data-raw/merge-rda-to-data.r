library(photobiology)
library(photobiologyWavebands)
library(dplyr)

rm(list = ls(pattern = "*"))

path <- "./data-raw/rda2merge/"

# load collections of spectra

files2read <- list.files(path = path, pattern = "*[-.]mspct.rda$")
files2read <- setdiff(files2read, "leds-mspct.rda")
for (f in files2read) {
  load(paste(path, f, sep = ""))
}

# concatenate collections

collections2bind <- ls(pattern = "*.mspct$")
leds.mspct <- source_mspct()
for (mspct in mget(collections2bind)) {
  leds.mspct <- c(leds.mspct, mspct)
}
rm(list = c(collections2bind, "mspct"))

names(leds.mspct)

# leds.mspct <- leds.mspct[order(names(leds.mspct))]
# 
# names(leds.mspct)

# normalize all spectra to their maxima

# leds.mspct <- normalize(leds.mspct)

# names(leds.mspct)

# save collection

# save(leds.mspct, file = "leds-mspct.rda")

# metadata

how_measured.ls <- list()
for (s in names(leds.mspct)) {
  how_measured.ls[[s]] <- getHowMeasured(leds.mspct[[s]])
}

normalized.ls <- list()
for (s in names(leds.mspct)) {
  normalized.ls[[s]] <- getNormalised(leds.mspct[[s]])
}
peak.wl <- unlist(normalized.ls)

# led.whats <- list(#"BS436" = "Blue LED Roithner-Laser B5-436, 5mm",
#                   "LY5436" = "Amber LED Osram",
#                   "CB30" = "Blue LED Roithner-Laser CB30",
#                   "LED405" = "Violet LED (InGaN) Roithner-Laser LED405",
#                   "LED740" = "NIR LED Roithner-Laser LED740",
#                   "UV395" = "UVA LED Roithner-Laser UV395",
#                   "XSL365" = "UVA LED Roithner-Laser XSL-365-TF, TO46",
#                   "XSL370" = "UVA LED Roithner-Laser XSL-370-TF, TO46",
#                   "XSL375" = "UVA LED Roithner-Laser XSL-375-TF, TO46",
#                   "UVMAX340" = "UVA LED 340nm Roithner-Laser (SeTi UVCLEAN) type UVMAX340-HL-15 (TO3 hemispherical lens), measured at 100 mm distance from cosine difuser",
#                   "UVMAX305" = "UVA LED 310nm Roithner-Laser (SeTi UVCLEAN) type UVMAX305-HL-15 (TO3 hemispherical lens), measured at 100 mm distance from cosine difuser",
#                   "TY_UV310nm" = "UVB LED TaoYuan 310nm",
#                   "white" = "White LED from hardware store (Clas Ohlsson, Finland)",
#                   "Q36_4000K" = "White LED Lumitronix Q36 4000K (neutralwhite) array, SKU 53681, 36 Nichia 757 LEDs, 39W",
#                   "QDDH66002" = "Red LED 660nm Quantum Devices, 5mm epoxi package, 0.1W",
#                   "QDDH68002" = "Red LED 680nm Quantum Devices, 5mm epoxi package, 0.1W",
#                   "QDDH70002" = "Far-red LED 700nm Quantum Devices, 5mm epoxi package, 0.1W",
#                   "QDDH73002" = "Far-red LED 7300nm Quantum Devices, 5mm epoxi package, 0.1W"  #,
#                   )
# 
# what_measured(leds.mspct[["HPR40E_48K30BI"]]) <- unname(getWhatMeasured(leds.mspct[["HPR40E_48K30BI"]]))

what_measured.ls <- list()
for (s in names(leds.mspct)) {
  what_measured.ls[[s]] <- getWhatMeasured(leds.mspct[[s]])
}
# na_what <- names(what_measured.ls)[is.na(what_measured.ls)]
# short_what <- names(what_measured.ls)[grepl("^LED, type  ", what_measured.ls)]
# replace_what <- intersect(names(leds.mspct), names(led.whats))
# 
# for (s in replace_what) {
#   what_measured(leds.mspct[[s]]) <- led.whats[[s]]
# }

leds.mspct <- leds.mspct[order(names(leds.mspct))]

# Create category index vectors

# Assemble lists based on peak wavelengths

uv_leds <- names(leds.mspct)[peak.wl <= wl_max(UV())]
purple_leds <- names(leds.mspct)[peak.wl > wl_min(Purple()) &
                                   peak.wl <= wl_max(Purple())]
blue_leds <- names(leds.mspct)[peak.wl > wl_min(Blue()) &
                                   peak.wl <= wl_max(Blue())]
green_leds <- names(leds.mspct)[peak.wl > wl_min(Green()) &
                                  peak.wl <= wl_max(Green())]
yellow_leds <- names(leds.mspct)[peak.wl > wl_min(Yellow()) &
                                   peak.wl <= wl_max(Yellow())]
orange_leds <- names(leds.mspct)[peak.wl > wl_min(Orange()) &
                                   peak.wl <= wl_max(Orange())]
red_leds <-  names(leds.mspct)[peak.wl > wl_min(Red()) &
                                 peak.wl <= wl_max(Red())]
amber_leds <- sort(c(yellow_leds, orange_leds))
white_leds <- character()
grow_leds <- character()

multichannel_leds <- grep("RGB", names(leds.mspct), value = TRUE)

brands <- unique(character())
  
oo_maya_leds <- names(leds.mspct)

save(leds.mspct,  oo_maya_leds, multichannel_leds,
     uv_leds, purple_leds, blue_leds, green_leds, yellow_leds, 
     orange_leds, red_leds, amber_leds,
     white_leds,
     file = "data/leds-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
