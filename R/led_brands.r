#' Spectral data for LEDs from different suppliers
#' 
#' The collection of spectra \code{\link{leds.mspct}} contains spectra for light
#' emitting diodes (LEDs) from several different suppliers. The character
#' vectors described here contain the names of the spectra for LEDs from each
#' supplier/brand to facilitate their extraction from the collection. One
#' additional vector, \code{led_brands} contains the names of the brands as used
#' in the names of the spectra in the collection.
#' 
#' @note Some of the LEDs were bought from AliExpress sellers while others were
#'   sourced from major electronic component distributors like Farnell, RS
#'   components, Digi Key, Mouser and TME. In the case of some AliExpress
#'   sellers or smaller webstores sometimes the exact type specifications are
#'   not available. Some of the Chinese sellers package the LEDs they sell using
#'   LED dies (= chips) from major brands and provide this brand name. In very
#'   recent times this seems to have expanded in some cases to include high
#'   density COB packages.
#' 
#' @docType data
#' @keywords datasets
#' @format A vector of character strings.
#' 
#' @examples
#' led_brands
#' Agilent_leds
#' 
#' @seealso \code{\link{leds.mspct}}
#' 
#' @family manufacturers
#' 
"led_brands"

#' @rdname led_brands
#' 
#' @section Agilent/Hewlett Packard:
#' The character vector \code{Agilent_leds} contains the names of the spectra to
#' facilitate their extraction from the collection.The division of Hewlett
#' Packard which supplied these LEDs became part of Agilent when this division
#' spin-off the mother company. More recently the electronic components division
#' of Agilent became Avago Technologies for a while. Currently, BROADCOM
#' supplies some of these LEDs or similar improved types.
#' 
#' @references \url{https://www.broadcom.com/products/leds-and-displays/}
#' 
"Agilent_leds"

#' @rdname led_brands
#' 
#' @section Huey Jann:
#' Huey Jann was a Taiwanese supplier of high power LED arrays. It is no longer
#' in business.
#' 
"HueyJann_leds"

#' @rdname led_brands
#' 
#' @section LED Engin:
#' Led Engin was an independent supplier of power LEDs in low thermal resistance
#' ceramic substrate packages. It is now part of Osram.
#' 
#' @references \url{https://www.osram.us/ledengin/}
#' 
"LedEngin_leds"

#' @rdname led_brands
#' 
#' @section LEDGUHON:
#' These LEDs where bought from AliExpress. They are assembled using
#' Bridgelux chips by Guangzhou Juhong Optoelectronics Co., Ltd., China.
#'
#' @references \url{https://www.ledguhon.com/}
#' 
"Ledguhon_leds"

#' @rdname led_brands
#' 
#' @section Marktech:
#' Marktech Optoelectronics is a distributor and supplier of LEDs from the 
#' U.S.A. that sells VIS and UV emitting LEDs.
#'
#' @references \url{https://marktechopto.com/}
#' 
"Marktech_leds"

#' @rdname led_brands
#' 
#' @section CREE:
#' The former LED products group of Cree is now Cree LED (U.S.A.) and a part of
#' SGH.
#'
#' @references \url{https://cree-led.com/}
#' 
"CREE_leds"

#' @rdname led_brands
#'
#' @section Epileds: 
#' EPI LEDS Co., Ltd. (Taiwan) is devoted to the R & D,
#' design, manufacture and sales of blue, green, red, and white light LED
#' wafers and chips.
#'
#' @references \url{https://www.epileds.com.tw/en/}
#'   
"Epileds_leds"

#' @rdname led_brands
#'
#' @section Epistar: 
#' EPISTAR Corporation (Taiwan).
#'
#' @references \url{https://www.epistar.com/}
#'   
"Epistar_leds"

#' @rdname led_brands
#'
#' @section Seoul Semiconductors: 
#' Seoul Semiconductor (Korea) supplies LEDs, including SunLike white LEDs 
#' using 'phosphor' technology from Toshiba (Japan). Seoul Viosys supplies
#' UV LEDs based on an agreement with SETi (U.S.A.).
#'
#' @references \url{http://www.seoulsemicon.com/en/}
#'   
"SeoulSemicon_leds"

#' @rdname led_brands
#'
#' @section Bridgelux: 
#' Bridgelux, Inc. (U.S.A.) is a supplier of LEDs partnering with Epistar and
#' Kaistar for the manufacture of their LEDs.
#'
#' @references \url{https://www.bridgelux.com/}
#'   
"Bridgelux_leds"

#' @rdname led_brands
#'
#' @section Nichia: 
#' With 24% global market share, Nichia (Japan) is the largest LED manufacturer
#' in the world and inventor of the blue (and also white) light emitting diodes.
#' The company was already an important supplier of 'phosphors' before the
#' invention of the white LEDs based on blue-emitting LED chips.
#' 
#' Some of the Nichia LEDs we measured were assembled into arrays of the series
#' names SmartArray and LinearZ from LUMITRONIX (Germany), and/or supplied by
#' LEDRISE Ltd. (Hong Kong, Germany and Romania) .
#'
#' @references \url{https://www.nichia.co.jp/en/product/led.html}
#'   
"Nichia_leds"

#' @rdname led_brands
#'
#' @section Norlux: 
#' Norlux is now part of Thomas Research Products. The LEDs we measured are
#' some of the earliest COB designs from early 1990's. Each COB containing 90 
#' LED chips. (Norlux is no longer in bussiness.)
#'   
"Norlux_leds"

#' @rdname led_brands
#'
#' @section Osram: 
#' ams-OSRAM International GmbH (Germany) produces LEDS and various light and
#' other sensors. Current trade name for LEDs is Osram Opto Semiconductors.
#' Osram has recently become owner of Led Engin, whose LEDs are listed 
#' separately in this pacakge. LEDs supplied under the LED Engin brand differ
#' mostly in the packages' thermal properties and contact layout.
#' 
#' @references \url{https://www.osram-os.com/}
#'   
"Osram_leds"

#' @rdname led_brands
#'
#' @section Quantum Devices: 
#' Quantum Devices (U.S.A.) sold in the past both individual LEDs and luminaires.
#' They were in the late 1980's and early 1990's the supplier of choice for LEDs
#' emitting in the far-red region of the spectrum.
#' 
#' @references \url{https://www.quantumdev.com/} 
#'   
"QuantumDevices_leds"

#' @rdname led_brands
#'
#' @section Roithner LaserTechnik: 
#' Roithner LaserTechnik is a distributor and reseller of LEDs, LED arrays and
#' lasers. They have a very extensive catalogue covering almost all wavelengths
#' for which LEDs are manufactured. Many of the LEDs are sold under new codes
#' as they are retested and in some cases individual characterization data
#' provided. For example some of short UV LEDs sold are from SETi.
#' 
#' @references \url{https://www.roithner-laser.com/} and 
#' \url{http://www.s-et.com/en/}
#' 
"Roithner_leds"

#' @rdname led_brands
#'
#' @section Shenzhen Weili: 
#' Leds Global and Shenzhen Weili are trade names of the same supplier of LEDs and LED
#' arrays. They sell both standard types and also assemble customized arrays
#' upon request. Customized arrays may have up to twelve independent channels
#' and vary in power output from 10 W to 300 W.
#'
#' @references \url{https://www.leds-global.com/}
#'
"Weili_leds"

#' @rdname led_brands
#'
#' @section Tao Yuan:
#' TaoYuan Electron (Hong Kong and China) is a supplier of LEDs and LED arrays.
#' 
#' @references \url{https://www.ledwv.com/en/}
#'
"TaoYuan_leds"

#' @rdname led_brands
#'
#' @section Luminus:
#' Luminus Devices (USA) is a supplier of SMD LEDs and COB LEDs as components.
#' 
#' @references \url{https://www.luminus.com/}
#'
"Luminus_leds"

#' @rdname led_brands
#'
#' @section Samsung:
#' Samsung LEDs (South Korea) is a supplier of SMD LEDs and COB LEDs as components.
#' 
#' @references \url{https://www.samsung.com/led/}
#'
"Samsung_leds"

