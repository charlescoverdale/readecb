test_that("ecb_euribor returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_euribor("3M", from = "2024-01", to = "2024-06")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "tenor", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
  expect_true(all(df$tenor == "3M"))
})

test_that("ecb_euribor handles multiple tenors", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_euribor(c("1M", "12M"), from = "2024-01", to = "2024-03")

  expect_true("1M" %in% df$tenor)
  expect_true("12M" %in% df$tenor)
})

test_that("ecb_euribor rejects invalid tenor", {
  expect_error(ecb_euribor("2M"))
})

test_that("ecb_euribor values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_euribor("3M", from = "2024-01", to = "2024-06")
  expect_true(all(df$value > -2 & df$value < 10))
})
