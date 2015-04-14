library(MayaCalc)
library(photobiology)

oldwd <- setwd("raw.data/Maya/examples")

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", "white", "XSL365", "XSL370", "XSL375", "white")) {
  temp.led.df <- process_maya_files(paste(led, ".txt", sep=""), paste(led, "dark.txt", sep=""), 
                                                         method="full", decimal=",")
  temp.led.spct <- e2q(setSourceSpct(temp.led.df))
  temp.led.spct[ , s.e.irrad.good := NULL]
  spct.name <- paste(led, "spct", sep=".")
  assign(spct.name, temp.led.spct)
  save(list=spct.name, file=paste(oldwd, "/data/", spct.name, ".rda", sep=""))
}

setwd(oldwd)

setwd("raw.data")

Norlux_R.df <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.df <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.df <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_R.spct <- e2q(setSourceSpct(Norlux_R.df))
Norlux_G.spct <- e2q(setSourceSpct(Norlux_G.df))
Norlux_B.spct <- e2q(setSourceSpct(Norlux_B.df))
save(Norlux_R.spct, Norlux_G.spct, Norlux_B.spct, file=paste(oldwd, "/data/Norlux_RGB.spct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Huey_Jann")

HJ_Blue.df <- process_maya_files("BLUE_short.txt", "dark_short.txt", "PC_long.txt", "BLUE_long.txt", "dark_long.txt", decimal=",", method="sun")
HJ_Blue.spct <- e2q(setSourceSpct(HJ_Blue.df))
HJ_Blue.spct[ , s.e.irrad.good := NULL]
save(HJ_Blue.spct, file=paste(oldwd, "/data/HJ_Blue.spct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Shenzhen_Weili")

SW_UVA365.df <- process_maya_files("UVA_short.txt", "dark_short.txt", "PC_long.txt", "UVA_long.txt", "dark_long.txt", decimal=",", method="sun")
SW_UVA365.spct <- e2q(setSourceSpct(SW_UVA365.df))
SW_UVA365.spct[ , s.e.irrad.good := NULL]
save(SW_UVA365.spct, file=paste(oldwd, "/data/SW_UVA365.spct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/LED_measurements_11_2014")

if (exists("TY_UV310nm.spct")) {
  upgrade(TY_UV310nm.spct)
  save(TY_UV310nm.spct, file=paste(oldwd, "/data/TY_UV310nm.spct.rda", sep=""))
} 

setwd(oldwd)

