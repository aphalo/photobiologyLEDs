library(lubridate)
library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

energy_as_default()

read.csv2("data-raw/maya-rda/Nichia/digitized/hortisolis.csv",
                      skip = 1, header = FALSE, col.names = c("w.length", "s.e.irrad")) |>
  as.source_spct() |>
  interpolate_spct(w.length.out = 350:800, fill = NULL) |> 
  smooth_spct(method = "supsmu", strength = 0.1) |> 
  clean() |> 
  normalize() |> 
  thin_wl(max.wl.step = 5, max.slope.delta = 5e-04, span = 15) -> Nichia_Hortisolis.spct
what_measured(Nichia_Hortisolis.spct) <- "LED type NFSW757G-V3 (Rs060) from Nichia"
how_measured(Nichia_Hortisolis.spct) <- "Spectrum digitized from plot in manufacturer's datasheet"
when_measured(Nichia_Hortisolis.spct) <- ymd("2022-06-01")
comment(Nichia_Hortisolis.spct) <- 
   paste("LED type NFSW757G-V3 (Rs060) from Nichia (https://www.nichia.co.jp/)\n",
         "560 mW SMD (3030) intended for plant cultivation.\nBranded \"Hortisolis\", ca. 2022")
autoplot(Nichia_Hortisolis.spct)
autoplot(Nichia_Hortisolis.spct, unit.out = "photon")

summary(Nichia_Hortisolis.spct)

save(Nichia_Hortisolis.spct, file = "data-raw/maya-rda/Nichia/digitized/hortisolis.rda")

