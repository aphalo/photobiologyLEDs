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
                        sub("_", "-", types[s]), "with nominal wavelength",
                        type2wlchar.map[types[s]],
                        "\nfrom Ledengin (now Osram https://www.osram.com/)\nSupplied by Mouser or Digkey ca. 2015-2017\n",
                        "soldered on 20 mm starboard mounted on heat sink.")
  what.measured <- paste(type2pwrchar.map[types[s]], "SMD LED type", sub("_", "-", types[s]), "from Ledengin")
  temp.spct <- get(s)
  temp.spct <- normalize(temp.spct)
  temp.spct <- smooth_spct(temp.spct)
  temp.spct <- thin_wl(temp.spct)
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

ledengin <- names(ledengin.mspct)

save(ledengin, ledengin.mspct, file = "data-raw/rda2merge/ledengin-mspct.rda")
