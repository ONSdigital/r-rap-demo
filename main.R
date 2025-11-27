# Main pipeline script for RAP demo
library(yaml)
source("R/cleaning.R")
source("R/io.R")
source("R/processing.R")
source("R/report.R")
source("R/utils.R")

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
  
  # Processing
  prevalence_df = calculate_disease_prevalence(df_clean)
  
  # Reporting
  generate_markdown_report(prevalence_df, report_path)
  cat("Report generated: ", report_path)
}
main()
