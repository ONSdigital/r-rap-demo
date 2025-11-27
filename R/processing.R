# processing.R: Data processing functions for RAP pipeline
library(dplyr)
library(ggplot2)

#' Calculate disease prevalence rates per month
#' 
#' @description Calculate disease prevalence rates per month from 
#' cleaned health data
#'
#' @param df cleaned health data data.frame
#' 
#' @returns data.frame with prevalence rates per month and diagnosis
#' 
#' @export
calculate_disease_prevalence <- function(df){
  prevalence = df %>%
    group_by(month, diagnosis) %>%
    summarise(case_count = n(), .groups = "drop")

  total_per_month = df %>%
    group_by(month) %>%
    summarise(total = n(), .groups = "drop")

  prevalence = prevalence %>%
    left_join(total_per_month, by = "month")

  prevalence$prevalence_rate = prevalence$case_count / prevalence$total
  return(prevalence)
}

