# run_linters.R
# Annotate and summarize lintr warnings for GitHub Actions

summarize_lintr_warnings <- function(lints) {
  warnings <- c()
  for (lint in lints) {
    if (!is.null(lint) && inherits(lint, "lint")) {
      rel_path <- sub(".*/(R/.*|main\\.R)$", "\\1", lint$filename)
      tryCatch(
        {
          writeLines(sprintf(
            "::warning file=%s,line=%d,col=%d::%s",
            rel_path,
            as.integer(lint$line_number),
            as.integer(lint$column_number),
            as.character(lint$message)
          ))
          warnings <- c(warnings, sprintf("- **%s** (line %d, col %d): %s", rel_path, lint$line_number, lint$column_number, lint$message))
          flush.console()
        },
        error = function(e) {
          cat("DEBUG: sprintf error:", conditionMessage(e), "\n")
          str(lint)
        }
      )
    }
  }
  return(warnings)
}

write_lintr_summary <- function(warnings) {
  if (length(warnings) > 0) {
    # Group warnings by file for collapsible markdown
    warning_files <- sapply(warnings, function(w) sub("^- \\*\\*(.+?)\\*\\*.*$", "\\1", w))
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
        sprintf("<details>\n<summary>%s</summary>\n", file),
        paste(warning_groups[[file]], collapse = "\n"),
        "\n</details>\n"
      )
    }
    writeLines(md_blocks, "lintr_warnings.txt")
  } else {
    cat("No lintr warnings found.\n")
    writeLines(c(""), "lintr_warnings.txt")
  }
  flush.console()
}


lints <- c(lintr::lint_dir("R"), lintr::lint("main.R"))
cat("DEBUG: lints length =", length(lints), "\n")
lints <- Filter(function(x) inherits(x, "lint"), lints)
cat("Lintr found", length(lints), "warnings.\n")
warnings <- summarize_lintr_warnings(lints)
write_lintr_summary(warnings)
flush.console()
