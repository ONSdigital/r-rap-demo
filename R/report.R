# report.R: Markdown report generation for RAP pipeline

format_month_section <- function(month, month_df) {
  # Format the markdown section for a single month.

  # Args:
  #     month (str): Month string.
  #     month_df (DataFrame): DataFrame filtered for the month.

  # Returns:
  #     str: Markdown string for the month section.
  lines <- sprintf("## Month: %s\n", month)

  for (i in 1:nrow(month_df)) {
    row <- month_df[i, ]
    line <- sprintf(
      "- %s: %.2f%% (%d cases)\n",
      row$diagnosis,
      row$prevalence_rate * 100,
      as.integer(row$case_count)
    )
    lines <- c(lines, line)
  }

  return(paste(lines, collapse = ""))
}

generate_markdown_report <- function(prevalence_df, output_path) {
  # Generate a markdown report of disease prevalence rates per month.

  # Args:
  #     prevalence_df (DataFrame): DataFrame with prevalence rates.
  #     output_path (str): Path to output markdown file.
  f <- file(output_path, "w")
  writeLines("# Disease Prevalence Report\n\n", con = f)
  for (month in unique(prevalence_df$month)) {
    month_df <- prevalence_df[prevalence_df$month == month, ]
    writeLines(format_month_section(month, month_df), con = f)
  }
  close(f)
}
