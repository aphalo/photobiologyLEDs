oldwd <- setwd("data-raw")

NHXRGB090_R.spct <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
NHXRGB090_G.spct <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
NHXRGB090_B.spct <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))
NHXRGB090_R.spct <- setSourceSpct(NHXRGB090_R.spct)
trim_spct(NHXRGB090_R.spct, range = c(250,900), byref = TRUE)
comment(NHXRGB090_R.spct) <- "Norlux 90 die LED array type NHXRGB0905005, red channel"
NHXRGB090_G.spct <- setSourceSpct(NHXRGB090_G.spct)
trim_spct(NHXRGB090_G.spct, range = c(250,900), byref = TRUE)
comment(NHXRGB090_G.spct) <- "Norlux 90 die LED array type NHXRGB0905005, green channel"
NHXRGB090_B.spct <- setSourceSpct(NHXRGB090_B.spct)
trim_spct(NHXRGB090_B.spct, range = c(250,900), byref = TRUE)
comment(NHXRGB090_B.spct) <- "Norlux 90 die LED array type NHXRGB0905005, blue channel"

for (l in c("NHXRGB090_R.spct", "NHXRGB090_G.spct", "NHXRGB090_B.spct")) {
  print(l)
  save(list = l, file=paste(oldwd, "/data-raw/Rda/", l, ".rda", sep=""))
} 

setwd(oldwd)
