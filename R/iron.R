#' Waffle Iron
#'
#' Pour your data into a waffle iron to get ready to cook a waffle chart.
#'
#' Prepare raw data so it is fit to create a waffle visualisation. The type of data transformation that is required does not gel
#' well with ggplot2 underlying mechanism. The way around this is to provide a function that does the preperation outside of ggplot.
#' @param data A dataframe to feed into the waffle iron
#' @param mapping A mapping as produce by \code{aes_d}
#' @param rows The number of rows in the waffle
#' @param sample_size The proportion of rows to sample the dataset (between 0 and 1). Useful when the dataset is too large to plot correctly.
#' @export
#' @examples
#' waffle_iron(mpg, aes_d(group = class))
#'
#' waffle_iron(mpg, aes_d(group = class), sample_size = 0.75)
waffle_iron <- function(data, mapping, rows = 8, sample_size = 1){
  # sample the data
  if(!(sample_size>0 & sample_size <=1)){
    stop("Please use a sample value between 0 and 1")
  }
  sample_rows <- sample(x = 1:nrow(data), size = (nrow(data) * sample_size))
  data <- data[sample_rows,]
  # create the waffle dataset
  data <- aes_d_rename(data, mapping, c("group"))
  data <- data[order(data$group),]
  grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(nrow(data) / rows))))
  grid_data$group <- c(data$group, rep(NA, nrow(grid_data) - length(data$group)))
  return(grid_data)
}
