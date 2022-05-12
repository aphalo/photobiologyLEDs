library(photobiology)
library(ggspectra)
library(lubridate)

# clear workspace
rm(list = ls(pattern = "*"))

files <- list.files(path = "data-raw/maya-rda/Ledengin",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "[Ll]ed[Ee]ngin[.]")
spectra <- grep("[.]spct", spectra, value = TRUE)

names <- gsub("[.]spct|\\.350mA.50mm\\.spct", "", spectra)

cat(names, "\n")

types <- gsub("ledengin\\.", "", names, ignore.case = TRUE)

type2wlength.map <- c(
  LZ4_40R208 = 660,
  LZ1_10R102 = 623, # dominant
  LZ1_10R302 = 740,
  LZ1_10R602 = 850, # dual junction
  LZ1_10UB00_00U4 = 385,
  LZ1_10UB00_00U5 = 390,
  LZ1_10UB00_00U8 = 405,
  LZ1_10UV00 = 365,
  LZ1_10G102 = 523, # dominant
  LZ1_10B202 = 457, # dominant
  LZ1_10DB00 = 460  # dental blue
)

type2wlchar.map <- sprintf("%inm", type2wlength.map)
names(type2wlchar.map) <- names(type2wlength.map)

wlchar2type.map <- names(type2wlchar.map)
names(wlchar2type.map) <- type2wlchar.map

type2power.map <- c(
  LZ4_40R208 = 6,
  LZ1_10R102 = 3,
  LZ1_10R302 = 3,
  LZ1_10R602 = 3, # dual junction
  LZ1_10UB00_00U4 = 3,
  LZ1_10UB00_00U5 = 3,
  LZ1_10UB00_00U8 = 3,
  LZ1_10UV00 = 3,
  LZ1_10G102 = 3,
  LZ1_10B202 = 3,
  LZ1_10DB00 = 3  # dental blue
)

type2pwrchar.map <- sprintf("%iW", type2power.map)
names(type2pwrchar.map) <- names(type2power.map)

types <- ifelse(types %in% names(wlchar2type.map),
                wlchar2type.map[types], types)
types <- gsub("LZ1_00", "LZ1_10", types)

new.names <- paste("LedEngin", types, type2wlchar.map[types], sep = "_")
  
names(new.names) <- spectra
names(types) <- spectra

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 50 mm; LED current 350 mA."

ledengin.mspct <- source_mspct()
for (s in spectra) {
  comment.text <- paste(type2pwrchar.map[types[s]], "SMD LED type",
                        gsub("_", "-", types[s]), "with nominal wavelength",
                        type2wlchar.map[types[s]],
                        "\nfrom LED Engin (now a division of Osram https://www.osram.com/)\nSupplied by Mouser or Digkey ca. 2015-2017\n",
                        "soldered on 20 mm starboard mounted on heat sink.")
  what.measured <- paste(type2pwrchar.map[types[s]], "SMD LED type", gsub("_", "-", types[s]), "from LED Engin")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(300, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, what.measured)
  comment(temp.spct) <- comment.text
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  ledengin.mspct[[new.names[s]]] <- temp.spct
  readline("next:")
}

autoplot(ledengin.mspct)

# LZ7 7 channel array
# we will read 7 channels into a single spectrum
# clear workspace
rm(list = ls(pattern = "*\\.spct"))

files <- list.files(path = "data-raw/maya-rda/Ledengin/LZ7",
                    pattern = ".spct.[Rr]da",
                    full.names = TRUE)

for (f in files) {
  load(f)
}

spectra <- ls(pattern = "LZ7")
spectra <- grep("[.]spct", spectra, value = TRUE)

type <- "LZ7_N4M100"

how.measured <- "Array spectrometer, Ocean Optics Maya 2000 Pro; Bentham cosine diffuser D7H; distance 35 mm; LED current 350 mA per channel."

comment.text <- paste("20W SMD 7 channel LED array type",
                      sub("_", "-", type), "in a 7x7mm ceramic SMD package with 1 x 3W LED die per channel",
                      "\nfrom LED Engin (now a division of Osram https://www.osram.com/)\nSupplied by Mouser or Digkey ca. 2015-2017\n",
                      "soldered onto a solid copper PCB and mounted on heat sink.")
what.measured <- paste("20W 7-ch. SMD LED type", sub("_", "-", type), "from LED Engin")

channels <- c(
  ch.A = "A_Green",
  ch.B = "B_Red",
  ch.C = "C_Blue",
  ch.D = "D_UV",
  ch.E = "E_CW_Cool_white",
  ch.F = "F_PC_Amber",
  ch.G = "G_Cyan"
)

LedEngin_LZ7_N4M100.mspct <- source_mspct()
for (s in spectra) {
  for (ch in names(channels)) {
    if (grepl(ch, s)) {
      channel <- channels[ch]
      break()
    }
  }
  temp.spct <- get(s)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
  temp.spct <- trim_wl(temp.spct, range = c(300, 900), fill = 0)
  setHowMeasured(temp.spct, how.measured)
  setWhatMeasured(temp.spct, paste(gsub("_", " ", channel), "ch. of", what.measured))
  comment(temp.spct) <- paste(gsub("_", " ", channel), "channel of", comment.text)
  trimInstrDesc(temp.spct)
  trimInstrSettings(temp.spct)
  print(str(get_attributes(temp.spct)))
  print(autoplot(temp.spct, annotations = c("+", "title:what:when:comment")))
  LedEngin_LZ7_N4M100.mspct[[channel]] <- temp.spct
  readline("next:")
}

# comment(LedEngin_LZ7_N4M100.mspct) <- comment.text
autoplot(LedEngin_LZ7_N4M100.mspct)

LedEngin_LZ7_N4M100.spct <- rbindspct(LedEngin_LZ7_N4M100.mspct, idfactor = "channel")
how_measured(LedEngin_LZ7_N4M100.spct) <- how.measured
what_measured(LedEngin_LZ7_N4M100.spct) <- what.measured
comment(LedEngin_LZ7_N4M100.spct) <- comment.text
ledengin.mspct[[paste("LedEngin", type, sep = "_")]] <- LedEngin_LZ7_N4M100.spct
  
names(LedEngin_LZ7_N4M100.mspct) <- paste("LedEngin", type, "ch", names(LedEngin_LZ7_N4M100.mspct), sep = "_")
temp.spct <- normalize(LedEngin_LZ7_N4M100.mspct)
autoplot(temp.spct)
ledengin.mspct <- c(ledengin.mspct, temp.spct)
LedEngin_leds <- names(ledengin.mspct)

save(LedEngin_leds, ledengin.mspct, file = "data-raw/rda2merge/ledengin-mspct.rda")
