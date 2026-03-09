test_that("ecb_money_supply returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_money_supply("M3", from = "2024-01", to = "2024-06")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_money_supply rejects invalid aggregate", {
  expect_error(ecb_money_supply("M4"))
})

test_that("ecb_money_supply values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_money_supply("M3", from = "2024-01", to = "2024-06")
  expect_true(all(df$value > 1000000))
})
