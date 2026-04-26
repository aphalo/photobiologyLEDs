library(photobiology)
library(ggspectra)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/AliExpressSellers/Hotred",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

file.names <- character()
for (f in files) {
  if (grepl("4x3W|3535|002|003", f)) next()
  file.names <- c(file.names, basename(f))
  load(f)
}

spectra <- ls(pattern = ".*\\.spct")
stopifnot(length(spectra) == 4)

split.names <- strsplit(file.names, "_")
names(split.names) <- spectra
new.names <- "HotRed_3W_SMD_generic_LED"

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 600 mm; LED current 700 mA."
comment.text <- "3W SMD 3535 generic type LED\nSupplied by AliExpress seller 'HotRed' in 2025\nsoldered on 20 mm starboard mounted on heat sink."
what.measured <- "3W SMD LED from HotRed (AliExpress)"

hotred.mspct <- source_mspct()
for (s in spectra) {
  split.name <- split.names[[s]]
  new.name <- 
    paste("HotRed_3W.nominal.", split.name[2], sep = "")
  if (split.name[2] == "810nm") {
    how.measured <- gsub("700mA", "350mA", how.measured)
  }
  comment.text <- paste("LED type unknown, nominal",
                        split.name[2],
                        "rated at 3W, SMD 3535 package;\nsupplied by AliExpress seller HotRed, China; ca. 2025")
  what.measured <- "LED type unknown, rated at 3W, SMD 3535 package"
  temp.spct <- get(s)
  temp.spct <- setNormalised(temp.spct)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct, max.wl.step = 6, span = 15, max.slope.delta = 0.0005)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  hotred.mspct[[new.name]] <- temp.spct
  print(new.name)
  readline("next:")
}

autoplot(hotred.mspct)

HotRed_leds <- names(hotred.mspct)

cat("Saving: hotred.mspct\n")

save(HotRed_leds, hotred.mspct, file = "data-raw/rda2merge/hotred-mspct.rda")
