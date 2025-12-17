<!--
README.md for a typical RAP (Reproducible Analytical Pipeline) project

This file provides a clear overview and guide for your analytical pipeline repository.

In a RAP project, the README is essential for:
- Describing the aims and scope of the analysis
- Documenting setup steps and usage instructions
- Outlining folder structure and key files
- Explaining how to run the pipeline, tests, and automation tools
- Sharing best practices for reproducibility, automation, and transparency

A well-written README makes your RAP project accessible and easy for others to use, review, or contribute to. Update it as your project evolves.
-->
# Work in Progress – RAP demonstration repository for R

Welcome to the RAP (Reproducible Analytical Pipeline) demonstration repository! This repository is designed for beginner to intermediate coders to practice RAP principles, experiment with code, and learn best practices for Reproducible Analytical Pipelines in R.

**This repository is still in development**

## Getting Started

1. **Fork the repository:**
   - Forking means creating your own copy of this project on GitHub. Go to the [GitHub page](https://github.com/ONSdigital/python_rap_demo) for this repository (if you are not there already) and click the "Fork" button in the top right.
   - After forking, go to your new repository (it will be at `https://github.com/<your-username>/r-rap-demo`).
   - Click the green "Code" button and copy the URL shown under "Clone".
   - Open a terminal (Command Prompt) and run:
     ```cmd
     git clone https://github.com/<your-username>/r-rap-demo.git
     cd r-rap-demo
     ```
   - **Tip:** To check you are in the project root, run `dir` and make sure you see files like `README.md` and folders like `R` and `data`.

> **Note:** The GitHub repository is named `r-rap-demo`, but the R package name (as used in R and in the `DESCRIPTION` file) is `r.rap.demo`. This difference is intentional and follows best practices for naming in each context.

2. **Set up your environment:**
   - Open RStudio (recommended) or your preferred R environment.
   - Install package dependencies:
     ```R
     install.packages("devtools")
     devtools::install_deps()
     ```

## Repository Structure

- `R/` — Main package code and modules
- `data/` — Example health data for analysis
- `config/` — Configuration files (YAML)
- `tests/` — Unit tests for pipeline modules
- `exercises/` — **Practice exercises** ([see below](#practice-with-exercises))
- `man/` — Documentation
- `DESCRIPTION`, `NAMESPACE`, `R_rap_demo.Rproj` — R package metadata and project files

## Using the repository

### Build and load the package

To build and load the package in R, run:

```R
devtools::load_all()
```

This will:
- Load configuration from package files
- Read input data from the `data/` folder
- Clean and process the data
- Write outputs and generate reports in `output/`
- You should see a message confirming the report was generated.

Explore the existing code and add your own functions to the `R/` folder.

### Practice with exercises

If exercises are provided, they will be in a dedicated folder (e.g., `exercises/`). These are for practice and experimentation, not part of the main package.

- Each exercise has its own subfolder and README with instructions.
- Work through exercises to learn how to:
  - Add new modules
  - Use configuration files
  - Write unit tests
  - Set up and customise pre-commit hooks
  - Apply RAP principles in real code

### Understanding the purpose of each file and folder

Information about different files and folders can be found throughout the pipeline:
  - Files: Contain information on their purpose in the file itself, except `.secrets.baseline`. `.secrets.baseline` information can be found in the `docs` folder.
  - Folders: Contain a markdown (.md) file to explain what the folder is for and typical files it contains.
  - Scripts: Fully documented with comments and Roxygen docstrings.

### Create and run tests

Test your functions by adding tests to the `tests/` folder.

Run tests with:
  ```R
  devtools::test()
  ```

## Contributing

This repo is for learning and experimentation. If you want to contribute improvements, please read `CONTRIBUTING.md`.

## AI declaration

AI has been used in the production of this content.

---

Happy RAP coding!