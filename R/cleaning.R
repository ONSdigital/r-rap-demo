# cleaning.R: Data cleaning functions for RAP pipeline

#' Clean health data
#'
#' @description Clean health data by handling missing values and standardising
#' columns
#'
#' @param df raw health data data.frame
#'
#' @returns df_clean cleaned health data data.frame
#'
#' @export
clean_health_data <- function(df) {
  # Drop rows with missing diagnosis
  df$diagnosis[df$diagnosis == ""] <- NA
  df$diagnosis[df$diagnosis == "NA"] <- NA
  df_clean <- df[
    complete.cases(df[, c("diagnosis", "height_cm", "weight_kg")]),
  ]

  # Fill missing smoker values with 'No'
  df_clean$smoker[is.na(df_clean$smoker)] <- "No"

  # Ensure sex is uppercase
  df_clean$sex <- toupper(df_clean$sex)

  return(df_clean)
}
