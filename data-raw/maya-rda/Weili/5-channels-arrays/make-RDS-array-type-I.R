library(photobiology)
library(ggspectra)

energy_as_default()

# clear workspace
rm(list = ls(pattern = "*"))

load("~/R-pkgs-owned/photobiologyLEDs/data-raw/maya-rda/Weili/5-channels-arrays/collection.Weili.50W.5.channels.Type.1.Rda")

autoplot(collection.Weili.50W.5.channels.Type.1.irrad.mspct, facets = 3)
autoplot(collection.Weili.50W.5.channels.Type.1.irrad.mspct, facets = 3, norm = "max")

# autoplot(s_sum(collection.Array.1.12.channels.irrad.mspct[-c(1,6,7)]), span = 21)

Weili_50W_5ch_I.mspct <- collection.Weili.50W.5.channels.Type.1.irrad.mspct

old.names <- names(Weili_50W_5ch_I.mspct)

names(Weili_50W_5ch_I.mspct) <-
  paste("ch", gsub(" ", "0", format(c(2:5, 1), width = 2)), sep = "")

# summary(Weili_12ch_1.mspct, which.metadata = "when.measured")

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance unknown; LED maximum current 350 mA per channel, adjusted to avoid clipping."

comment.text <- paste("Custom assembled 50W 5 channel LED array",
                      "in a 37.6x37.6mm metal based package with 10 x 1W LED dies per channel.\n",
                      "The LED dies are located within 20x20mm area and encased in clear silicone.\n",
                      "Array supplied by Shezhen Weili (https://www.leds-global.com/), assembled with dies from Epileds/Epistar/Bridgelux")
what.measured <- "Custom assembled 50W 5 channel LED array"

for (s in names(Weili_50W_5ch_I.mspct)) {
  temp.spct <- Weili_50W_5ch_I.mspct[[s]]
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
  Weili_50W_5ch_I.mspct[[s]] <- temp.spct
  readline("next:")
}

# comment(LedEngin_LZ7_N4M100.mspct) <- comment.text
autoplot(Weili_50W_5ch_I.mspct)
# Weili_120W_12ch_A.mspct <- normalise(Weili_120W_12ch_A.mspct)
# Weili_120W_12ch_A.mspct <- setNormalised(Weili_120W_12ch_A.mspct)

# autoplot(Weili_120W_12ch_A.mspct)

Weili_50W_5ch_I.spct <- rbindspct(Weili_50W_5ch_I.mspct, idfactor = "channel")
how_measured(Weili_50W_5ch_I.spct) <- how.measured
what_measured(Weili_50W_5ch_I.spct) <- "Custom assembled 50W 5 channel LED array"
comment(Weili_50W_5ch_I.spct) <- comment.text

names(Weili_50W_5ch_I.spct)

saveRDS(Weili_50W_5ch_I.spct, "data-raw/maya-rda/Weili/5-channels-arrays/weili_5ch_I.rds")
