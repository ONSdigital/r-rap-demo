# What is the `R` folder?

The `R` folder is where the main source code for your RAP (Reproducible Analytical Pipeline) or R package project is stored. This folder contains all the R scripts and functions that define the core functionality of your analysis pipeline or package.

The functions defined in the `R` folder feed into the overall workflow of your RAP in `main.R` or `pipeline.R`, or are used as part of your R package.

## Why is it important?
- Central location for all R code, making it easy to find and manage
- Organises functions and scripts that perform data cleaning, processing, analysis, and reporting
- Supports modularity and reusability of code across different parts of the pipeline
- Facilitates testing and maintenance by keeping code separate from data and configuration files

## Common types of files in `R`
- **Function scripts:** R scripts that define functions for specific tasks (e.g., data cleaning, analysis, visualization)
- **Module scripts:** Scripts that group related functions into modules for specific parts of the pipeline
- **Utility scripts:** Helper functions that support common tasks used across multiple modules

## Example Structures
R pipelines are often structured in one of the following ways:
- **Flat structure:** All functions are stored as separate R scripts in the `R` folder.
  ```
  R/
  ├── clean_data.R
  ├── analyze_data.R
  ├── generate_report.R
  └── utils.R
  main.R
  ```
- **Modular structure:** Functions are grouped into subfolders based on their purpose or module.
  ```
    R/
    ├── data_cleaning/
    │   ├── clean_data.R
    │   └── validate_data.R
    ├── analysis/
    │   ├── analyze_data.R
    │   └── summarize_results.R
    └── reporting/
        ├── generate_report.R
        └── plot_results.R
    main.R
    ```

Both structures follow the standard R package conventions, making it easy to develop, share, and maintain your code.

## How to construct an R package structure using `usethis` and `devtools`
You can use the `usethis` and `devtools` packages to help set up and manage your R package structure. Here are some common commands:

```R
# Create a new R package
usethis::create_package("path/to/your/package")
# Add a new R script for a function
usethis::use_r("function_name")
# Document your package
devtools::document() # Ensure you have added Roxygen comments in your functions
# Install and load your package
devtools::install()
devtools::load_all()
```

## Summary
The `R` folder is the core of your RAP and is where the main analysis code is stored. By organising your R scripts and functions in this folder, you can create a codebase that promotes reusability, is scalable and clear for users and developers.
