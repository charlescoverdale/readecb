test_that("ecb_estr returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_estr(from = "2024-01", to = "2024-03")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_estr values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_estr(from = "2024-01", to = "2024-03")
  expect_true(all(df$value > -2 & df$value < 10))
})
