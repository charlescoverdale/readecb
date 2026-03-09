test_that("ecb_exchange_rate returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_exchange_rate("USD", from = "2024-01", to = "2024-03")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "currency", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$currency, "character")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
  expect_true(all(df$currency == "USD"))
})

test_that("ecb_exchange_rate handles multiple currencies", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_exchange_rate(c("USD", "GBP"), from = "2024-01", to = "2024-03")

  expect_true("USD" %in% df$currency)
  expect_true("GBP" %in% df$currency)
})

test_that("ecb_exchange_rate supports daily frequency", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_exchange_rate("USD", frequency = "daily",
                          from = "2024-01", to = "2024-01")
  expect_true(nrow(df) > 5)
})

test_that("ecb_exchange_rate rejects invalid frequency", {
  expect_error(ecb_exchange_rate("USD", frequency = "weekly"))
})
