library(photobiology)
library(photobiologyWavebands)
library(dplyr)
library(stringr)

rm(list = ls(pattern = "*"))

path <- "./data-raw/rda2merge/"

# load collections of spectra

files2read <- list.files(path = path, pattern = ".*[-.]mspct.rda$")
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

leds.mspct <- leds.mspct[order(names(leds.mspct))]
# leds.mspct <- normalize(leds.mspct, norm = "max", unit.out = "energy")

# Distinguish by number of channels
multi_channel_leds <- grep("RGB", names(leds.mspct), value = TRUE)
single_channel_leds <- grep("RGB", names(leds.mspct), value = TRUE, invert = TRUE)

# Assemble vectors of names based on peak wavelengths

# as the spectra are normalised, a broad spectrum with have a large integral
white_leds <- single_channel_leds[q_irrad(leds.mspct[single_channel_leds], allow.scaled = TRUE)[["Q_Total"]] > 3e-4]

names_single <- setdiff(single_channel_leds, white_leds)

peak.wl_single <- peak.wl[names_single]
names_single == names(peak.wl_single)
peak.wl_single <- unname(peak.wl_single)

uv_leds <- names_single[peak.wl_single <= wl_max(UV())]
ir_leds <- names_single[peak.wl_single > 700]
purple_leds <- names_single[peak.wl_single > wl_max(UV()) &
                              peak.wl_single <= wl_max(Purple())]
blue_leds <- names_single[peak.wl_single > wl_min(Blue()) &
                            peak.wl_single <= wl_max(Blue())]
green_leds <- names_single[peak.wl_single > wl_min(Green()) &
                             peak.wl_single <= wl_max(Green())]
yellow_leds <- names_single[peak.wl_single > wl_min(Yellow()) &
                              peak.wl_single <= wl_max(Yellow())]
orange_leds <- names_single[peak.wl_single > wl_min(Orange()) &
                              peak.wl_single <= wl_max(Orange())]
red_leds <-  names_single[peak.wl_single > wl_min(Red()) &
                            peak.wl_single <= wl_max(Red())]
amber_leds <- sort(c(yellow_leds, orange_leds))

led_colors <- c("uv", "purle", "blue", "green", "yellow", "orange", "red", "ir")

# Vector of brands as used when naming member spectra

led_brands <- unique(str_split(names(leds.mspct), "_", simplify = TRUE)[ , 1])

# Vectors based on how spectra were acquired  
oo_maya_leds <- names(leds.mspct)[grep("Maya", how_measured(leds.mspct)[["how.measured"]])]

objects_to_save <- c("leds.mspct", "led_brands", "led_colors", ls(pattern = "_leds$"))

save(list = objects_to_save,
     file = "data/leds-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))
