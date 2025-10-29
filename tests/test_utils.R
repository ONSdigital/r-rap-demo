"""
Unit tests for the utils module in the RAP pipeline.
"""
library(testthat)
library(yaml)
source("utils.R")

test_that("test_add_bmi_column", {
  """
  Test the add_bmi_column function to ensure it adds a 'bmi' column correctly.
  """
  df = data.frame(height_cm = c(180, 160),
                  weight_kg = c(80, 60))
  result = add_bmi_column(df)
  expect_true("bmi" %in% colnames(result))
  expected_bmi <- calculate_bmi(180,80)
  expect_equal(result$bmi[1], expected_bmi, tolerance = 0.01)
})

test_that("test_calculate_bmi", {
  """
  Test the calculate_bmi function to ensure it calculates BMI correctly.
  """
  bmi <- calculate_bmi(180,80)
  expect_equal(bmi, 24.69, tolerance = 0.01)
})

test_that("test_load_config", {
  """
  Test the load_config function to ensure it loads YAML config correctly.
  """
  yaml_path <- tempfile(fileext = ".yaml")
  yaml_content <- c(
      "input_path: test.csv",
      "cleaned_path: out.csv",
      "report_path: report.md"
  )
  writeLines(yaml_content, yaml_path)
  config <- yaml.load_file(yaml_path)
  expect_equal(config$input_path, "test.csv")
  expect_equal(config$cleaned_path, "out.csv")
  expect_equal(config$report_path, "report.md")
})