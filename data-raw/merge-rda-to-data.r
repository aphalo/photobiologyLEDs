library(photobiology)
library(photobiologyInOut)
library(photobiologyWavebands)
library(dplyr)
library(stringr)

energy_as_default()

rm(list = ls(pattern = "*"))

load("./data-raw/MAY11278-desc-donnor.rda")

add_instr_desc <- function(receptor, donnor = MAYP11278_cal_2023a.spct) {
  stopifnot(is.generic_spct(receptor), is.generic_spct(donnor))

  receptor.desc <- getInstrDesc(receptor)
  if (getMultipleWl(receptor) > 1) {
    receptor.desc <- receptor.desc[[1]]
  }
  
  donnor.desc <- 
    getInstrDesc(
      trimInstrDesc(donnor, 
                    fields = c("spectrometer.name", "spectrometer.sn", "bench.grating",
                               "bench.slit", "entrance.optics")
                    )
      )
  
  if (all(is.na(receptor.desc))) {
    setInstrDesc(receptor, donnor.desc)
  } else if (receptor.desc$spectrometer.sn == donnor.desc$spectrometer.sn &&
      !"entrance.optics" %in% names(receptor.desc)) {
    receptor.desc$entrance.optics <- donnor.desc$entrance.optics
    setInstrDesc(receptor, receptor.desc)
  } else {
    receptor
  }
}

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

# To make use easier, we separate multichannel and single channel LEDs
multiple_wl <- sapply(leds.mspct, function(x) {getMultipleWl(x) > 1})

led_arrays.mspct <- leds.mspct[multiple_wl]

# we do not normalise multichannel LED spectra

leds.mspct <- leds.mspct[-which(multiple_wl)]

# we normalise spectra for single channel LED spectra
for (s in names(leds.mspct)) {
  leds.mspct[[s]] <- add_instr_desc(leds.mspct[[s]])
  leds.mspct[[s]] <- setNormalised(leds.mspct[[s]], FALSE)
  leds.mspct[[s]] <- normalize(leds.mspct[[s]])
}

# metadata

how_measured.ls <- list()
for (s in names(leds.mspct)) {
  how_measured.ls[[s]] <- getHowMeasured(leds.mspct[[s]])
}

# Distinguish by number of channels
multi_channel_leds <- grep("RGB|LZ7|array.12ch", names(leds.mspct), value = TRUE)
single_channel_leds <- grep("RGB|LZ7|array.12ch", names(leds.mspct), value = TRUE, invert = TRUE)

# All should be normalised
normalized.ls <- list()
for (s in names(leds.mspct)) {
  normalized.ls[[s]] <- getNormalised(leds.mspct[[s]])
}
peak.wl <- unlist(normalized.ls)
peak.wl <- ifelse(peak.wl < 100, NA, peak.wl)

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

# Assemble vectors of names based on peak wavelengths

# as the spectra are normalised, a broad spectrum will have a large integral
white_leds <- single_channel_leds[q_irrad(leds.mspct[single_channel_leds], allow.scaled = TRUE)[["Q_Total"]] > 100]

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

led_uses <- c("plant_grow", "high_CRI")

plant_grow_leds <- c("Luminus_CXM_14_HS_12_36_AC30",
                     "Nichia_NFSW757G_Rsp0a",
                     "Nichia_NFSL757GT_Rsp0a",
                     "Ledguhon_10WBVG14G24_Y6C_T4",
                     "Ledguhon_10WBVGIR14G24_Y6C_T4",
                     "LCFOCUS_LC_10FSCOB1917_4000",
                     "Osram_GW_CSSRM3.HW")

CRI <- sapply(leds.mspct[white_leds], spct_CRI, tol = 0.1)

high_CRI_leds <- names(CRI)[!is.na(CRI) & CRI > 95]
white_leds <- names(CRI)[!is.na(CRI)]

# Vector of brands as used when naming member spectra

led_brands <- unique(str_split(names(leds.mspct), "_", simplify = TRUE)[ , 1])

# Vectors based on how spectra were acquired  
oo_maya_leds <- names(leds.mspct)[grep("Maya", how_measured(leds.mspct)[["how.measured"]])]

length(leds.mspct)

objects_to_save <-
  c("leds.mspct", "led_arrays.mspct", "led_brands", "led_colors", "led_uses",
    ls(pattern = "_leds$"))

save(list = objects_to_save,
     file = "data/leds-mspct.rda")

tools::resaveRdaFiles("data", compress="auto")
print(tools::checkRdaFiles("data"))

