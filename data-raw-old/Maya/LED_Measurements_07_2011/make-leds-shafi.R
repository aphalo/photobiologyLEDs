library(photobiology)
library(photobiologyWavebands)
library(lubridate)
library(ggspectra)

# files imported interactively with code like this:
QDDH73502 <- 
  read_excel("data-raw/Maya/LED_Measurements_07_2011/Mayameasurement_slitcorrected_QDDH73502.xlsx",
             skip = 17)

# tibs <- ls()
my.comment <- "Mesured with an Ocean Optics Maya2000 Pro\nby Shafiuddin Ahmed\nat SenPEP, dep. Biosciences, Univ. of Helsinki"

col.mspct <- source_mspct()
for (t in tibs) {
  temp.spct <- get(t)[ , 7:8]
  temp.spct <- na.omit(temp.spct)
  names(temp.spct) <- c("w.length", "s.e.irrad")
  setSourceSpct(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(250,900)) # calibration range
  temp.spct <- normalize(temp.spct)
  setWhenMeasured(temp.spct, ymd_h("2016_07_05 13", tz = "EET"))
  setWhatMeasured(temp.spct, paste("LED, type ", gsub("_", " ", t, fixed = TRUE)))
  comment(temp.spct) <- my.comment
  col.mspct <- c(col.mspct, source_mspct(list(temp.spct)))
}
names(col.mspct) <- tibs
col.mspct

for (i in seq_along(tibs)) {
  print(plot(col.mspct[[i]], range = c(280, 900),
             annotations = c("color.guide", "peaks")) +
          labs(title = tibs[i]))
  summary(my.spct)
}

shafi.mspct <- col.mspct

save(shafi.mspct, file = "data-raw/Rda/shafi-mspct.rda")
