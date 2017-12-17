library(r4photobiology)
library(tibble)


# NICHIA ------------------------------------------------------------------


load("./Nichia_white_hiCRI_700mA_4cm.spct.Rda")
NS6L183AT_H1.spct <- white_led.source_spct

setWhatMeasured(NS6L183AT_H1.spct,
                "Warm-white LED, CRI 92 (2.88 W)\nNICHIA type NS6L183AT-H1, supplied by Lumitornix, Germany\nMeasured at 700 mA, and at 40 mm from cosine diffuser.")
cat(getWhatMeasured(NS6L183AT_H1.spct))
trimInstrDesc(NS6L183AT_H1.spct)
trimInstrSettings(NS6L183AT_H1.spct)

Nichia_white.mspct <- source_mspct(list(NS6L183AT_H1 = NS6L183AT_H1.spct))
Nichia_white_names <- "NS6L183AT_H1"

save(Nichia_white.mspct, Nichia_white_names, file = "../../Rda/Nichia_white.mspct.rda")
rm(Nichia_white_hiCRI_700mA_4cm.raw_mspct, Nichia_white_hiCRI_700mA_4cm.spct, NS6L183AT_H1.spct)


# Marktech ----------------------------------------------------------------


load("./marcktech_340nm_RECOM99.spct.Rda")
MTSM340UV_F5120.spct <- marcktech_340nm_RECOM99.spct

setWhatMeasured(MTSM340UV_F5120.spct,
                "Ultraviolet LED, 340nm\nMarktech type MTSM340UV-F5120, supplied by Digikey\nMeasured at 700 mA (over specifications), and at unknown distance from cosine diffuser.")
cat(getWhatMeasured(MTSM340UV_F5120.spct))
trimInstrDesc(MTSM340UV_F5120.spct)
trimInstrSettings(MTSM340UV_F5120.spct)

Marktech.mspct <- source_mspct(list(MTSM340UV_F5120 = MTSM340UV_F5120.spct))
Marktech_names <- "MTSM340UV_F5120"

save(Marktech.mspct, Marktech_names, file = "../../Rda/MArktech.mspct.rda")
rm(marcktech_340nm_RECOM99.raw_mspct, marcktech_340nm_RECOM99.spct, MTSM340UV_F5120.spct)


# Shenzen Weili -----------------------------------------------------------


weili_3w.df <-
  tibble(old.name = c("weili_3W_490nm_700mA_4cm.spct",
                      "weili_3W_505nm_700mA_4cm.spct",
                      "Weili_3W_525nm_700mA_4cm.spct",
                      "weili_3W_550nm_700mA_4cm.spct"
  ),
  new.name = c("G_P3V140B1_G",
               "G_P3V140B1_GT",
               "G_P3V140A1_YG",
               "G_P3V140A1_YG1"),
  what = paste("LED (3 W)\nWeili type ",
               c("G-P3V140B1-G, Cyan 490 nm", "G-P3V140B1-GT, Cyan 500 nm", 
                 "G-P3V140A1-YG, Green 530 nm", "G-P3V140A1_YG1, Green 560 nm"),
               "supplied by Shenzen Weili\nMeasured at 700 mA, and at 40 mm from cosine diffuser.",
               sep = "")
)

for (i in seq(along.with = weili_3w.df$old.name)) {
  load(paste(weili_3w.df[["old.name"]][i], ".Rda", sep = ""))
  temp.spct <- get(weili_3w.df[["old.name"]][i])
  setWhatMeasured(temp.spct,
                  weili_3w.df[["what"]][i])
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  assign(weili_3w.df[["new.name"]][i], temp.spct)
}

weili_3w.mspct <-
  source_mspct(mget(weili_3w.df[["new.name"]]))

weili_3W_names <- weili_3w.df$new.name

save(weili_3w.mspct, weili_3W_names, file = "../../Rda/weili_3W.mspct.rda")
rm(temp.spct, i)
rm(list = weili_3w.df[["old.name"]])
rm(list = weili_3w.df[["new.name"]])
rm(list = ls(pattern = "*raw_mspct"))


# LED Engin ---------------------------------------------------------------


LEDEngin.df <-
  tibble(old.name = c("LedEngin_LZ1_365nm_700mA_4cm.spct",
                      "LedEngin_LZ1_385nm_700mA_4cm.spct",
                      "LedEngin_LZ1_405nm_700mA_4cm.spct",
                      "LedEngin_LZ1_460nm_700mA_4cm.spct",
                      "LedEngin_LZ1_735nm_700mA_4cm.spct",
                      "LedEngin_LZ4_660nm_700mA_12cm.spct"
  ),
  new.name = c("LZ1_10UV00",
               "LZ1_10UA00_U4",
               "LZ1_10UA00_U8",
               "LZ1_10DB00",
               "LZ1_10R302",
               "LZ4_10R208"),
  what = paste("LED Engin type ",
               c("LZ1-10UV00, Ultraviolet 365 nm ", "LZ1-10UA00-U4, Violet 385 nm", 
                 "LZ1-10UA00-U8, Violet 405 nm", "Z1-10DB00, Dental blue 460 nm", 
                 "LZ1-10R302, Far red 740 nm", "LZ4-10R208, Deep red 660nm"),
               c(rep("\nMeasured at 700 mA, and at 40 mm from cosine diffuser.", 5),
                 "\nMeasured at 700 mA, and at 120 mm from cosine diffuser."),
               sep = "")
  )

for (i in seq(along.with = LEDEngin.df$old.name)) {
  load(paste(LEDEngin.df[["old.name"]][i], ".Rda", sep = ""))
  temp.spct <- get(LEDEngin.df[["old.name"]][i])
  setWhatMeasured(temp.spct,
                  LEDEngin.df[["what"]][i])
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  assign(LEDEngin.df[["new.name"]][i], temp.spct)
}

LEDEngin2017.mspct <-
  source_mspct(mget(LEDEngin.df[["new.name"]]))

LEDEngin2017_names <- LEDEngin.df$new.name

save(LEDEngin2017.mspct, LEDEngin2017_names, file = "../../Rda/LEDEngin2017.mspct.rda")

rm(temp.spct, i)
rm(list = LEDEngin.df[["old.name"]])
rm(list = LEDEngin.df[["new.name"]])
rm(list = ls(pattern = "*raw_mspct"))
