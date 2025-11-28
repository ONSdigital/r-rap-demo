# Unit tests for cleaning module in the RAP pipeline.

library(testthat)

source("R/cleaning.R")

testthat::test_that("test_clean_health_data", {
  # Test the clean_health_data function to ensure it:
  #- Fills missing smoker values with 'No'
  #- Converts 'gender' to uppercase
  #- Drops rows with missing 'diagnosis'

  # Create a sample data frame
  df <- data.frame(
    height_cm = c(NA, 170, 160),
    weight_kg = c(60, 50, 80),
    diagnosis = c("A", "B", NA),
    smoker = c("Yes", NA, "No"),
    gender = c("m", "f", "m"),
    stringsAsFactors = FALSE
  )

  cleaned <- clean_health_data(df)

  # Check that missing 'smoker' is filled with 'No'
  testthat::expect_equal(cleaned$smoker[1], "No")

  # Check that 'gender' is uppercase
  testthat::expect_true(all(grepl("^[A-Z]+$", cleaned$gender)))

  # Check that rows with missing 'diagnosis' are dropped
  testthat::expect_true(all(!is.na(cleaned$diagnosis)))
})
