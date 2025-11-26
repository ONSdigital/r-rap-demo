# utils.R: Utility functions for RAP pipeline
library(yaml)
library(dplyr)

#' Calculate BMI
#' 
#' @description Calculate BMI from height (cm) and weight (kg)
#'
#' @param height_cm Height in centimeters
#' @param weight_kg Weight in kilograms
#' 
#' @return float: Calculated BMI
calculate_bmi <- function(height_cm, weight_kg){
  height_m = height_cm / 100
  return(weight_kg / (height_m^2))
}

#' Add BMI column
#' 
#' @description Add a BMI column to the data.frame
#'
#' @param df Input data.frame with 'height_cm' and 'weight_kg' columns
#' 
#' @return data.frame with added 'bmi' column
add_bmi_column <- function(df, height_cm, weight_kg) {
  df <- df %>%
        rowwise() %>%
        mutate(bmi = calculate_bmi(height_cm, weight_kg)) %>%
        ungroup()
        return(df)
}

#' Load pipeline configuration files
#' 
#' @description Load pipeline configuration from a YAML file
#'
#' @param config_path Path to the YAML config file
#' 
#' @return dict Configuration dictionary
load_config <- function(config_path) {
  return (yaml::yaml.load_file(config_path))
}
