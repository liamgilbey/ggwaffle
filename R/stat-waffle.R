stat_waffle <- function(mapping = NULL, data = NULL,
                        geom = "bar", position = "stack",
                        ...,
                        width = NULL,
                        na.rm = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {

  params <- list(
    na.rm = na.rm,
    width = width,
    ...
  )
  if (!is.null(params$y)) {
    stop("stat_waffle() must not be used with a y aesthetic.", call. = FALSE)
  }

  layer(
    data = data,
    mapping = mapping,
    stat = StatCount,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = params
  )
}


StatWaffle <- ggproto("StatWaffle", Stat,
                     required_aes = "x",
                     default_aes = aes(y = stat(waffle), weight = 1),

                     setup_params = function(data, params) {
                       if (!is.null(data$y)) {
                         stop("stat_waffle() must not be used with a y aesthetic.", call. = FALSE)
                       }
                       params
                     },

                     compute_group = function(self, data, scales, width = NULL) {
                       x <- data$x
                       weight <- data$weight %||% rep(1, length(x))
                       width <- width %||% (resolution(x) * 0.9)

                       count <- as.numeric(tapply(weight, x, sum, na.rm = TRUE))
                       count[is.na(count)] <- 0

                       data.frame(
                         count = count,
                         prop = count / sum(abs(count)),
                         x = sort(unique(x)),
                         width = width
                       )
                     }
)
