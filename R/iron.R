#' Waffle Iron
#'
#' Pour your data into a waffle iron to get ready to cook a waffle chart.
#'
#' Prepare raw data so it is fit to create a waffle visualisation. The type of data transformation that is required does not gel
#' well with ggplot2 underlying mechanism. The way around this is to provide a function that does the preperation outside of ggplot.
#' @param data A dataframe to feed into the waffle iron
#' @param mapping A mapping as produce by \code{aes_d}
#' @param rows The number of rows in the waffle
#' @export
#' @examples
#' waffle_iron(mpg, aes_d(group = class))
waffle_iron <- function(data, mapping, rows = 8){
  data <- aes_d_rename(data, mapping, c("group"))
  data <- data[order(data$group),]
  grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(nrow(data) / rows))))
  grid_data$group <- c(data$group, rep(NA, nrow(grid_data) - length(data$group)))
  return(grid_data)
}
