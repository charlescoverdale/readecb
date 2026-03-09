test_that("ecb_gdp returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_gdp(from = "2023", to = "2024")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_gdp values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_gdp(from = "2023", to = "2024")
  # Euro area GDP should be in the millions of euros range

  expect_true(all(df$value > 1000000))
})
