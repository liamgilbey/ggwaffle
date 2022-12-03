#' Waffle Iron
#'
#' Pour your data into a waffle iron to get ready to cook a waffle chart.
#'
#' Prepare raw data so it is fit to create a waffle visualisation. The type of data transformation that is required does not gel
#' well with ggplot2 underlying mechanism. The way around this is to provide a function that does the preperation outside of ggplot.
#' @param data A dataframe to feed into the waffle iron
#' @param mapping A mapping as produce by \code{\link{aes_d}}, \code{\link{aes_d_}} or a character vector of a column present in the dataset
#' @param rows The number of rows in the waffle
#' @param sample_size The proportion of rows to sample the dataset (between 0 and 1). Useful when the dataset is too large to plot correctly.
#' @param na.rm A boolean flag to automatically remove NAs. Removing NAs will sometimes cause a missing notch in your waffle.
#' @export
#' @examples
#' waffle_iron(mpg, aes_d(group = class))
#'
#' waffle_iron(mpg, aes_d(group = class), sample_size = 0.75)
#'
#' # data can be facetted by supplying a `facet_with` argument
#' waffle_iron(mpg, aes_d(group = class, facet_with = year))
waffle_iron <- function(
  data,
  mapping,
  rows = 8,
  sample_size = 1,
  na.rm = T
){
  # sample the data
  if(!(sample_size>0 & sample_size <=1)){
    stop("Please use a sample value between 0 and 1", call. = F)
  }
  sample_rows <- sample(x = 1:nrow(data), size = (nrow(data) * sample_size))
  if(length(sample_rows) < rows){
    min_sample_size <- round(rows / nrow(data), 2)
    stop(paste0("The sample size is too low for this dataset, it must be at least ",min_sample_size) , call. = F)
  }

  data <- data[sample_rows,]

  # if a character mapping supplied, generate an `aes_d_` mapping instead
  if(inherits(mapping, "character")){
    mapping <- aes_d_(group = mapping)
  }

  # create the waffle dataset
  data <- aes_d_rename(
    data = data,
    mapping = mapping,
    compulsory_cols = c("group"),
    optional_cols = c("facet_with")
  )
  data <- data[order(data$group),]

  # if we need to facet, split the data, and then recombine
  if('facet_with' %in% names(data)){
    data_split <- split(data, as.factor(data$facet_with))
    grid_data_list <- mapply(
      FUN = function(x, y, rows){
        g <- .waffle_iron_expander(
          data = x,
          rows = rows
        )
        g$facet_with <- y
        g
      },
      x = data_split,
      y = names(data_split),
      MoreArgs = list(rows = rows),
      SIMPLIFY = FALSE
    )
    grid_data <- do.call(rbind, grid_data_list)

  } else{
    grid_data <- .waffle_iron_expander(data, rows)
  }

  # deal with NAs
  if(na.rm == T){
    grid_data <- grid_data[!is.na(grid_data$group),]
  }
  grid_data
}


#' @internal
.waffle_iron_expander <- function(
  data,
  rows
){
  grid_data <- expand.grid(y = 1:rows, x = seq_len((ceiling(nrow(data) / rows))))
  grid_data$group <- c(data$group, as.factor(rep(NA, nrow(grid_data) - length(data$group))))
  grid_data
}
