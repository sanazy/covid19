test_that("start_date parameter is larger than 2020-01-22", {
  expect_equal(timeSeriesPlot("2020-01-01", "2020-10-01", "Iran"), -1)
})

test_that("end_date parameter is larger than start_date", {
  expect_equal(timeSeriesPlot("2020-10-01", "2020-09-01", "Iran"), -2)
})
