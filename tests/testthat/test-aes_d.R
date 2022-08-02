# ==============================================================================
# test aes_d functionality

testthat::test_that("aes_d creates a list of names", {
    mapping <- aes_d(group = column)
    manual_mapping <- list(
      group = as.name("column")
    )
    testthat::expect_equal(mapping, manual_mapping)
  }
)

testthat::test_that("aes_d and aes_d_ are equivalanet", {
  mapping <- aes_d(group = column)
  mapping_ <- aes_d_(group = 'column')
  testthat::expect_equal(mapping, mapping_)

  manual_mapping_ <- list(
    group = as.name("column")
  )
  testthat::expect_equal(mapping_, manual_mapping_)
})

testthat::test_that("aes_d validation works with one column", {
  mapping <- aes_d(group = column)
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_equal(aes_d_validate(mapping, compulsory_cols, data_names), mapping)
})

testthat::test_that("aes_d validation works with two columns", {
  mapping <- aes_d(group = column, value = field)
  compulsory_cols <- c("group", 'value')
  data_names <- c("column", 'field')
  testthat::expect_equal(aes_d_validate(mapping, compulsory_cols, data_names), mapping)
})

testthat::test_that("aes_d validation fails with invalid input data", {
  mapping <- aes_d(group = column)
  compulsory_cols <- c("group")
  data_names <- c("colum")
  testthat::expect_error(aes_d_validate(mapping, compulsory_cols, data_names), "Columns are not present")
})

testthat::test_that("aes_d validation fails with invalid mapping", {
  mapping <- aes_d(grop = column)
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_error(aes_d_validate(mapping, compulsory_cols, data_names), "Please provide a mapping for the following columns")
})

testthat::test_that("aes_d warns about superfluous columns", {
  mapping <- aes_d(group = column, value = field)
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_warning(aes_d_validate(mapping, compulsory_cols, data_names), "Columns have been supplied to aes_d but are not required")
})

testthat::test_that("aes_d_ validation works with one column", {
  mapping <- aes_d_(group = 'column')
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_equal(aes_d_validate(mapping, compulsory_cols, data_names), mapping)
})

testthat::test_that("aes_d_ validation works with two columns", {
  mapping <- aes_d_(group = 'column', value = 'field')
  compulsory_cols <- c("group", 'value')
  data_names <- c("column", 'field')
  testthat::expect_equal(aes_d_validate(mapping, compulsory_cols, data_names), mapping)
})

testthat::test_that("aes_d_ validation fails with invalid input data", {
  mapping <- aes_d_(group = 'column')
  compulsory_cols <- c("group")
  data_names <- c("colum")
  testthat::expect_error(aes_d_validate(mapping, compulsory_cols, data_names), "Columns are not present")
})

testthat::test_that("aes_d_ validation fails with invalid mapping", {
  mapping <- aes_d_(grop = 'column')
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_error(aes_d_validate(mapping, compulsory_cols, data_names), "Please provide a mapping for the following columns")
})

testthat::test_that("aes_d_ warns about superfluous columns", {
  mapping <- aes_d_(group = 'column', value = 'field')
  compulsory_cols <- c("group")
  data_names <- c("column")
  testthat::expect_warning(aes_d_validate(mapping, compulsory_cols, data_names), "Columns have been supplied to aes_d but are not required")
})

testthat::test_that("aes_d renames one column successfully", {
  mapping <- aes_d(group = column)
  compulsory_cols <- c("group")
  data_names <- c("column")
  dataset <- data.frame(column = as.numeric())
  result <- aes_d_rename(dataset, mapping, compulsory_cols)
  testthat::expect_equal(names(result), 'group')
})

testthat::test_that("aes_d renames multiple columns successfully", {
  mapping <- aes_d(group = column, value = field)
  compulsory_cols <- c("group", 'value')
  data_names <- c("column", 'field')
  dataset <- data.frame(column = as.numeric(), field = as.numeric())
  result <- aes_d_rename(dataset, mapping, compulsory_cols)
  testthat::expect_equal(names(result), c('group', 'value'))
})

testthat::test_that("aes_d only renames column that are required", {
  mapping <- aes_d(group = column, value = field)
  compulsory_cols <- c("group")
  data_names <- c("column")
  dataset <- data.frame(column = as.numeric(), field = as.numeric())
  result <- suppressWarnings({aes_d_rename(dataset, mapping, compulsory_cols)})
  testthat::expect_equal(names(result), c('group', 'field'))
})
