create_waffle <- function(data, rows = 8){
  data <- data %>% arrange(class)
  grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(nrow(data) / rows))))
  grid_data$group <- c(data$class, rep(NA, nrow(grid_data) - length(data$class)))
  return(grid_data)
}



