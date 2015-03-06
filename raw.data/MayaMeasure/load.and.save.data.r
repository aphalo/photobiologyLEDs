rm(list = ls(pattern = "*"))
load(file = "raw.data/MayaMeasure/Lumitronix39W.cal.spcs.Rda")
dimmed100pc.cal.spc <- `full power DIM open.cal.spc`
rm(`full power DIM open.cal.spc`)
cat(comment(dimmed100pc.cal.spc))
plot(dimmed100pc.cal.spc)

load(file = "raw.data/MayaMeasure/uvmax1.cal.spcs.Rda")
UVMAX305.spct <- uvmax305_10cm.cal.spc
UVMAX340.spct <- uvmax340_10cm.cal.spc
save(UVMAX305.spct, file = "data/uvmax305.spct.rda")
save(UVMAX340.spct, file = "data/uvmax340.spct.rda")
