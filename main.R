# main.R: Entry point for the RAP (Reproducible Analytical Pipeline) demo project.
#
# This script coordinates the full analysis pipeline, including:
# - Loading configuration settings
# - Reading input health data
# - Cleaning and transforming the data
# - Calculating disease prevalence
# - Generating a markdown report
# 
# Run this file to execute the complete RAP workflow using modular functions from
# the R/ folder.

# Main pipeline script for RAP demo
library(yaml)
devtools::load_all()

main <- function() {
  # Run the RAP pipeline: I/O, cleaning, processing, reporting

  # Construct the path to the YAML configuration file
  config_path <- file.path("config/user_config.yaml")

  # Load the YAML configuration file
  config <- yaml::read_yaml(config_path)

  input_path = config$input_path
  cleaned_path = config$cleaned_path
  report_path = config$report_path

  # I/O Read data
  df <- read_health_data(input_path)

  # Cleaning
  df_clean <- clean_health_data(df)
  df_clean <- add_bmi_column(df_clean)
  write_dataframe(df_clean, cleaned_path)
  cat("Cleaned health data generated: ", cleaned_path, "\n\n")

  # Processing
  prevalence_df = calculate_disease_prevalence(df_clean)

  # Reporting
  generate_markdown_report(prevalence_df, report_path)
  cat("Report generated: ", report_path, "\n\n")
}
main()
