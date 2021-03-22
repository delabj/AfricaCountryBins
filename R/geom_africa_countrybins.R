#' A country-bins map of Africa
#'
#' @description
#' Based off the work of [Bob Rudis's Statebins](https://github.com/hrbrmstr/statebins) this package aims to create a workable tile map of Africa for ggplot2.
#' Simply pass in a dataframe containing countries and values to measure, and this geom will create a simple map. This allows for easy faceting and allows a uniform legend across all plots.
#'
#' Much like the origional statebins package, there are two critical `aes()` mappings: \cr
#' - `country` (so the geom knows which column to map the country names/abbreviations to)
#' - `fill` (the column you're mapping the filling with.)
#'
#' @md
#' @rdname geom_countrybins_africa
#' @param mapping Set of aesthetic mappings created by `aes()` or
#'   `aes_()`. If specified and `inherit.aes = TRUE` (the
#'   default), it is combined with the default mapping at the top level of the
#'   plot. You must supply `mapping` if there is no plot mapping.
#' @param data The data to be displayed in this layer. There are three
#'    options:
#'
#'    If `NULL`, the default, the data is inherited from the plot
#'    data as specified in the call to `ggplot()`.
#'
#'    A `data.frame`, or other object, will override the plot
#'    data. All objects will be fortified to produce a data frame. See
#'    `fortify()` for which variables will be created.
#'
#'    A `function` will be called with a single argument,
#'    the plot data. The return value must be a `data.frame.`, and
#'    will be used as the layer data.
#' @param border_col border color of the country squares, default "`white`"
#' @param border_size thickness of the square country borders
#' @param lbl_size font size (relative) of the label text
#' @param dark_lbl,light_lbl colrs to be uses when the label should be dark or light.
#'        The function automagically computes when this should be.
#' @param radius the corner radius
#' @param na.rm If `FALSE`, the default, missing values are removed with
#'   a warning. If `TRUE`, missing values are silently removed.
#' @param ... other arguments passed on to `layer()`. These are
#'   often aesthetics, used to set an aesthetic to a fixed value, like
#'   `color = "red"` or `size = 3`. They may also be parameters
#'   to the paired geom/stat.
#' @param show.legend logical. Should this layer be included in the legends?
#'   `NA`, the default, includes if any aesthetics are mapped.
#'   `FALSE` never includes, and `TRUE` always includes.
#'   It can also be a named logical vector to finely select the aesthetics to
#'   display.
#' @param inherit.aes If `FALSE`, overrides the default aesthetics,
#'   rather than combining with them. This is most useful for helper functions
#'   that define both data and aesthetics and shouldn't inherit behaviour from
#'   the default plot specification, e.g. `borders()`.
#'
#' @examples \dontrun{
#' library(tidyverse)
#' library(africaCountryBins)
#' library(hrbrthemes)
#'
#' data("africa_mines")
#'
#' count(africa_mines, countrycode, wt=count) %>%
#'   mutate(n = ifelse(n == 0, NA, n)) %>%
#'   ggplot(aes(country = countrycode, fill = n)) +
#'   geom_countrybins_africa() +
#'   coord_fixed() +
#'   scale_fill_viridis_c(
#'       name = "# mines (log2)",
#'       option = "magma",
#'       direction = -1,
#'       na.value = "#DEE5E8",
#'       trans = "log2",
#'       label = scales::comma_format(1)
#'    ) +
#'    guides(
#'        fill = guide_colourbar(
#'        title.position = "top"
#'        )
#'    ) +
#'    labs(
#'        title = "Mines in Africa",
#'        caption = "Source: data.world <hdata.world/datainspace/mines-in-africa>"
#'    ) +
#'      theme_minimal()
#' }
#' @export
geom_countrybins_africa <- function(
  mapping = NULL,
  data = NULL,
  border_col = "white",
  border_size = 2,
  lbl_size = 3,
  dark_lbl = "black",
  light_lbl = "white",
  radius = grid::unit(6, "pt"),
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE){

  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomcountrybinsAfrica,
    position = "identity",
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      border_col = border_col,
      border_size = border_size,
      lbl_size = lbl_size,
      dark_lbl = dark_lbl,
      light_lbl = light_lbl,
      radius = radius,
      na.rm = na.rm,
      ...
    )
  )
  }


#' @rdname geom_countrybins_africa
#' @export
GeomcountrybinsAfrica <- ggplot2::ggproto(
  "GeomcountrybinsAfrica", ggplot2::Geom,
  default_aes = ggplot2::aes(
    fill = "grey20",
    colour = NA,
    size = 0.1,
    linetype = 1,
    country = "country",
    label="abrv_3_letter",
    angle = 0,
    hjust = 0.5,
    vjust = 0.5,
    alpha = NA,
    family = "",
    fontface = 1,
    lineheight = 1.2
    ),
  extra_params = c(
    "na.rm",
    "width",
    "height"
    ),
  setup_data = function(
    data,
    params) {
    country_data <- data.frame(data, stringsAsFactors=FALSE)

    if (max(nchar(country_data[,"country"])) <= 2) {
      merge.x <- "abrv_2_letter"
    }
    else if (max(nchar(country_data[,"country"])) <= 3){
      merge.x <- "abrv_3_letter"
    }
    else {
      merge.x <- "country"
    }
    country_data <- validate_countries(country_data, "country", merge.x, ignore_dupes=TRUE)
    ctry.dat <- merge(b_country_coords,
                      country_data,
                      by.x=merge.x,
                      by.y="country",
                      all.y=TRUE,
                      sort=TRUE)

    ctry.dat$width  <- ctry.dat$width  %||% params$width  %||% ggplot2::resolution(ctry.dat$x, FALSE)
    ctry.dat$height <- ctry.dat$height %||% params$height %||% ggplot2::resolution(ctry.dat$y, FALSE)
    transform(ctry.dat,
              xmin = x - width / 2,
              xmax = x + width / 2,
              width = NULL,
              ymin = y - height / 2,
              ymax = y + height / 2,
              height = NULL
              ) -> xdat
    xdat
    },
  required_aes = c("country", "fill"),
  draw_panel = function(self, data,
                        panel_params,
                        coord,
                        border_col = "white",
                        border_size = 2,
                        lbl_size = 3,
                        dark_lbl = "black",
                        light_lbl = "white",
                        radius = grid::unit(6, "pt")) {
    tile_data <- data
    tile_data$colour <- border_col
    tile_data$size <- border_size

    text_data <- data
    text_data$label <- data$abrv_3_letter
    text_data$fill <- NA
    text_data$size <-  lbl_size
    text_data$colour <- .sb_invert(
      data$fill,
      dark_lbl,
      light_lbl
      )
    coord <- coord_equal()
    grid::gList(
      GeomRtile$draw_panel(tile_data, panel_params, coord, radius),
      ggplot2::GeomText$draw_panel(text_data, panel_params, coord)
      ) -> grobs
    ggname("geom_countrybins_africa", grid::grobTree(children = grobs))

    },
  draw_key = ggplot2::draw_key_polygon

)
