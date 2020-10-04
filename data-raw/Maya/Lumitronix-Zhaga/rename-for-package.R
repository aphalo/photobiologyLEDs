library(photobiology)
library(tibble)
library(lubridate)

files <- list.files("./data-raw/Maya/Lumitronix-Zhaga", pattern = "*Rda", full.names = TRUE)
obj.names <- gsub(".Rda", "", list.files("./data-raw/Maya/Lumitronix-Zhaga", pattern = "*Rda", full.names = FALSE)) 
zhaga_names <- gsub(".2.spct|.spct", "", obj.names) 
zhaga_names <- gsub("horticulture", "Rsp0A", zhaga_names)
zhaga_names <- gsub("Nichia.", "", zhaga_names)
what <- gsub("[.]", " ", zhaga_names)
what <- gsub("SunLike", "Toshiba-SSC SunLike TRI-R CRI97+, in Lumitronix Zhaga module", what)
what <- gsub("Rsp0A", "757 Rsp0A for horticulture, in Lumitronix Zhaga module", what)
what <- gsub("OptiSolis", "757G Optisolis Solar White CRI98+, in Lumitronix Zhaga module", what)
how <- "Ocean Optics Maya 2000Pro (HDR used)."


# zhaga_names <- paste(zhaga_names, ".spct", sep = "")
zhaga.mspct <- source_mspct()
for (i in seq_along(files)) {
  load(file = files[i])
  tmp <- get(obj.names[i])
  tmp <- clean(tmp)
  setWhatMeasured(tmp, what[i])
  setHowMeasured(tmp, how)
  setWhenMeasured(tmp, ymd_hms(file.mtime(files[i]), 
                               tz = "EET"))
  trimInstrDesc(tmp)
  trimInstrSettings(tmp)
  zhaga.mspct[[zhaga_names[i]]] <- tmp
}

names(zhaga.mspct)

save(zhaga_names, zhaga.mspct, file = "./data-raw/Rda/zhaga.mspct.rda")

