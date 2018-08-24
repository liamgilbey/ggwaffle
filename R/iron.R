#' Waffle Iron
#'
#' Pour your data into a waffle iron.
#' @param data A dataframe to feed into the waffle iron
#' @param mapping A mapping as produce by \code{aes_d}
#' @param rows The number of rows in the waffle
#' @export
#' @examples
#' iron(mpg, aes_d(group = class))
iron <- function(data, mapping, rows = 8){
  data <- aes_d_rename(data, mapping)
  data <- data[order(data$group),]
  grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(nrow(data) / rows))))
  grid_data$group <- c(data$group, rep(NA, nrow(grid_data) - length(data$group)))
  return(grid_data)
}
