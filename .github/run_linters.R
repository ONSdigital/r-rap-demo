# run_linters.R
lints <- c(lintr::lint_dir("R"), lintr::lint("main.R"))
cat("DEBUG: lints length =", length(lints), "\n")
lints <- Filter(function(x) inherits(x, "lint"), lints)
cat("Lintr found", length(lints), "warnings.\n")
warnings <- c()
if (length(lints) > 0) {
  for (lint in lints) {
    if (!is.null(lint) && inherits(lint, "lint")) {
      # Extract relative path for annotation and summary
      rel_path <- sub(".*/(R/.*|main\\.R)$", "\\1", lint$filename)
      cat("DEBUG: lint is a lint object\n")
      cat("DEBUG: rel_path =", rel_path, "\n")
      cat("DEBUG: lint$line_number =", paste(lint$line_number, collapse = " "), "\n")
      cat("DEBUG: lint$column_number =", paste(lint$column_number, collapse = " "), "\n")
      cat("DEBUG: lint$message =", paste(lint$message, collapse = " "), "\n")
      tryCatch(
        {
          writeLines(sprintf(
            "::warning file=%s,line=%d,col=%d::%s",
            rel_path,
            as.integer(lint$line_number),
            as.integer(lint$column_number),
            as.character(lint$message)
          ))
          # Improved bullet-point formatting for PR comment
          warnings <- c(warnings, sprintf("- **%s** (line %d, col %d): %s", rel_path, lint$line_number, lint$column_number, lint$message))
          flush.console()
        },
        error = function(e) {
          cat("DEBUG: sprintf error:", conditionMessage(e), "\n")
          str(lint)
        }
      )
    } else {
      cat("DEBUG: Skipping non-lint object\n")
      str(lint)
    }
  }
  # Group warnings by file for collapsible markdown
  if (length(warnings) > 0) {
    # Extract file names for grouping
    warning_files <- sapply(lints, function(lint) sub(".*/(R/.*|main\\.R)$", "\\1", lint$filename))
    warning_groups <- split(warnings, warning_files)

    md_blocks <- c(
      "## :warning: Lintr Warnings Found",
      "",
      "Issues were detected by [lintr](https://github.com/r-lib/lintr). Please review the below warnings and address them as needed:",
      ""
    )

    for (file in names(warning_groups)) {
      md_blocks <- c(
        md_blocks,
        sprintf("<details>\n<summary>%s</summary>", file),
        paste(warning_groups[[file]], collapse = "\n"),
        "</details>\n"
      )
    }

    writeLines(md_blocks, "lintr_warnings.txt")
  } else {
    cat("No lintr warnings found.\n")
  }
  flush.console()
} else {
  cat("No lintr warnings found.\n")
}
flush.console()
