#cleaning.R: Data cleaning functions for RAP pipeline

clean_health_data <- function(df) {
  
  #Clean health data by handling missing values and standardizing columns.

  #Args:
  #    df (DataFrame): Raw health data DataFrame.
  
  #Returns:
  #    df_clean (DataFrame): Cleaned health data DataFrame.
  
  # Drop rows with missing diagnosis
  df_clean <- df[!is.na(df$diagnosis),]
  
  # Fill missing smoker values with 'No'
  df_clean$smoker[is.na(df_clean$smoker)] <- "No"
  
  # Ensure gender is uppercase
  df_clean$gender <- toupper(df_clean$gender)
  
  return(df_clean)
}
