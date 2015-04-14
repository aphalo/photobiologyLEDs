library(photobiology)
library(photobiologygg)

rm(list = ls(pattern = "*"))
load(file = "raw.data/MayaMeasure/Lumitronix39W.cal.spcs.Rda")
LUMITRONIX_white.spct <- `full power DIM open.cal.spc`
if (!is.any_spct(LUMITRONIX_white.spct)) upgrade(LUMITRONIX_white.spct)
save(LUMITRONIX_white.spct, file = "data/LUMITRONIX.white.spct.rda")
rm(`full power DIM open.cal.spc`)
cat(comment(LUMITRONIX_white.spct))
plot(LUMITRONIX_white.spct)

load(file = "raw.data/MayaMeasure/uvmax1.cal.spcs.Rda")
UVMAX305.spct <- uvmax305_10cm.cal.spc
upgrade(UVMAX305.spct)
UVMAX340.spct <- uvmax340_10cm.cal.spc
upgrade(UVMAX340.spct)
save(UVMAX305.spct, file = "data/UVMAX305.spct.rda")
save(UVMAX340.spct, file = "data/UVMAX340.spct.rda")
