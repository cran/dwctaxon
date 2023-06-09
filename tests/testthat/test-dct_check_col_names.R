test_that("properly formatted data passes", {
  expect_no_error(
    check_col_names_p(data.frame(taxonID = "a", namePublishedInID = "b"))
  )
})

test_that("check for 'all columns must have valid names' works", {
  expect_error(
    check_col_names_p(data.frame(a = 1)),
    paste0(
      "check_col_names failed.*",
      "Invalid column name\\(s\\) detected.*",
      "Bad column names\\: a"
    )
  )
  expect_equal(
    check_col_names_p(data.frame(a = 1), on_fail = "summary", quiet = TRUE),
    tibble::tibble(
      error = "Invalid column names detected: a",
      check = "check_col_names"
    )
  )
})

test_that("specifying extra columns works", {
  expect_error(
    check_col_names_p(data.frame(a = 1, b = 1, taxonID = 3))
  )
  expect_no_error(
    check_col_names_p(
      data.frame(a = 1, b = 1, taxonID = 3),
      extra_cols = c("a", "b")
    )
  )
})
