% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aes_d.R
\name{aes_d}
\alias{aes_d}
\title{Aesthetic mappings for datasets}
\usage{
aes_d(...)
}
\arguments{
\item{...}{Unquoted, comma-seperated column mappings}
}
\description{
The idea comes straight from \code{aes} in ggplot2. That provides a way to map columns of a dataset to features of graphic.
Here we are mapping columns into a function so we can use standard names inside that function. This function variant
expects unquoted string arguments, rather than the quoted version \code{\link{aes_d_}}
}
\details{
A mapping looks like: <column_to_be_created> = <existing column>
}
\examples{
aes_d(group = class)
}
