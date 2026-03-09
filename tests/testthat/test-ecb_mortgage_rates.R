test_that("ecb_mortgage_rates returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_mortgage_rates(from = "2024-01", to = "2024-06")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "country", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_mortgage_rates values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_mortgage_rates(from = "2024-01", to = "2024-06")
  expect_true(all(df$value > 0 & df$value < 20))
})
