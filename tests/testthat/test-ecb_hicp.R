test_that("ecb_hicp returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_hicp(from = "2024-01", to = "2024-06")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "country", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_hicp supports multiple countries", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_hicp(c("DE", "FR"), from = "2024-01", to = "2024-03")

  expect_true("DE" %in% df$country)
  expect_true("FR" %in% df$country)
})

test_that("ecb_hicp supports index measure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_hicp(measure = "index", from = "2024-01", to = "2024-03")
  expect_true(all(df$value > 50))
})

test_that("ecb_hicp rejects invalid measure", {
  expect_error(ecb_hicp(measure = "invalid"))
})
