test_that("clear_cache runs without error", {
  expect_no_error(clear_cache())
})

test_that("cached files expire after the cache lifetime", {
  path <- tempfile(fileext = ".csv")
  on.exit(unlink(path), add = TRUE)
  writeLines("x", path)

  op <- options(readecb.cache_ttl = 24)
  on.exit(options(op), add = TRUE)
  expect_true(ecb_cache_fresh(path))
  Sys.setFileTime(path, Sys.time() - 25 * 3600)
  expect_false(ecb_cache_fresh(path))

  options(readecb.cache_ttl = 48)
  expect_true(ecb_cache_fresh(path))
  expect_false(ecb_cache_fresh(tempfile()))
})

test_that("an invalid cache lifetime is an error", {
  op <- options(readecb.cache_ttl = -1)
  on.exit(options(op), add = TRUE)
  expect_error(ecb_cache_ttl(), "non-negative")
})
