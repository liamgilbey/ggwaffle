stat_waffle <- function(mapping = NULL, data = NULL,
                        geom = "tile", position = "identity",
                        ...,
                        width = NULL,
                        na.rm = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {



  layer(
    data = data,
    mapping = mapping,
    stat = StatWaffle,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = FALSE
    )
  )
}


StatWaffle <- ggproto("StatWaffle", Stat,
                      required_aes = "x",
                      default_aes = aes(colour = "white"),
                     compute_group = function(self, data, scales, width = NULL, height = NULL, rows = 6) {
                       x <- sort(data$x)
                       width <- width %||% (resolution(x) * 0.9)
                       height <- height %||% (resolution(x) * 0.9)
                       grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(length(x) / rows))))
                       grid_data$width <- width
                       grid_data$height <- height
                       print(grid_data)
                       grid_data
                     }
)
