#Unit tests for cleaning module in the RAP pipeline.

library(testthat)

source("D:/repos/R_rap_demo/R/R_rap_demo/cleaning.R")

test_that("test_clean_health_data", {
  #Test the clean_health_data function to ensure it:
  #- Fills missing smoker values with 'No'
  #- Converts 'gender' to uppercase
  #- Drops rows with missing 'diagnosis'

  # Create a sample data frame
  df <- data.frame(
    diagnosis = c("A", "B", ),
    smoker = c(NA, "Yes", "No"),
    gender = c("m", "f", "m"),
    stringsAsFactors = FALSE
  )

  cleaned <- clean_health_data(df)

  # Check that missing 'smoker' is filled with 'No'
  expect_equal(cleaned$smoker[1], "No")

  # Check that 'gender' is uppercase
  expect_true(all(grepl("^[A-Z]+$", cleaned$gender)))

  # Check that rows with missing 'diagnosis' are dropped
  expect_true(all(!is.na(cleaned$diagnosis)))
})


