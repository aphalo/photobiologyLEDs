library(photobiology)
library(ggspectra)

energy_as_default()

# clear workspace
rm(list = ls(pattern = "*"))

load("~/R-pkgs-owned/photobiologyLEDs/data-raw/maya-rda/Weili/12-channels-arrays/collection.Array.1.12.channels.Rda")

autoplot(collection.Array.1.12.channels.irrad.mspct[-c(1,6,7)], facets = 4)

# autoplot(s_sum(collection.Array.1.12.channels.irrad.mspct[-c(1,6,7)]), span = 21)

Weili_120W_12ch_A.mspct <- collection.Array.1.12.channels.irrad.mspct[-c(1,6,7)]

old.names <- names(Weili_120W_12ch_A.mspct)

names(Weili_120W_12ch_A.mspct) <-
  paste("ch", gsub(" ", "0", format(1:12, width = 2)), sep = "")

# summary(Weili_12ch_1.mspct, which.metadata = "when.measured")

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 70 mm; LED maximum current 350 mA per channel, adjusted to avoid clipping."

comment.text <- paste("Custom assembled 120W 12 channel LED array",
                      "in a 40x56mm metal based package with 10 x 1W LED dies per channel.\n",
                      "The LED dies are located within 24.6x24.6mm area and encased in clear silicone.\n",
                      "Array supplied by Shezhen Weili (https://www.leds-global.com/), assembled with dies from Epileds/Epistar/Bridgelux")
what.measured <- "Custom assembled 120W 12 channel LED array"

for (s in names(Weili_120W_12ch_A.mspct)) {
  temp.spct <- Weili_120W_12ch_A.mspct[[s]]
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(260, 900), fill = 0)
  if (s == "ch10") {
    idx <- which(abs(temp.spct[["w.length"]] - 407.69) < 0.1)
    print(idx)
    temp.spct[idx, "s.e.irrad"] <- 
      (temp.spct[idx - 1, "s.e.irrad"] + temp.spct[idx + 1, "s.e.irrad"]) / 2
  }
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, 
                  paste("Custom assembled 120W 12 channel LED array,", s))
  comment(temp.spct) <- NULL
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
#  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  Weili_120W_12ch_A.mspct[[s]] <- temp.spct
  readline("next:")
}

# comment(LedEngin_LZ7_N4M100.mspct) <- comment.text
autoplot(Weili_120W_12ch_A.mspct)
# Weili_120W_12ch_A.mspct <- normalise(Weili_120W_12ch_A.mspct)
# Weili_120W_12ch_A.mspct <- setNormalised(Weili_120W_12ch_A.mspct)

# autoplot(Weili_120W_12ch_A.mspct)

Weili_120W_12ch_A.spct <- rbindspct(Weili_120W_12ch_A.mspct, idfactor = "channel")
how_measured(Weili_120W_12ch_A.spct) <- how.measured
what_measured(Weili_120W_12ch_A.spct) <- "Custom assembled 120W 12 channel LED array"
comment(Weili_120W_12ch_A.spct) <- comment.text

names(Weili_120W_12ch_A.spct)

saveRDS(Weili_120W_12ch_A.spct, "data-raw/maya-rda/Weili/12-channels-arrays/weili_12ch_A.rds")
