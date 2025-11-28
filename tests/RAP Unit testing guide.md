# RAP Unit testing guide

## What are unit tests?
Unit tests are small, automated tests that check individual pieces of code (functions, classes, modules) to ensure they work as expected.
For examples of written tests, look through the scripts in the `tests` folder of the pipeline. More information on unit tests can be found
in the QA for RAP learning resource [add link].

## Why unit tests matter in RAP
- **Reproducibility:** Tests ensure code produces the same results every time.
- **Automation:** Tests run automatically, saving time and reducing manual checking.
- **Transparency:** Tests document what your code is supposed to do, making it easier to review and maintain.
- **Quality:** Tests catch bugs and edge cases before code is used in production or shared with others.

## How unit tests work in RAP
- Each module (e.g., io, cleaning, processing) has its own test file in the `tests/` folder.
- Each function has one or more tests to ensure that it produces an expected output for different scenarios.
- If any test fails, the developer must review the error message, fix the code, and re-run the tests.

## How to generate a testthat infrastructure using `usethis`
To set up a `testthat` infrastructure in your R package or RAP project, follow these steps:
1. Install the `usethis` package if you haven't already:
   ```R
   install.packages("usethis")
   ```
2. In the console, run the following command to set up the `testthat` infrastructure:
   ```R
   usethis::use_testthat()
   ```

Alternatively you can create the folders and files manually by following the steps below:
1. Install the `testthat` package if you haven't already:
   ```R
   install.packages("testthat")
   ```
2. Create a `tests/` folder in the root of your project if it doesn't exist.
3. Inside the `tests/` folder, create a subfolder named `testthat/`.
4. Create a file named `testthat.R` inside the `tests/` folder with the following content:
   ```R
   library(testthat)
   library(your_package_name) # Replace with your actual package name

   test_check("your_package_name") # Replace with your actual package name
   ```
5. Inside the `tests/testthat/` folder, create test files for each module or function you want to test. Name the files starting with `test_`, e.g., `test_io.R`, `test_cleaning.R`.

This will set up the basic structure needed to start writing and running unit tests using the `testthat` framework.

## How to add new unit tests
1. Identify the function or module you want to test.
2. Create a new test file in the `tests/testthat/` folder if it doesn't already exist (e.g., `test_new_module.R`).
3. Write test cases using the `test_that()` function from the `testthat` package. Each test case should check a specific aspect of the function's behavior.
4. Use `expect_*` functions to define the expected outcomes (e.g., `expect_equal()`, `expect_true()`, `expect_error()`).
5. Save the test file.

## Example test
Here is an example of a unit test for a hypothetical function `add_numbers()` that adds two numbers:

```R
test_that("add_numbers adds two numbers correctly", {
  result <- add_numbers(2, 3)
  expect_equal(result, 5)

  result <- add_numbers(-1, 1)
  expect_equal(result, 0)

  result <- add_numbers(0, 0)
  expect_equal(result, 0)
})
```

## Practical tips
- Add tests for every new function or module you create.
- Use comments and docstrings to explain what each test does.
- Test edge cases and typical usage.
- Keep tests simple and focused.
- Add tests for new functions when you create them.
