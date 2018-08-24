#' Rename columns in a dataset
#'
#' This function is designed to take a dataset and a data aesthetic mapping and rename the columns.
#' @param data Data to rename
#' @param mapping A mapping as produce by \code{aes_d}
aes_d_rename <- function(data, mapping){
  for(i in mapping){
    names(data)[names(data)==mapping] <- names(mapping)
  }
  data
}

#' Aesthetic mappings for datasets
#'
#' The idea comes straight from \code{aes} in ggplot2. That provides a way to map columns of a dataset to features of graphic.
#' Here we are mapping columns into a function so we can use standard names inside that function.
#'
#' A mapping looks like: <column_to_be_created> = <existing column>
#' @export
#' @examples
#' aes_d(group = class)
aes_d <- function (...)
{
  as.list(match.call()[-1])
}
