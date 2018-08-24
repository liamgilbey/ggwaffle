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
#' @export
#' @examples
#' aes_d(group = class)
aes_d <- function (...)
{
  as.list(match.call()[-1])
}
