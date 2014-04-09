library(MayaCalc)

oldwd <- setwd("raw.data/Maya/examples")

BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
plot(BS436.data, type="l")

for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", "white", "XSL365", "XSL370", "XSL375")) {
  assign(paste(led, "data", sep="."), process_maya_files(paste(led, ".txt", sep=""), paste(led, "dark.txt", sep=""), 
                                                         method="full", decimal=","))
}

save(BS436.data, file=paste(oldwd, "/data/BS436.data.Rda", sep=""))
save(CB30.data, file=paste(oldwd, "/data/CB30.data.Rda", sep=""))
save(LED405.data, file=paste(oldwd, "/data/LED405.data.Rda", sep=""))
save(LED740.data, file=paste(oldwd, "/data/LED740.data.Rda", sep=""))
save(UV395.data, file=paste(oldwd, "/data/UV395.data.Rda", sep=""))
save(XSL365.data, file=paste(oldwd, "/data/XSL365.data.Rda", sep=""))
save(XSL370.data, file=paste(oldwd, "/data/XSL370.data.Rda", sep=""))
save(XSL375.data, file=paste(oldwd, "/data/XSL375.data.Rda", sep=""))

setwd(oldwd)

setwd("raw.data")

Norlux_R.data <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.data <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.data <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))

save(Norlux_R.data, Norlux_G.data, Norlux_B.data, file=paste(oldwd, "/data/Norlux_RGB.Rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Huey_Jann")

HJ_Blue.data <- process_maya_files("BLUE_short.txt", "dark_short.txt", "PC_long.txt", "BLUE_long.txt", "dark_long.txt", decimal=",", method="sun")
save(HJ_Blue.data, file=paste(oldwd, "/data/HJ_Blue.data.Rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Shenzhen_Weili")

SW_UVA365.data <- process_maya_files("UVA_short.txt", "dark_short.txt", "PC_long.txt", "UVA_long.txt", "dark_long.txt", decimal=",", method="sun")
save(SW_UVA365.data, file=paste(oldwd, "/data/SW_UVA365.data.Rda", sep=""))

setwd(oldwd)

