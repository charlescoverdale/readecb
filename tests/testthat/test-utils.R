test_that("parse_ecb_date handles daily dates", {
  x <- c("2024-01-15", "2024-06-30")
  result <- readecb:::parse_ecb_date(x)
  expect_s3_class(result, "Date")
  expect_equal(result, as.Date(c("2024-01-15", "2024-06-30")))
})

test_that("parse_ecb_date handles monthly dates", {
  x <- c("2024-01", "2024-12")
  result <- readecb:::parse_ecb_date(x)
  expect_s3_class(result, "Date")
  expect_equal(result, as.Date(c("2024-01-01", "2024-12-01")))
})

test_that("parse_ecb_date handles quarterly dates", {
  x <- c("2024-Q1", "2024-Q2", "2024-Q3", "2024-Q4")
  result <- readecb:::parse_ecb_date(x)
  expect_equal(result, as.Date(c("2024-01-01", "2024-04-01",
                                  "2024-07-01", "2024-10-01")))
})

test_that("parse_ecb_date handles annual dates", {
  x <- c("2020", "2024")
  result <- readecb:::parse_ecb_date(x)
  expect_equal(result, as.Date(c("2020-01-01", "2024-01-01")))
})

test_that("parse_ecb_date returns NA for unrecognised formats", {
  x <- c("not-a-date", "2024-W01")
  result <- readecb:::parse_ecb_date(x)
  expect_true(all(is.na(result)))
})
