[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active

# AfricaCountryBins
Create Uniform Square Country Carogram heatmaps

## Description
Heatmapes in a tile shape are an alternative to choropleth maps that don't distort based on land mass size.
This package is a essentialy a fork of [Bob Rudis's statebins package](https://github.com/hrbrmstr/statebin) designed for use for data involving Africa. 
This grid attempts to preserve the general position of countries on the contienet, while providing an equal area by country.

## Whatcha Get?

The main function implemented is 
 - `geom_countrybins_africa`: which is a countrybin Geom for africa
 
 
## Installation
Use the following to install: 
``` r
devtools::install_github("delabj/AfricaCountryBins")
# or 
remotes::install_github("delabj/AfricaCountryBins")
```

To use these options you'll have to install devtools or remotes respectivly. 
