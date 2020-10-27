
test_that("date parameter is larger than 2020-01-22", {
  expect_equal(worldMapPlot("2020-01-01", "death"), -1)
})

test_that("type parameter is death or all", {
  expect_equal(worldMapPlot("2020-10-02", "something"), -2)
})
