waffle_colours <- c(
  "#FFE089",
  "#FDC210",
  "#E7911E",
  "#A14E16",
  "#883408"
)

waffle_pal <- function(){
  function(n){
    waffle_colours[1:n]
  }
}

#' Waffle colour scales
#'
#' Turn your visualisations into real waffles with the colours of waffles
#' @param ... Other arguments passed on to discrete_scale to control name, limits, breaks, labels and so forth.
#' @param na.value Colour to use for missing values
#' @name waffle_scales
NULL
#> NULL

#' @rdname waffle_scales
#' @export
scale_fill_waffle <- function(..., na.value = "red"){
  discrete_scale(aesthetics = "fill", scale_name = "waffle", palette = waffle_pal(), na.value = na.value,
                 ...)
}

#' @rdname waffle_scales
#' @export
scale_colour_waffle <- function(..., na.value = "red"){
  discrete_scale(aesthetics = "fill", scale_name = "waffle", palette = waffle_pal(), na.value = na.value,
                 ...)
}
