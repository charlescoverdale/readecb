test_that("ecb_hicp returns expected structure", {
  skip_on_cran()
  skip_if_offline()

  df <- expect_ecb(ecb_hicp(from = "2024-01", to = "2024-06"))

  expect_s3_class(df, "data.frame")
  expect_named(df, c("date", "country", "value"))
  expect_s3_class(df$date, "Date")
  expect_type(df$value, "double")
  expect_true(nrow(df) > 0)
})

test_that("ecb_hicp supports multiple countries", {
  skip_on_cran()
  skip_if_offline()

  df <- expect_ecb(ecb_hicp(c("DE", "FR"), from = "2024-01", to = "2024-03"))

  expect_true("DE" %in% df$country)
  expect_true("FR" %in% df$country)
})

test_that("ecb_hicp supports index measure", {
  skip_on_cran()
  skip_if_offline()

  df <- expect_ecb(ecb_hicp(measure = "index", from = "2024-01", to = "2024-03"))
  expect_true(all(df$value > 50))
})

test_that("ecb_hicp rejects invalid measure", {
  expect_error(ecb_hicp(measure = "invalid"))
})

test_that("ecb_hicp euro area series is current", {
  skip_on_cran()
  skip_if_offline()

  # The ICP dataflow stopped at December 2025 when the HICP moved to
  # ECOICOP 2; a silent switch back would leave the series months stale.
  df <- expect_ecb(ecb_hicp(from = "2025-01", cache = FALSE))
  expect_gt(max(df$date), Sys.Date() - 120)
})

test_that("ecb_hicp computes a month-on-month rate from the index", {
  skip_on_cran()
  skip_if_offline()

  idx <- expect_ecb(ecb_hicp(measure = "index", from = "2025-01", to = "2025-06"))
  mom <- expect_ecb(ecb_hicp(measure = "monthly_rate", from = "2025-01", to = "2025-06"))
  expect_equal(nrow(mom), nrow(idx) - 1L)
  expect_equal(mom$value[1], round(100 * (idx$value[2] / idx$value[1] - 1), 1))
})

test_that("hicp_monthly_rate works per country and leaves gaps as NA", {
  idx <- data.frame(
    date = as.Date(c("2025-01-01", "2025-02-01", "2025-04-01",
                     "2025-01-01", "2025-02-01")),
    country = c("A", "A", "A", "B", "B"),
    value = c(100, 101, 102, 200, 198),
    stringsAsFactors = FALSE
  )
  out <- hicp_monthly_rate(idx)
  expect_equal(out$country, c("A", "A", "B"))
  expect_equal(out$value, c(1.0, NA, -1.0))
})
