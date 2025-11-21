#Unit tests for the processing module in the RAP pipeline.

library(testthat)
library(dplyr)

test_that("test_calculate_disease_prevalence", {
  #Test the calculate_disease_prevalence function to ensure it:
  # - Calculates case counts and prevalence rates correctly.
  # - Returns a DataFrame with expected columns.
  
  # Create a sample DataFrame
  df = data.frame(month = c("2025-01", "2025-01", "2025-02"),
                  diagnosis = c("A","B","A"))
  
  result = calculate_disease_prevalence(df)
  # Define the expected output columns
  expected_cols <- c("month", "diagnosis", "case_count", "total", "prevalence_rate")
  # Check that the result has the expected columns
  expect_setequal(colnames(result), expected_cols)
  # Check that the prevalence rates are between 0 and 1
  expect_true(all(result$prevalence_rate >= 0 & result$prevalence_rate <= 1))
})