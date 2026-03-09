test_that("ecb_unemployment returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_unemployment(from = "2024-01", to = "2024-06")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_unemployment values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_unemployment(from = "2024-01", to = "2024-06")
  # Euro area unemployment should be between 2% and 30%
  expect_true(all(df$value > 2 & df$value < 30))
})
