# run_linters.R: This script runs lintr on the R scripts in the RAP demo project,
# generates GitHub Actions annotations for any warnings found, and creates a
# markdown summary of the warnings for review.
# 
# It is included in the r-checks.yml GitHub Actions workflow to provide
# immediate feedback on code quality issues.


# run_linters.R
# Annotate and summarize lintr warnings for GitHub Actions

#' Summarize lintr warnings and print GitHub Actions annotations
#'
#' This function takes a list of lints and prints GitHub Actions warning annotations for each lint.
#' It also returns a character vector summarizing the warnings for markdown reporting.
#'
#' @param lints A list of lint objects returned by lintr::lint_dir or lintr::lint
#' @return A character vector of markdown-formatted warning summaries
summarize_lintr_warnings <- function(lints) {
  warnings <- c()
  # Loop through each lint object
  for (lint in lints) {
    # Check if the object is a valid lint
    if (!is.null(lint) && inherits(lint, "lint")) {
      # Get relative file path for annotation
      rel_path <- sub(".*/(R/.*|main\\.R)$", "\\1", lint$filename)
      tryCatch(
        {
          # Print GitHub Actions warning annotation
          writeLines(sprintf(
            "::warning file=%s,line=%d,col=%d::%s",
            rel_path,
            as.integer(lint$line_number),
            as.integer(lint$column_number),
            as.character(lint$message)
          ))
          # Add formatted warning to summary
          warnings <- c(warnings, sprintf("- **%s** (line %d, col %d): %s", rel_path, lint$line_number, lint$column_number, lint$message))
          flush.console()
        },
        error = function(e) {
          # Print debug info if annotation fails
          cat("DEBUG: sprintf error:", conditionMessage(e), "\n")
          str(lint)
        }
      )
    }
  }
  return(warnings)
}

#' Write a markdown summary of lintr warnings to a file
#'
#' This function takes a character vector of warning summaries and writes a grouped markdown report to 'lintr_warnings.txt'.
#' Warnings are grouped by file and presented in collapsible sections for easy review in GitHub Actions.
#'
#' @param warnings A character vector of markdown-formatted warning summaries
#' @return NULL. Writes output to 'lintr_warnings.txt'.
write_lintr_summary <- function(warnings) {
  if (length(warnings) > 0) {
    # Group warnings by file for collapsible markdown
    warning_files <- sapply(warnings, function(w) sub("^- \\*\\*(.+?)\\*\\*.*$", "\\1", w))
    warning_groups <- split(warnings, warning_files)
    # Start markdown blocks for summary
    md_blocks <- c(
      "## :warning: Lintr Warnings Found",
      "",
      "Issues were detected by [lintr](https://github.com/r-lib/lintr). Please review the below warnings and address them as needed:",
      ""
    )
    # Add collapsible sections for each file
    for (file in names(warning_groups)) {
      md_blocks <- c(
        md_blocks,
        sprintf("<details>\n<summary>%s</summary>\n", file),
        paste(warning_groups[[file]], collapse = "\n"),
        "\n</details>\n"
      )
    }
    # Write markdown summary to file
    writeLines(md_blocks, "lintr_warnings.txt")
  } else {
    # No warnings found
    cat("No lintr warnings found.\n")
    writeLines(c(""), "lintr_warnings.txt")
  }
  flush.console()
}

# Run lintr on all R scripts and main.R
lints <- c(lintr::lint_dir("R"), lintr::lint("main.R"))
cat("DEBUG: lints length =", length(lints), "\n")
# Filter only valid lint objects
lints <- Filter(function(x) inherits(x, "lint"), lints)
cat("Lintr found", length(lints), "warnings.\n")
# Summarize and write warnings
warnings <- summarize_lintr_warnings(lints)
write_lintr_summary(warnings)
flush.console()
