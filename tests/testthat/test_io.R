#Unit tests for the I/O module in the RAP pipeline.

library(testthat)

source("R/io.R") 
test_that("test_read_health_data", {
  #Test reading a CSV file into a DataFrame.
  # Create a temporary CSV file
  source("R/io.R") 
  temp_file <- tempfile(fileext = ".csv")
  df <- data.frame(a = c(1, 2), b = c(3, 4))
  write.csv(df, temp_file, row.names = FALSE)
  result <- read_health_data(temp_file)
  # Check that the DataFrame matches the original
  expect_equal(result, df)
})

test_that("write_dataframe writes CSV correctly", {
  #Test writing a DataFrame to a CSV file.
  
  df <- data.frame(a = c(1, 2), b = c(3, 4))
  temp_file <- tempfile(fileext = ".csv")
  write_dataframe(df, temp_file)
  result <- read.csv(temp_file, stringsAsFactors = FALSE)
  # Check that the written file matches the original DataFrame
  expect_equal(result, df)
})
