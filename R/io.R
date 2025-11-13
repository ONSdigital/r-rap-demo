# io.R: Data input/output functions for RAP pipeline

read_health_data <- function(filepath) {
  # Read health data CSV into a DataFrame.

  # Args:
  #    filepath (str): Path to the CSV file.

  # Returns:
  #    DataFrame: Data frame containing the health data.

  read.csv(filepath, stringsAsFactors = FALSE)
}

write_dataframe <- function(df, filepath) {
  # Write DataFrame to CSV.

  # Args:
  #    df (DataFrame): DataFrame to write.
  #    filepath (str): Path to the output CSV file.

  write.csv(df, filepath, row.names = FALSE)
}
