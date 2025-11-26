#io.R: Data input/output functions for RAP pipeline

#' Read health data CSV into a data.frame
#' 
#' @description Read a CSV file containing health data into a data.frame
#'
#' @param filepath Path to the CSV file
#' 
#' @returns Data frame containing the health data
#' 
#' @export
read_health_data <- function(filepath) {
  read.csv(filepath, stringsAsFactors = FALSE)
}

#' Write data.frame to CSV
#' 
#' @description Write a data.frame to a CSV file
#'
#' @param df data.frame to write
#' 
#' @param filepath Path to the output CSV file
#' 
#' @export
write_dataframe <- function(df, filepath) {
  write.csv(df, filepath, row.names = FALSE)
}
