# utils.R: Utility functions for RAP pipeline
library(yaml)
library(dplyr)

calculate_bmi <- function(height_cm, weight_kg){
  #' Calculate BMI from height (cm) and weight (kg).
  #' @param height_cm Height in centimeters.
  #' @param weight_kg Weight in kilograms.
  #' @return float: Calculated BMI.
  height_m = height_cm / 100
  return(weight_kg / (height_m^2))
}

add_bmi_column <- function(df, height_cm, weight_kg) {
  #' Add a BMI column to the DataFrame.
  #' @param df Input DataFrame with 'height_cm' and 'weight_kg' columns.
  #' @return DataFrame with added 'bmi' column.
  df <- df %>%
        rowwise() %>%
        mutate(bmi = calculate_bmi(height_cm, weight_kg)) %>%
        ungroup()
        return(df)
}

load_config <- function(config_path) {
  #' Load pipeline configuration from a YAML file.
  #' @param config_path Path to the YAML config file.
  #' @return dict Configuration dictionary.
  return (yaml:yaml.load_file(config_path))
}
