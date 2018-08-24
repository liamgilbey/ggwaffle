#' Waffle chart theme
#'
#' Flavour your waffles with a standard theme
#' @export
#' @examples
#' ggplot(data = waffle_iron(mpg, aes_d(group = class)), aes(x, y, fill = group)) +
#' geom_waffle() +
#' theme_waffle()
theme_waffle <- function(){
  theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.text = element_blank(),
    axis.title.x = element_text(size = 10),
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    axis.ticks.length = unit(0, "null"),
    plot.title = element_text(size = 18),
    plot.background = element_blank(),
    panel.spacing = unit(c(0, 0, 0, 0), "null")
  )
}
