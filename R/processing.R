# processing.R: Data processing functions for RAP pipeline
library(dplyr)

calculate_disease_prevalence <- function(df) {
  # Calculate disease prevalence rates per month.

  # Args:
  #     df (DataFrame): Cleaned health data DataFrame.

  # Returns:
  #     DataFrame: DataFrame with prevalence rates per month and diagnosis.
  prevalence <- df %>%
    group_by(month, diagnosis) %>%
    summarise(case_count = n(), .groups = "drop")

  total_per_month <- df %>%
    group_by(month) %>%
    summarise(total = n(), .groups = "drop")

  prevalence <- prevalence %>%
    left_join(total_per_month, by = "month")

  prevalence$prevalence_rate <- prevalence$case_count / prevalence$total

  return(prevalence)
}
