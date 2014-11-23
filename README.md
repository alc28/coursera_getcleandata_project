## README.md
## Getting & Cleaning Data Course Project 
### by Adam Chandler

## Included files in the github repo are:

* README.md  - Provides overview of the files, how run_analysis.R works, and how to configure everything correctly.
* run_analysis.R - The script that processed the UCI HAR Dataset into tidy data form.
* codebook.md - Describes the data elements contained in tidy.txt, the tidy data file that is produced run_analysis.R script is run.

## Files created by run_analysis.R:

* tidy.txt and tidy.csv - This file is not included github repo.  It was uploaded to the coursera website.  It will be produced when the file is run.  It is described in the codebook.
* intermediate.txt and intermediate.csv - This file is not included github. It will be produced when the file is run.   The script produceds it because it is evidence of how the non-tidy intermediate file looks before it becomes a tidy summary file.

## Required input data files: UCI HAR Dataset

The required UCI HAR Dataset input data files are available at this url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Configuring the script

1. Clone this github repository to your computer
* git clone git@github.com:alc28/coursera_getcleandata_project.git
2. Download the UCI HAR Dataset and unzip it as a child folder within the cloned repo
* expected repo and data file structure: 'coursera_getcleandata_project/UCI HAR Dataset'

## run_analysis.R 

The purpose of this R script is transform the UCI HAR Dataset into tidy form.  It has the following parts:

**It is recommended that you clear the R workspace before you run the script! It may take over 10 seconds to run**

***

#### 1. Load the required libraries
library(dplyr)  
library(reshape2)

#### 2. Download and unzip the file outside R
#### 3. Check to be sure the data files in the right place
#### 4. Get configuration files need to process test and train
#### 5. Setup functions
#### 6. Process test folder
#### 7  Process train folder
#### 8. Combine the test and train data sets and write intermediate version to disk
#### 9. Tidy up data and cast summary mean file
#### 10. Write mean summaries tidy data file for to disk
