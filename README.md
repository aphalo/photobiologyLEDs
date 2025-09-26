
# photobiologyLEDs <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![CRAN
version](https://www.r-pkg.org/badges/version-last-release/photobiologyLEDs)](https://cran.r-project.org/package=photobiologyLEDs)
[![cran
checks](https://badges.cranchecks.info/worst/photobiologyLEDs.svg)](https://cran.r-project.org/web/checks/check_results_photobiologyLEDs.html)
[![R Universe
vwersion](https://aphalo.r-universe.dev/badges/photobiologyLEDs)](https://aphalo.r-universe.dev/photobiologyLEDs)
[![R build
status](https://github.com/aphalo/photobiologyLEDs/workflows/R-CMD-check/badge.svg)](https://github.com/aphalo/photobiologyLEDs/actions)
[![Documentation](https://img.shields.io/badge/documentation-photobiologyLEDs-informational.svg)](https://docs.r4photobiology.info/photobiologyLEDs/)
[![doi](https://img.shields.io/badge/doi-10.32614/CRAN.package.photobiologyLEDs-blue.svg)](https://doi.org/10.32614/CRAN.package.photobiologyLEDs)
<!-- badges: end -->

Package ‘**photobiologyLEDs**’ complements other packages in the [*R for
photobiology* suite](https://www.r4photobiology.info/). It contains
spectral emission data for diverse types of light emitting diodes (LEDs)
and LED arrays (`leds.mspct`) available as electronic components.
Spectra for LED-based lamps and other lamps are included in package
[‘photobioloyLamps’](https://docs.r4photobiology.info/photobiologyLamps/).
Package ‘photobiologyLEDs’ also includes spectra from a COB LED when
dimmed using the constant current approach (`COB_dimming.mspct`) and for
a COB LED combined with reflectors with different beam angles
(`COB_reflectors.mspct`).

This package contains only data. Data are stored as collections of
spectra of class `source_mspct` from package ‘photobiology’, which is
the core of the [*R for photobiology*
suite](https://www.r4photobiology.info/). Spectra can be easily plotted
with functions and methods from package
[‘ggspectra’](https://docs.r4photobiology.info/ggspectra/). The spectra
can be used seamlessly with functions from package
[‘photobioloy’](https://docs.r4photobiology.info/photobiology/).
However, class `source_mspct` is derived from `list` and class
`source_spct` is derived from `data.frame` making the data also usable
as is with base R functions.

## What are these data useful for?

As LED specifications have tolerances, data obtained from individual
LEDs are to be considered only examples.

## Examples

``` r
eval_plots <- requireNamespace("ggspectra", quietly = TRUE)
if (eval_plots) library(ggspectra)
library(photobiologyLEDs)
```

How many spectra are included in the current version of
‘photobiologyLEDs’?

``` r
length(leds.mspct)
#> [1] 90
```

``` r
length(COB_dimming.mspct)
#> [1] 8
```

``` r
length(COB_reflectors.mspct)
#> [1] 4
```

What are the names of available spectra. We use `head()` to limit the
output.

``` r
# list names of the first 10 LEDs
head(names(leds.mspct), 10)
#>  [1] "Agilent_HLMB_CB30"           "Agilent_HLMB_CD31"          
#>  [3] "Agilent_HLMP_CB31"           "Agilent_HLMP_CM30"          
#>  [5] "Agilent_HLMP_CM31"           "Agilent_HLMP_DJ32"          
#>  [7] "Agilent_HLMP_DL32"           "Bridgelux_3W_455nm"         
#>  [9] "Bridgelux_BXRE_50S2001_c_73" "CREE_XPE_480nm"
```

To subset based on different criteria we can use predefined character
vectors of LED names. For example, vector `Osram_leds` lists the names
of the spectra for LEDs made by Osram.

``` r
Osram_leds
#> [1] "Osram_GF_CSHPM2.24_2T4T_1" "Osram_GW_CSSRM3.HW"       
#> [3] "Osram_LY5436"
```

We can use the vector to extract all these spectra as a collection.

``` r
leds.mspct[Osram_leds]
#> Object: source_mspct [3 x 1]
#> --- Member: Osram_GF_CSHPM2.24_2T4T_1 ---
#> Object: source_spct [925 x 2]
#> Wavelength range 251.29-900.1 nm, step 1.023182e-12-3.79 nm 
#> Label: LED type GF_CSHPM2.24_2T4T_1 from Osram 
#> Measured on 2021-10-09 22:19:15.2049 UTC 
#> Spectral data in s.e.irrad normalized to 1 at 728.8 nm (max in 251.29-900.1 nm)
#> Variables:
#>  w.length: Wavelength [nm]
#>  s.e.irrad: Spectral energy irradiance [normalized] 
#> --
#> # A tibble: 925 × 2
#>    w.length s.e.irrad
#>       <dbl>     <dbl>
#>  1     251.         0
#>  2     253.         0
#>  3     253.         0
#>  4     254.         0
#>  5     254.         0
#>  6     255.         0
#>  7     255.         0
#>  8     256.         0
#>  9     256.         0
#> 10     257.         0
#> # ℹ 915 more rows
#> --- Member: Osram_GW_CSSRM3.HW ---
#> Object: source_spct [833 x 2]
#> Wavelength range 251.29-900.1 nm, step 1.023182e-12-3.79 nm 
#> Label: LED type GW_CSSRM3.HW from Osram 
#> Measured on 2022-01-06 17:48:51.853322 UTC 
#> Spectral data in s.e.irrad normalized to 1 at 436.6 nm (max in 251.29-900.1 nm)
#> Variables:
#>  w.length: Wavelength [nm]
#>  s.e.irrad: Spectral energy irradiance [normalized] 
#> --
#> # A tibble: 833 × 2
#>    w.length s.e.irrad
#>       <dbl>     <dbl>
#>  1     251.         0
#>  2     253.         0
#>  3     254.         0
#>  4     254.         0
#>  5     255.         0
#>  6     255.         0
#>  7     256.         0
#>  8     256.         0
#>  9     257.         0
#> 10     259.         0
#> # ℹ 823 more rows
#> --- Member: Osram_LY5436 ---
#> Object: source_spct [1,368 x 2]
#> Wavelength range 250.01-900.1 nm, step 1.023182e-12-6.11 nm 
#> Label: LED type LY5436 from Osram 
#> Measured on 2011-07-30 UTC 
#> Spectral data in s.e.irrad normalized to 1 at 594.2 nm (max in 250.01-900.1 nm)
#> Variables:
#>  w.length: Wavelength [nm]
#>  s.e.irrad: Spectral energy irradiance [normalized] 
#> --
#> # A tibble: 1,368 × 2
#>    w.length s.e.irrad
#>       <dbl>     <dbl>
#>  1     250.         0
#>  2     256.         0
#>  3     257.         0
#>  4     257.         0
#>  5     258.         0
#>  6     258          0
#>  7     258.         0
#>  8     259.         0
#>  9     259.         0
#> 10     260.         0
#> # ℹ 1,358 more rows
#> 
#> --- END ---
```

The package includes character vectors with the names of LEDs grouped by
brand, colors, and uses. These names can be used as indexing vectors to
extract one or more spectra from the `leds.mspct` collection.

``` r
led_colors
#> [1] "uv"     "purle"  "blue"   "green"  "yellow" "orange" "red"    "ir"
```

``` r
led_brands
#>  [1] "Agilent"        "Bridgelux"      "CREE"           "Epileds"       
#>  [5] "Epistar"        "HueyJann"       "LCFOCUS"        "LedEngin"      
#>  [9] "Ledguhon"       "Luminus"        "Marktech"       "Nichia"        
#> [13] "Norlux"         "Osram"          "QuantumDevices" "Roithner"      
#> [17] "Samsung"        "SeoulSemicon"   "TaoYuan"        "Weili"
```

``` r
led_uses
#> [1] "plant_grow" "high_CRI"
```

Vectors like `Osram_leds` shown above are available for all the brands
listed in `led_brands`, all the colors in `led_colors`, and all the uses
in `led_uses`.

Summary calculations can be easily done with methods from package
‘photobiology’. Here we calculate photon irradiance. As the spectra are
normalised we pass `allow.scaled = TRUE`,

``` r
q_irrad(leds.mspct[["Nichia_NS6L183AT_H1_sw"]], 
        allow.scaled = TRUE, scale.factor = 1e6)
#>   Q_Total 
#> 151080953 
#> attr(,"time.unit")
#> [1] "second"
#> attr(,"radiation.unit")
#> [1] "total photon irradiance"
```

The `autoplot()` methods from package ‘ggspectra’ can be used for
plotting one or more spectra at a time.

``` r
autoplot(leds.mspct[["Nichia_NS6L183AT_H1_sw"]]) + theme_bw()
```

![](man/figures/README-unnamed-chunk-1-1.png)<!-- -->

The classes of the objects used to store the spectral data are derived
from `"data.frame"` making direct use of the data with functions and
methods from base R and various packages easy.

## Installation

Installation of the most recent released version from CRAN (source and
binaries available):

``` r
install.packages("photobiologyLEDs")
```

Installation of the current unstable version from R-Universe CRAN-like
repository (source and binaries available):

``` r
install.packages('photobiologyLEDs', 
                 repos = c('https://aphalo.r-universe.dev', 
                           'https://cloud.r-project.org'))
```

Installation of the current unstable version from GitHub (only source
available):

``` r
# install.packages("remotes")
remotes::install_github("aphalo/photobiologyLEDs")
```

## Documentation

HTML documentation is available at
(<https://docs.r4photobiology.info/photobiologyLEDs/>), including a
*User Guide*.

News on updates to the different packages of the ‘r4photobiology’ suite
are regularly posted at (<https://www.r4photobiology.info/>).

Two articles introduce the basic ideas behind the design of the suite
and its use: Aphalo P. J. (2015)
(<https://doi.org/10.19232/uv4pb.2015.1.14>) and Aphalo P. J. (2016)
(<https://doi.org/10.19232/uv4pb.2016.1.15>).

A book is under preparation, and the draft is currently available at
(<https://leanpub.com/r4photobiology/>).

A handbook written before the suite was developed contains useful
information on the quantification and manipulation of ultraviolet and
visible radiation: Aphalo, P. J., Albert, A., Björn, L. O., McLeod, A.
R., Robson, T. M., & Rosenqvist, E. (Eds.) (2012) Beyond the Visible: A
handbook of best practice in plant UV photobiology (1st ed., p. xxx +
174). Helsinki: University of Helsinki, Department of Biosciences,
Division of Plant Biology. ISBN 978-952-10-8363-1 (PDF),
978-952-10-8362-4 (paperback). PDF file available from
(<https://hdl.handle.net/10138/37558>).

## Contributing

Pull requests, bug reports, and feature requests are welcome at
(<https://github.com/aphalo/photobiologyLEDs>).

## Citation

If you use this package to produce scientific or commercial
publications, please cite according to:

``` r
citation("photobiologyLEDs")
#> To cite package ‘photobiologyLEDs’ in publications use:
#> 
#>   Aphalo, Pedro J. (2015) The r4photobiology suite. UV4Plants Bulletin,
#>   2015:1, 21-29. DOI:10.19232/uv4pb.2015.1.14
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     author = {Pedro J. Aphalo},
#>     title = {The r4photobiology suite},
#>     journal = {UV4Plants Bulletin},
#>     volume = {2015},
#>     number = {1},
#>     pages = {21-29},
#>     year = {2015},
#>     doi = {10.19232/uv4pb.2015.1.14},
#>   }
```

## License

© 2012-2025 Pedro J. Aphalo (<pedro.aphalo@helsinki.fi>). Released under
the GPL, version 2 or greater. This software carries no warranty of any
kind.
