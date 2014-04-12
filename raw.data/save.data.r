library(MayaCalc)
library(photobiology)

oldwd <- setwd("raw.data/Maya/examples")

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", "white", "XSL365", "XSL370", "XSL375", "white")) {
  temp.led.dt <- process_maya_files(paste(led, ".txt", sep=""), paste(led, "dark.txt", sep=""), 
                                                         method="full", decimal=",")
  temp.led.dt$s.q.irrad <- with(temp.led.dt, as_quantum_mol(w.length, s.e.irrad))
  dt.name <- paste(led, "data", sep=".")
  assign(dt.name, temp.led.dt)
  save(list=dt.name, file=paste(oldwd, "/data/", led, ".data.rda", sep=""))
}

setwd(oldwd)

setwd("raw.data")

Norlux_R.data <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.data <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.data <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))

save(Norlux_R.data, Norlux_G.data, Norlux_B.data, file=paste(oldwd, "/data/Norlux_RGB.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Huey_Jann")

HJ_Blue.data <- process_maya_files("BLUE_short.txt", "dark_short.txt", "PC_long.txt", "BLUE_long.txt", "dark_long.txt", decimal=",", method="sun")
save(HJ_Blue.data, file=paste(oldwd, "/data/HJ_Blue.data.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Shenzhen_Weili")

SW_UVA365.data <- process_maya_files("UVA_short.txt", "dark_short.txt", "PC_long.txt", "UVA_long.txt", "dark_long.txt", decimal=",", method="sun")
save(SW_UVA365.data, file=paste(oldwd, "/data/SW_UVA365.data.rda", sep=""))

setwd(oldwd)

