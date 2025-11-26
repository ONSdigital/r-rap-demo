# report.R: Markdown report generation for RAP pipeline

#' Format the markdown section for a single month
#' 
#' @description Format the markdown section for a single month
#'
#' @param month Month string
#' @param month_df data.frame filtered for the month
#' 
#' @return Markdown string for the month section
format_month_section <- function(month, month_df) {
  
  lines <- sprintf("## Month: %s\n", month)
  
  for (i in 1:nrow(month_df)){
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

#' Generate a markdown report of disease prevalence rates per month.
#'
#' @param prevalence_df data.frame with prevalence rates.
#' @param output_path Path to output markdown file.
generate_markdown_report <- function(prevalence_df, output_path) {
  f <- file(output_path, "w")
  writeLines("# Disease Prevalence Report\n\n", con = f)
  for (month in unique(prevalence_df$month)) {
    month_df <- prevalence_df[prevalence_df$month == month, ]
    writeLines(format_month_section(month, month_df), con = f)
  }
  close(f)
}
