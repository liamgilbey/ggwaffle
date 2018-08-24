#' Create a waffle layer
#'
#' @inheritParams ggplot2::geom_tile
#' @export
#' @examples
#' ggplot(data = iron(mpg, aes_d(group = class)), aes(x, y, fill = group)) +
#' geom_waffle() +
#' coord_equal()
geom_waffle <- function(mapping = NULL, data = NULL,
                      stat = "identity", position = "identity",
                      ...,
                      na.rm = FALSE,
                      show.legend = NA,
                      inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomWaffle,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' Geom Waffle
#' @export
GeomWaffle <- ggproto("GeomWaffle", GeomTile,

                      default_aes = aes(colour = "white", size = 2, alpha = NA),

                      required_aes = c("x", "y", "fill")
)
