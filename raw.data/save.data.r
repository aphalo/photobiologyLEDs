library(MayaCalc)
library(photobiology)
library(dplyr)

oldwd <- setwd("raw.data/Maya/examples")

# BS436.data <- process_maya_files("BS436.txt", "BS436dark.txt", method="sun", decimal=",")
# plot(BS436.data, type="l")

led_lowpower.lst <- list()
for (led in c("BS436", "CB30", "LED405", "LED740", "UV395", "white", "XSL365", "XSL370", "XSL375", "white")) {
  temp.led.df <- process_maya_files(paste(led, ".txt", sep=""), paste(led, "dark.txt", sep=""), 
                                                         method="full", decimal=",")
  temp.led.df <- temp.led.df[ , c("w.length", "s.e.irrad")]
#  temp.led.spct <- e2q(setSourceSpct(temp.led.df))
  setSourceSpct("temp.led.df", time.unit = "second")
  led_lowpower.lst[[led]] <- temp.led.df
#  spct.name <- paste(led, "spct", sep=".")
  
#  assign(spct.name, temp.led.spct)
}
setSourceMspct(led_lowpower.lst)
save(list=led_lowpower.lst, file=paste(oldwd, "/data/", spct.name, ".rda", sep=""))

setwd(oldwd)

oldwd <- setwd("raw.data")

Norlux_R.df <- read.table("NHXRGB0905005_RED.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_G.df <- read.table("NHXRGB0905005_GREEN.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_B.df <- read.table("NHXRGB0905005_BLUE.txt", col.names=c("w.length", "s.e.irrad"))
Norlux_R.spct <- setSourceSpct(Norlux_R.df)
trim_spct(Norlux_R.spct, range = c(250,900), byref = TRUE)
comment(Norlux_R.spct) <- "Norlux 90 die LED array type NHXRGB0905005, red channel"
Norlux_G.spct <- setSourceSpct(Norlux_G.df)
trim_spct(Norlux_G.spct, range = c(250,900), byref = TRUE)
comment(Norlux_G.spct) <- "Norlux 90 die LED array type NHXRGB0905005, green channel"
Norlux_B.spct <- setSourceSpct(Norlux_B.df)
trim_spct(Norlux_B.spct, range = c(250,900), byref = TRUE)
comment(Norlux_B.spct) <- "Norlux 90 die LED array type NHXRGB0905005, blue channel"
Norlux_RGB.mspct <- source_mspct(list(red = Norlux_R.spct, 
                                      green = Norlux_G.spct, 
                                      blue = Norlux_B.spct))
save(Norlux_RGB.mspct,
     file=paste(oldwd, "/data/Norlux_RGB.spct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Huey_Jann")

HJ_Blue.df <- process_maya_files("BLUE_short.txt", "dark_short.txt", "PC_long.txt", "BLUE_long.txt", "dark_long.txt", decimal=",", method="sun")
HJ_Blue.df <- HJ_Blue.df[ , c("w.length", "s.e.irrad")]
HJ_Blue.spct <- setSourceSpct(HJ_Blue.df)
Huey_Jann.mspct <- Huey_Jann.mspct(list(Blue_.spct))
save(Huey_Jann.mspct, file=paste(oldwd, "/data/Huey_Jann.mspct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/Shenzhen_Weili")

if (!exists("TY_UV310nm.spct")) {
SW_UVA365.df <- process_maya_files("UVA_short.txt", "dark_short.txt", "PC_long.txt", "UVA_long.txt", "dark_long.txt", decimal=",", method="sun")
}
UVA365.df <- SW_UVA365.df[ , c("w.length", "s.e.irrad")]
UVA365.spct <- setSourceSpct(UVA365.df)
Shenzhen_Weili.mspct <- source_mspct(list(UVA365.spct))
save(Shenzhen_Weili.mspct, file=paste(oldwd, "/data/Shenzhen.Weili.mspct.rda", sep=""))

setwd(oldwd)

setwd("raw.data/Maya/LED_measurements_11_2014")

if (exists("TY_UV310nm.spct")) {
  UV310nm.spct <- upgrade_spct(TY_UV310nm.spct)
  Tao_Yan.mspct <- source_mspct(list(UV310nm.spct))
  save(Tao_Yan.spct, file=paste(oldwd, "/data/Tao_Yan.spct.rda", sep=""))
} 

setwd(oldwd)

