test_that("ecb_policy_rates returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_policy_rates(from = "2024-01", to = "2024-03")

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "rate", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$rate, "character")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_policy_rates includes all three rates", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_policy_rates(from = "2024-01", to = "2024-01")
  rates <- unique(df$rate)

  expect_true("Main refinancing rate" %in% rates)
  expect_true("Deposit facility rate" %in% rates)
  expect_true("Marginal lending rate" %in% rates)
})

test_that("ecb_policy_rates values are plausible", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_policy_rates(from = "2024-01", to = "2024-03")
  expect_true(all(df$value >= -1 & df$value <= 20))
})
