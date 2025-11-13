#io.R: Data input/output functions for RAP pipeline

read_health_data <- function(filepath) {
  #'Read health data CSV into a DataFrame.
  #' @param filepath (str): Path to the CSV file.
  #' @returns Data frame containing the health data.
  
  read.csv(filepath, stringsAsFactors = FALSE)
}

write_dataframe <- function(df, filepath) {
  #'Write DataFrame to CSV.
  #' @param df (DataFrame): DataFrame to write.
  #' @param filepath (str): Path to the output CSV file.
  
  write.csv(df, filepath, row.names = FALSE)
}
