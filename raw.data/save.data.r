library(MayaCalc)
library(photobiology)
library(data.table)

oldwd <- setwd("raw.data/Maya/examples")

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", "white", "XSL365", "XSL370", "XSL375", "white")) {
  temp.led.dt <- process_maya_files(paste(led, ".txt", sep=""), paste(led, "dark.txt", sep=""), 
                                                         method="full", decimal=",")
  setattr(temp.led.dt, "class", c("source.spct", "generic.spct", class(temp.led.dt)))
#  setDT(temp.led.dt)
  temp.led.dt[ , s.q.irrad := as_quantum_mol(w.length, s.e.irrad)]
  temp.led.dt[ , s.e.irrad.good := NULL]
  dt.name <- paste(led, "dt", sep=".")
  assign(dt.name, temp.led.dt)
  save(list=dt.name, file=paste(oldwd, "/data/", led, ".dt.rda", sep=""))
}

setwd(oldwd)

setwd("raw.data")

Norlux_R.dt <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.dt <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.dt <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))
class(Norlux_R.dt) <- c("source.spct", "generic.spct", class(Norlux_R.dt))
class(Norlux_G.dt) <- c("source.spct", "generic.spct", class(Norlux_G.dt))
class(Norlux_B.dt) <- c("source.spct", "generic.spct", class(Norlux_B.dt))
setDT(Norlux_R.dt)
setDT(Norlux_G.dt)
setDT(Norlux_B.dt)
save(Norlux_R.dt, Norlux_G.dt, Norlux_B.dt, file=paste(oldwd, "/data/Norlux_RGB.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Huey_Jann")

HJ_Blue.dt <- process_maya_files("BLUE_short.txt", "dark_short.txt", "PC_long.txt", "BLUE_long.txt", "dark_long.txt", decimal=",", method="sun")
setattr(HJ_Blue.dt, "class", c("source.spct", "generic.spct", class(HJ_Blue.dt)))
# setDT(HJ_Blue.dt) # redundant
HJ_Blue.dt[ , s.q.irrad := as_quantum_mol(w.length, s.e.irrad)]
HJ_Blue.dt[ , s.e.irrad.good := NULL]
save(HJ_Blue.dt, file=paste(oldwd, "/data/HJ_Blue.dt.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Shenzhen_Weili")

SW_UVA365.dt <- process_maya_files("UVA_short.txt", "dark_short.txt", "PC_long.txt", "UVA_long.txt", "dark_long.txt", decimal=",", method="sun")
setattr(SW_UVA365.dt, "class", c("source.spct", "generic.spct", class(SW_UVA365.dt)))
# setDT(SW_UVA365.dt) # redundant
SW_UVA365.dt[ , s.q.irrad := as_quantum_mol(w.length, s.e.irrad)]
SW_UVA365.dt[ , s.e.irrad.good := NULL]
save(SW_UVA365.dt, file=paste(oldwd, "/data/SW_UVA365.dt.rda", sep=""))

setwd(oldwd)

