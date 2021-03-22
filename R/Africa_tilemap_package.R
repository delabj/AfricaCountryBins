#' Create Country Bin maps of Africa!
#'
#' @md
#' @name AfricaCountryBins-package
#' @docType package
#' @author Joshua de la Bruere (Joshua@@delabj.com)
#' @author Bob Rudis (bob@@rud.is)
#'
#' @description Create tile heatmaps as an alternative to choropleth maps to avoid distorted intuition
#'  based on land mass size
#'  This package is a modified version of Bob Rudis's statebins package, designed for use for data involving countries in
#'  Africa. This grid attempts to preserve the general position of countries on the continent, while providing an equal
#'  area by country.
#' @importFrom grid unit
#' @importFrom scales alpha
#' @importFrom ggplot2 ggplot geom_tile scale_fill_manual guides geom_tile ggplotGrob
#' @importFrom ggplot2 geom_point geom_text scale_color_manual guides theme labs
#' @importFrom ggplot2 scale_x_continuous scale_y_continuous coord_equal theme_bw
#' @importFrom ggplot2 aes element_rect element_blank element_text resolution
#' @importFrom ggplot2 aes_string aes_ scale_y_reverse layer GeomRect margin %+replace%
#' @importFrom ggplot2 scale_fill_brewer ggtitle rel ggproto draw_key_polygon Geom Stat
NULL
