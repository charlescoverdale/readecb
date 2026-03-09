test_that("ecb_get returns data with parsed dates", {
  skip_on_cran()
  skip_if_offline()

  df <- ecb_get("EXR", "M.USD.EUR.SP00.A", from = "2024-01", to = "2024-03")

  expect_s3_class(df, "data.frame")
  expect_s3_class(df$TIME_PERIOD, "Date")
  expect_type(df$OBS_VALUE, "double")
  expect_true(nrow(df) > 0)
})
