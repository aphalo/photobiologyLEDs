---
editor_options: 
  markdown: 
    wrap: sentence
---

# photobiologyLEDs 0.5.0

This is a major and code-breaking update.
Naming conventions have been changed and many new spectra have been added.
Previously included spectra have in most cases been recomputed and may slightly differ from earlier versions of the same data.
In part this was done to reduce the size of the data objects, making it possible to include more spectra while keeping the size of the package reasonable.

-   Revise for 'ggspectra' (\>= 0.3.1).
-   Rebuild all data objects with 'photobiology' (== 0.10.10) taking care that all spectra in `leds.mspct` are normalized.
-   Apply function `photobiology::thin_wl()` to all spectra to reduce their stored size.
-   Add data for new LED types and update the metadata of most of those carried over from earlier versions.
-   CODE BREAKING: change naming convention for members of the collection of spectra. Now names consist of "brand" and type.
-   CODE BREAKING: lists of LEDs by colour are now based on the wavelength at the peak of emission. We use ISO-standard wavelength boundaries for colours of visible radiation, except for purple \< 400 nm. For ultraviolet we follow ISO. All broad-spectrum LEDs are listed as white.
-   Rewrite/revise all scripts used to prepare the spectral data.
-   Migrate Git repository from Bitbucket to GitHub.

# photobiologyLEDs 0.4.3-1

-   Fix dependency on a non-.0 version of R.

# photobiologyLEDs 0.4.3

-   Add data for additional LED types, and rebuild all data objects.
-   Fix minor bug.
-   Revise User Guide and remove the Catalogue of data vignette.

# photobiologyLEDs 0.4.2

-   Store spectral data in a single collection of spectra.
-   Provide vectors of names to extract non-orthogonal subsets.
-   At the moment by color and by manufacturer.
-   Add spectral data for additional LEDs.
-   Convert vignette to Rmarkdown.
-   Add User Guide.

# photobiologyLEDs 0.4.1

-   *Not submitted to CRAN and very short lived*. (It was a bad start into a major reorganization of the data.)

# photobiologyLEDs 0.3.2

-   Trimmed Norlux data to 250..900 nm, and added source_mspct objects for multi-channel arrays.

-   Rebuild data and the package with photobiology 0.8.5.

# photobiologyLEDs 0.3.1

-   Rebuild all data and the package with photobiology 0.8.0.

# photobiologyLEDs 0.3.0

-   Added data for LUMITRONIX LED array.
-   Rebuild all data and the package with photobiology 0.6.0.

# photobiologyLEDs 0.2.2

-   Added data for UVMAX LEDs.

# photobiologyLEDs 0.2.1

-   Rebuilt data objects with photobiology 0.5.7 and updated the vignettes to use photobiologygg 0.2.5 functions.

# photobiologyLEDs 0.2.0

-   Updated required version of photobiology package to 0.5.1, which required a small edit to the User Guide.

# photobiologyLEDs 0.1.3

-   Updated required version of photobiology package.

# photobiologyLEDs 0.1.2

-   Data updated by reprocessing raw measurements using current version of MayaCalc.
-   Rebuilt spectral objects with current version of photobiology package.
-   Revised the vignette to use the new plot.source.spct() function.
-   Added data for Tao Yuan UVB LED.

# photobiologyLEDs 0.1.1

-   Data updated by reprocessing raw measurements using current version of MayaCalc.
-   Added a vignette.

# photobiologyLEDs 0.1.0

-   First version.
