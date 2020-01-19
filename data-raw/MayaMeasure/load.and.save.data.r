library(photobiology)
library(lubridate)

rm(list = ls(pattern = "*"))
load(file = "data-raw/MayaMeasure/Lumitronix39W.cal.spcs.Rda")
LUMITRONIX_white.spct <- as.source_spct(`full power DIM open.cal.spc`) %>%
  dplyr::select(-s.e.irrad.good)
# if (is.old_spct(LUMITRONIX_white.spct)) upgrade_spct(LUMITRONIX_white.spct)
comment(LUMITRONIX_white.spct) <- "LUMITRONIX SmartArray Q36 LED-Module, 4247 lm, 4000K, 39W electrical"
setWhatMeasured(LUMITRONIX_white.spct, "LUMITRONIX SmartArray Q36 4000K")
setHowMeasured(LUMITRONIX_white.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")
setWhenMeasured(LUMITRONIX_white.spct, 
                ymd_hms(file.mtime("data-raw/MayaMeasure/Lumitronix39W.cal.spcs.Rda"), 
                        tz = "EET"))
save(LUMITRONIX_white.spct, file = "data-raw/Rda/LUMITRONIX.white.spct.rda")
rm(`full power DIM open.cal.spc`)
cat(comment(LUMITRONIX_white.spct))
cat(class(LUMITRONIX_white.spct), "\n")
LUMITRONIX_white.spct

rm(list = ls(pattern = "*"))
load(file = "data-raw/MayaMeasure/uvmax1.cal.spcs.Rda")

UVMAX305.spct <- as.source_spct(uvmax305_10cm.cal.spc) %>%
  dplyr::select(-s.e.irrad.good)
# upgrade_spct(UVMAX305.spct)
comment(UVMAX305.spct) <- "Roithner-Laser (SeTi UVCLEAN) UVMAX305-HL-15 (hemispherical lens), 310 nm nominal, 10-15 mW optical, at 100 mm distance"
setWhatMeasured(UVMAX305.spct, "Roithner-Laser UVMAX305-HL-15")
setHowMeasured(UVMAX305.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")
setWhenMeasured(UVMAX305.spct, 
                ymd_hms(file.mtime("data-raw/MayaMeasure/Lumitronix39W.cal.spcs.Rda"), 
                        tz = "EET"))
cat(comment(UVMAX305.spct))
cat(class(UVMAX305.spct), "\n")
save(UVMAX305.spct, file = "data-raw/Rda/UVMAX305.spct.rda")

UVMAX340.spct <- as.source_spct(uvmax340_10cm.cal.spc) %>%
  dplyr::select(-s.e.irrad.good)
# upgrade_spct(UVMAX340.spct)
comment(UVMAX340.spct) <- "Roithner-Laser (SeTi UVCLEAN) UVMAX340-HL-15 (hemispherical lens), 340 nm, 10-15 mW optical, at 100 mm distance"
setWhatMeasured(UVMAX305.spct, "Roithner-Laser UVMAX340-HL-15")
setHowMeasured(UVMAX305.spct, "Ocean Optics Maya 2000Pro (HDR and straylight correction used)")
setWhenMeasured(UVMAX305.spct, 
                ymd_hms(file.mtime("data-raw/MayaMeasure/Lumitronix39W.cal.spcs.Rda"), 
                        tz = "EET"))
cat(class(UVMAX340.spct), "\n")
cat(comment(UVMAX340.spct))

save(UVMAX340.spct, file = "data-raw/Rda/UVMAX340.spct.rda")
