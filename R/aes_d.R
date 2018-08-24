aes_d <- function (...)
{
  as.list(match.call()[-1])
}
m <- aes_d(class = group)

aes_d_rename <- function(data, mapping){
  for(i in mapping){
    names(data)[names(data)==names(mapping)] <- mapping
  }
  data
}
aes_d_rename(mpg, aes_d(class = group))


