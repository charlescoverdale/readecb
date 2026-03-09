test_that("ecb_yield_curve returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_yield_curve("10Y", from = "2024-01", to = "2024-03")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "tenor", "value"))
  expect_s3_class(df$date, "Date")
  expect_true(nrow(df) > 0)
  expect_true(all(df$tenor == "10Y"))
})

test_that("ecb_yield_curve handles multiple tenors", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_yield_curve(c("2Y", "10Y"), from = "2024-01", to = "2024-03")

  expect_true("2Y" %in% df$tenor)
  expect_true("10Y" %in% df$tenor)
})

test_that("ecb_yield_curve values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_yield_curve("10Y", from = "2024-01", to = "2024-03")
  expect_true(all(df$value > -2 & df$value < 15))
})
