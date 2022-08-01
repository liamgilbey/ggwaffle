#' Rename columns in a dataset
#'
#' This function is designed to take a dataset and a data aesthetic mapping and rename the columns.
#'
#' @param data Dataset to perform renaming
#' @param mapping A mapping as provided by \link{\code{aes_d}}
#' @param compulsory_cols A character vector of compulsory columns needed to perform renaming
#'
#' @keywords internal
#'
#' @export
aes_d_rename <- function(
  data,
  mapping,
  compulsory_cols
){
  mapping <- aes_d_validate(mapping, compulsory_cols, names(data))
  for(i in 1:length(mapping)){
    names(data)[names(data)==mapping[i]] <- names(mapping)[i]
  }
  data
}

#' Validate an \code{aes_d} mapping
#'
#' Don't just trust the user to provide the mappings we need
#'
#' @param mapping A mapping as provided by \link{\code{aes_d}}
#' @param compulsory_cols A character vector of compulsory columns needed to perform renaming
#' @param data_names Names from the incoming dataset to be renamed
#'
#' @keywords internal
#'
#' @export
aes_d_validate <- function(
  mapping,
  compulsory_cols,
  data_names
){
  # missing columns
  missing_cols <- compulsory_cols[!compulsory_cols %in% names(mapping)]
  if(length(missing_cols) > 0){
    example <- paste(paste(missing_cols, "= your_column"), collapse = ", ")
    error_message <- paste0("Please provide a mapping for the following columns: ", paste(missing_cols, collapse = ", "), "\n    For example:\n      aes_d(", example, ")")
    stop(error_message, call. = F)
  }
  # additional columns
  additional_cols <- names(mapping)[!names(mapping) %in% compulsory_cols]
  if(length(additional_cols > 0)){
    mapping <- mapping[names(mapping) %in% compulsory_cols]
    warning_message <- paste0("Columns have been supplied to aes_d but are not required:\n    ", paste(additional_cols, collapse = ", "))
    warning(warning_message, call. = F)
  }
  # incorrect columns
  incorrect_cols <- mapping[!mapping %in% data_names]
  if(length(incorrect_cols)>0){
    error_message <- paste0("Columns are not present in your dataset:\n    ", paste(incorrect_cols, collapse = ", ") )
    stop(error_message, call. = F)
  }
  return(mapping)
}

#' Aesthetic mappings for datasets
#'
#' The idea comes straight from \code{aes} in ggplot2. That provides a way to map columns of a dataset to features of graphic.
#' Here we are mapping columns into a function so we can use standard names inside that function.
#'
#' A mapping looks like: <column_to_be_created> = <existing column>
#' @param ... Unquoted, comma-seperated column mappings
#' @export
#' @examples
#' aes_d(group = class)
aes_d <- function (...)
{
  as.list(match.call()[-1])
}
