test_that("list_exchange_rates returns expected structure", {
  df <- list_exchange_rates()

  expect_s3_class(df, "data.frame")
  expect_named(df, c("code", "currency"))
  expect_true(nrow(df) > 20)
  expect_true("USD" %in% df$code)
  expect_true("GBP" %in% df$code)
})

test_that("list_ecb_dataflows returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- list_ecb_dataflows()

  expect_s3_class(df, "data.frame")
  expect_true("dataflow_id" %in% names(df))
  expect_true("name" %in% names(df))
  expect_true(nrow(df) > 50)
  expect_true("EXR" %in% df$dataflow_id)
})
