# Main pipeline script for RAP demo
library(yaml)
source("R/R_rap_demo/cleaning.R")
source("R/R_rap_demo/io.R")
source("R/R_rap_demo/processing.R")
source("R/R_rap_demo/report.R")
source("R/R_rap_demo/utils.R")

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

