#io.R: Data input/output functions for RAP pipeline

#' Read health data CSV into a DataFrame.
#'
#' @param filepath (str): Path to the CSV file.
#' @returns Data frame containing the health data.
read_health_data <- function(filepath) {
  read.csv(filepath, stringsAsFactors = FALSE)
}

#' Write DataFrame to CSV.
#'
#' @param df (DataFrame): DataFrame to write.
#' @param filepath (str): Path to the output CSV file.
write_dataframe <- function(df, filepath) {
  write.csv(df, filepath, row.names = FALSE)
}
