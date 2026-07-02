library(photobiology)
library(ggspectra)

energy_as_default()

# clear workspace
rm(list = ls(pattern = "*"))

load("~/R-pkgs-owned/photobiologyLEDs/data-raw/maya-rda/Weili/5-channels-arrays/collection.weili.50W.type.2.at.120mm.Rda")

autoplot(collection.weili.50W.type.2.at.120mm.irrad.mspct, facets = 3)
autoplot(collection.weili.50W.type.2.at.120mm.irrad.mspct, facets = 3, norm = "max")

Weili_50W_5ch_II.mspct <- collection.weili.50W.type.2.at.120mm.irrad.mspct

old.names <- names(Weili_50W_5ch_II.mspct)

names(Weili_50W_5ch_II.mspct) <-
  paste("ch", gsub(" ", "0", format(c(1:3, 5), width = 2)), sep = "")

# summary(Weili_12ch_1.mspct, which.metadata = "when.measured")

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 120 mm; LED maximum current 350 mA per channel, adjusted to avoid clipping."

comment.text <- paste("Custom assembled 50W 5 channel LED array",
                      "in a 37.6x37.6mm metal based package with 10 x 1W LED dies per channel.\n",
                      "The LED dies are located within 20x20mm area and encased in clear silicone.\n",
                      "Array supplied by Shezhen Weili (https://www.leds-global.com/), assembled with dies from Epileds/Epistar/Bridgelux")
what.measured <- "Custom assembled 50W 5 channel LED array (1 ch non-functional)"

for (s in names(Weili_50W_5ch_II.mspct)) {
  temp.spct <- Weili_50W_5ch_II.mspct[[s]]
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 5, max.slope.delta = 0.0005, span = 15)
  temp.spct <- trim_wl(temp.spct, range = c(260, 900), fill = 0)
  # if (s == "ch10") {
  #   idx <- which(abs(temp.spct[["w.length"]] - 407.69) < 0.1)
  #   print(idx)
  #   temp.spct[idx, "s.e.irrad"] <- 
  #     (temp.spct[idx - 1, "s.e.irrad"] + temp.spct[idx + 1, "s.e.irrad"]) / 2
  # }
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, 
                  paste("Custom assembled 50W 5 channel LED array,", s))
  comment(temp.spct) <- NULL
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
#  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  Weili_50W_5ch_II.mspct[[s]] <- temp.spct
  readline("next:")
}

# comment(LedEngin_LZ7_N4M100.mspct) <- comment.text
autoplot(Weili_50W_5ch_II.mspct)
# Weili_120W_12ch_A.mspct <- normalise(Weili_120W_12ch_A.mspct)
# Weili_120W_12ch_A.mspct <- setNormalised(Weili_120W_12ch_A.mspct)

# autoplot(Weili_120W_12ch_A.mspct)

Weili_50W_5ch_II.spct <- rbindspct(Weili_50W_5ch_II.mspct, idfactor = "channel")
how_measured(Weili_50W_5ch_II.spct) <- how.measured
what_measured(Weili_50W_5ch_II.spct) <- "Custom assembled 50W 5 channel LED array"
comment(Weili_50W_5ch_II.spct) <- comment.text

names(Weili_50W_5ch_II.spct)

saveRDS(Weili_50W_5ch_II.spct, "data-raw/maya-rda/Weili/5-channels-arrays/weili_5ch_II.rds")
