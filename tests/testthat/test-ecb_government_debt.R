test_that("ecb_government_debt returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_government_debt(from = "2015", to = "2023")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_government_debt values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_government_debt(from = "2015", to = "2023")
  # Euro area debt-to-GDP should be between 30% and 200%
  expect_true(all(df$value > 30 & df$value < 200))
})
