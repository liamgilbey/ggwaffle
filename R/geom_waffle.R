#' Create a waffle layer
#'
#' @inheritParams ggplot2::geom_tile
#' @param tile_shape Control the shape of the waffle tiles. One of either c("square", "circle")
#' @export
#' @examples
#' ggplot(data = waffle_iron(mpg, aes_d(group = class)), aes(x, y, fill = group)) +
#' geom_waffle() +
#' coord_equal()
geom_waffle <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  tile_shape = c("square", "circle"),
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  tile_shape <- match.arg(tile_shape)
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = switch(
      tile_shape,
      square = GeomWaffleSquare,
      circle = GeomWaffleCircle
    ),
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' Geom Waffle Square
#' @export
GeomWaffleSquare <- ggproto(
  "GeomWaffleSquare",
  GeomTile,
  default_aes = aes(
    colour = "white",
    linewidth = 2,
    alpha = NA
  ),
  required_aes = c("x", "y", "fill")
)

#' Geom Waffle Circle
#' @export
GeomWaffleCircle <- ggproto(
  "GeomWaffleCircle",
  GeomPoint,
  default_aes = aes(
    shape = 19,
    colour = "black",
    size = 8,
    fill = NA,
    alpha = NA,
    stroke = 0.5
  ),
  required_aes = c("x", "y", "colour")
)
