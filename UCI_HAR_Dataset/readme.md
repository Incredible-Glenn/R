# Getting and Cleaning Data – Course Project

This repository contains the R script and documentation for the
Course Project of the Getting and Cleaning Data course on Coursera.

The goal of this project is to demonstrate how to collect, work with,
and clean a raw dataset to produce a tidy dataset suitable for analysis.

---

## Files

| File | Description |
|----|----|
| run_analysis.R | Main R script for data processing |
| tidydata_mean.txt | Final tidy dataset |
| CodeBook.md | Description of variables |
| README.md | This file |

---

## Raw Data

The raw data come from the Human Activity Recognition Using Smartphones Dataset:

https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

To run the script correctly, place the `UCI HAR Dataset` folder
in your working directory.

---

## How to Run

1. Open R or RStudio
2. Set the working directory to the project folder
3. Run the script: source("run_analysis.R"). This will generate a file 
named: tidydata_mean.txt in your working directory.

---

## Dependencies

- R (version 4.0 or later recommended)
- dplyr package

Install dplyr if necessary:install.packages("dplyr")

---

## Output Description

The output dataset (`tidydata_mean.txt`) contains:

- One row per subject and activity combination
- The average value of each mean/std measurement
- Descriptive variable names

For details, see `CodeBook.md`.

---

## Author

Prepared as part of the Getting and Cleaning Data course project.
