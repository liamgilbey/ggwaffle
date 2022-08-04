# ==============================================================================
# test iron functionality

testthat::test_that('waffle_iron works as intended with aes_d', {
    result <- waffle_iron(
        data = iris,
        mapping = aes_d(group = Species),
        rows = 8,
        sample_size = 1,
        na.rm = T
    )

    testthat::expect_equal(
      nrow(result),
      nrow(iris)
    )

    testthat::expect_equal(
      max(result$y),
      8
    )

    testthat::expect_equal(
      max(result$x),
      ceiling(nrow(iris) / 8)
    )

})

testthat::test_that('waffle_iron works as intended with aes_d_', {
  result <- waffle_iron(
    data = iris,
    mapping = aes_d_(group = 'Species'),
    rows = 8,
    sample_size = 1,
    na.rm = T
  )

  testthat::expect_equal(
    nrow(result),
    nrow(iris)
  )

  testthat::expect_equal(
    max(result$y),
    8
  )

  testthat::expect_equal(
    max(result$x),
    ceiling(nrow(iris) / 8)
  )

})

testthat::test_that('waffle_iron works as intended with a character mapping', {
  result <- waffle_iron(
    data = iris,
    mapping = 'Species',
    rows = 8,
    sample_size = 1,
    na.rm = T
  )

  testthat::expect_equal(
    nrow(result),
    nrow(iris)
  )

  testthat::expect_equal(
    max(result$y),
    8
  )

  testthat::expect_equal(
    max(result$x),
    ceiling(nrow(iris) / 8)
  )

})

testthat::test_that("Sample size > 1 fails", {
  testthat::expect_error(
    waffle_iron(
      data = iris,
      mapping = aes_d(group = Species),
      rows = 8,
      sample_size = 2,
      na.rm = T
    ),
    "Please use a sample value between 0 and 1"
  )
})

testthat::test_that("Sample size <= 0 fails", {
  testthat::expect_error(
    waffle_iron(
      data = iris,
      mapping = aes_d(group = Species),
      rows = 8,
      sample_size = 0,
      na.rm = T
    ),
    "Please use a sample value between 0 and 1"
  )
})

testthat::test_that("Very small sample size is rejected", {
  testthat::expect_error(
    waffle_iron(
      data = iris,
      mapping = aes_d(group = Species),
      rows = 8,
      sample_size = 0.01,
      na.rm = T
    ),
    "The sample size is too low for this dataset"
  )
})

testthat::test_that("Sampling works as intended", {
  samplesize <- 0.5

  result <- waffle_iron(
    data = iris,
    mapping = aes_d(group = Species),
    rows = 8,
    sample_size = samplesize,
    na.rm = T
  )

  testthat::expect_equal(
    nrow(result),
    floor(nrow(iris) * samplesize)
  )

  testthat::expect_equal(
    max(result$y),
    8
  )

  testthat::expect_equal(
    max(result$x),
    ceiling(nrow(iris) * samplesize / 8)
  )
})


testthat::test_that("Sampling works as intended across all possible samples", {
  # check 500 random samples to see if we have good coverage across any sample size
  set.seed(123456)
  samplesizes <- runif(n = 500, min = 8 / nrow(iris), max = 1)

  result <- lapply(
    samplesizes,
    function(x){
      waffle_iron(
        data = iris,
        mapping = aes_d(group = Species),
        rows = 8,
        sample_size = x,
        na.rm = T
      )
    }
  )

  testthat::expect_identical(
    as.numeric(sapply(result, nrow)),
    sapply(samplesizes, function(x) floor(nrow(iris) * x))
  )

  testthat::expect_identical(
    as.numeric(sapply(result, function(x) max(x$y))),
    rep(8, length(result))
  )

  testthat::expect_identical(
    as.numeric(sapply(result, function(x) max(x$x))),
    sapply(samplesizes, function(x) ceiling(floor(nrow(iris) * x) / 8))
  )

})


testthat::test_that('na.rm works as intended', {
  result <- waffle_iron(
    data = iris,
    mapping = aes_d(group = Species),
    rows = 8,
    sample_size = 1,
    na.rm = F
  )

  testthat::expect_gt(
    nrow(result),
    nrow(iris)
  )

  testthat::expect_equal(
    max(result$y),
    8
  )

  testthat::expect_equal(
    max(result$x),
    ceiling(nrow(iris) / 8)
  )

  testthat::expect_equal(
    nrow(result),
    8 * ceiling(nrow(iris) / 8)
  )
})
