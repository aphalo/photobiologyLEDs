library(photobiology)

rm(list = ls(pattern = "*"))
load(file = "raw.data/MayaMeasure/Lumitronix39W.cal.spcs.Rda")
if (is.old_spct(LUMITRONIX_white.spct)) upgrade_spct(LUMITRONIX_white.spct)
LUMITRONIX_white.spct <- as.source_spct(`full power DIM open.cal.spc`)
comment(LUMITRONIX_white.spct) <- "LUMITRONIX SmartArray Q36 LED-Module, 4247 lm, 4000K, 39W electrical"
save(LUMITRONIX_white.spct, file = "data/LUMITRONIX.white.spct.rda")
rm(`full power DIM open.cal.spc`)
cat(comment(LUMITRONIX_white.spct))
cat(class(LUMITRONIX_white.spct), "/n/n")

load(file = "raw.data/MayaMeasure/uvmax1.cal.spcs.Rda")

UVMAX305.spct <- as.source_spct(uvmax305_10cm.cal.spc)
# upgrade_spct(UVMAX305.spct)
comment(UVMAX305.spct) <- "Roithner-Laser (SeTi UVCLEAN) UVMAX305-HL-15 (hemispherical lens), 310 nm nominal, 10-15 mW optical, at 100 mm distance"
cat(comment(UVMAX305.spct))
cat(class(UVMAX305.spct), "/n/n")
save(UVMAX305.spct, file = "data/UVMAX305.spct.rda")

UVMAX340.spct <- as.source_spct(uvmax340_10cm.cal.spc)
# upgrade_spct(UVMAX340.spct)
comment(UVMAX340.spct) <- "Roithner-Laser (SeTi UVCLEAN) UVMAX340-HL-15 (hemispherical lens), 340 nm, 10-15 mW optical, at 100 mm distance"
cat(class(UVMAX340.spct), "/n/n")
cat(comment(UVMAX340.spct))

save(UVMAX340.spct, file = "data/UVMAX340.spct.rda")
