# run_linters.R
lints <- c(lintr::lint_dir('R'), lintr::lint('main.R'))
cat('DEBUG: lints length =', length(lints), '\n')
lints <- Filter(function(x) inherits(x, 'lint'), lints)
cat('Lintr found', length(lints), 'warnings.\n')
if (length(lints) > 0) {
  for (lint in lints) {
    if (!is.null(lint) && inherits(lint, 'lint')) {
      cat('DEBUG: lint is a lint object\n')
      cat('DEBUG: lint$filename =', paste(lint$filename, collapse = " "), '\n')
      cat('DEBUG: lint$line_number =', paste(lint$line_number, collapse = " "), '\n')
      cat('DEBUG: lint$column_number =', paste(lint$column_number, collapse = " "), '\n')
      cat('DEBUG: lint$message =', paste(lint$message, collapse = " "), '\n')
      tryCatch({
        writeLines(sprintf('::warning file=%s,line=%d,col=%d::%s',
          as.character(basename(lint$filename)),
          as.integer(lint$line_number),
          as.integer(lint$column_number),
          as.character(lint$message)
        ))
        flush.console()
      }, error = function(e) {
        cat('DEBUG: sprintf error:', conditionMessage(e), '\n')
        str(lint)
      })
    } else {
      cat('DEBUG: Skipping non-lint object\n')
      str(lint)
    }
  }
} else {
  cat('No lintr warnings found.\n')
}
flush.console()
