"""
Unit tests for the report module in the RAP pipeline.
"""
library(testthat)
library(readr)
source("report.R")

test_that("test_format_month_section", {
  # Define the variable month used in format_month_section
  month <- "January"
  # Create the dataframe month_df used in format_month_selection
  month_df <- data.frame(
    diagnosis = c("A","B"),
    case_count = c(10, 20),
    total = c(20, 50))
  # Calculate the prevalence rate
  month_df$prevalence_rate <- month_df$case_count / month_df$total
  # Define the expected output of format_month_section
  expected_output <- paste(
    "## Month: January",
    "- A: 50.00% (10 cases)",
    "- B: 40.00% (20 cases)",
    sep = "\n"
  )
  result = format_month_section(month, month_df)
  # Check that the output from format_month_selection matches the expected output
  expect_setequal(trimws(result), trimws(expected_output))
})


test_that("test_generate_markdown_report", {
  """
  Test the generate_markdown_report function to ensure it:
  - Creates a markdown file
  - Includes expected content
  """
  out_path <- tempfile(fileext = ".md")
  # Create a saample DataFrame for the report
  test_df <- data.frame(
    month = "2025-01",
    diagnosis = "A",
    case_count = 10,
    total = 20
  )
  test_df$prevalence_rate <- test_df$case_count / test_df$total
  
  format_month_section <- function(month, df) {
    paste0("## ", month, "\n", paste(capture.output(print(df)), collapse = "\n"))
  }
  
  generate_markdown_report(test_df, out_path)
  # Check that the file exists and contains expected text
  expect_true(file.exists(out_path))
  content <- read_file(out_path)
  expect_true(grepl("Disease Prevalence Report", content))
})
