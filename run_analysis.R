# Coursera Getting and Cleaning Data Project
# run_analaysis.R
# Adam Chandler

# Load the dplyr library
library(dplyr)
library(reshape2)

# Download and unzip the file outside R

# run_analysis.R: 

#The working directory is:
print('Your working directory is:')
print(getwd())

# Is project your working directory into the project working directory?

folder.data <- './UCI HAR Dataset/'

# data: Unzip the the data files

# This script expects the data files will be in child of your project folder called:')
print(folder.data)
# URL for the UCI HAR Dataset files is:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Unzip the data files into the project folder.


# IMPORTANT! Are the data files in the right place?

if ( file.exists(folder.data)) { 
  cat("Good: path for data files found") 
} else {
  cat("Error: path for data files could not be found in relation to the the currect working directory")
}

#### Get configuration files need to process test and train ####

# features
filepath.features <- paste(folder.data, "features.txt", sep="")
df.allfeatures <- read.table(filepath.features, quote="\"", stringsAsFactors=FALSE)
filteredfeatures <- df.allfeatures %>% filter(!is.na(V2)) %>% filter(grepl("-std|-mean", V2))
# for more stric definition of mean use this filter:
# filteredfeatures <- df.allfeatures %>% filter(!is.na(V2)) %>% filter(grepl("-std|-mean", V2)) %>% filter(!grepl("-meanFreq", V2))


# activities
filepath.activity_labels <- paste(folder.data, "activity_labels.txt", sep="")
df.activity_labels <- read.table(file = filepath.activity_labels, stringsAsFactors=FALSE)

#### Setup functions ####

process.x <- function(folder.data, theset, filteredfeatures) {
  file.x_ <- paste(folder.data, theset, "/X_",  theset, ".txt", sep="")
  df.x_ <- read.table(file.x_, quote="\"", stringsAsFactors=FALSE)
  df.x_filtered <- df.x_[c(filteredfeatures$V1)]
  names(df.x_filtered) <- filteredfeatures[, 2]
  return(df.x_filtered)
}

process.y <- function(folder.data, theset) {
  file.y_ <- paste(folder.data, theset, "/y_", theset, ".txt", sep="")
  df.y_ <- read.csv(file.y_, header=F, stringsAsFactors=FALSE)
  df.y_$V1 <- as.character(df.y_$V1) 
  return(df.y_)
}

process.subject <- function(folder.data, theset) {
  file.subject_ <- paste(folder.data, theset, "/subject_", theset, ".txt", sep="")
  df.subject_ <- read.csv(file.subject_, header=F, stringsAsFactors=FALSE)
  return(df.subject_)
}

getactivityname <- function(ynum, df.activity_labels) {
    return(df.activity_labels[ynum,2])
}

#### Process test folder ####

df.test.x_filtered <- process.x(folder.data, "test", filteredfeatures)
df.test.y_ <- process.y(folder.data, "test")
df.test.y_named <- df.test.y_
df.test.subject_ <- process.subject(folder.data, "test")

for (i in 1:nrow(df.test.y_named)) {
  df.test.y_named$V1[i] <- getactivityname(df.test.y_named$V1[i], df.activity_labels)
}

df.test_wnamedrows <- cbind(df.test.subject_$V1, df.test.y_named$V1, df.test.x_filtered, stringsAsFactors=FALSE)
rm(df.test.x_filtered)
colnames(df.test_wnamedrows)[1] <- 'subject'
colnames(df.test_wnamedrows)[2] <- 'activity'

#### Process train folder ####

df.train.x_filtered <- process.x(folder.data, "train", filteredfeatures)
df.train.y_ <- process.y(folder.data, "train")
df.train.y_named <- df.train.y_
df.train.subject_ <- process.subject(folder.data, "train")

for (i in 1:nrow(df.train.y_named)) {
  df.train.y_named$V1[i] <- getactivityname(df.train.y_named$V1[i], df.activity_labels)
}

df.train_wnamedrows <- cbind(df.train.subject_$V1, df.train.y_named$V1, df.train.x_filtered, stringsAsFactors=FALSE)
rm(df.train.x_filtered)
colnames(df.train_wnamedrows)[1] <- 'subject'
colnames(df.train_wnamedrows)[2] <- 'activity'

#### Combine the test and train data sets ####

df.combined <- rbind(df.test_wnamedrows, df.train_wnamedrows)
rm(df.test_wnamedrows)
rm(df.train_wnamedrows)

write.table(df.combined, "intermediate.txt")
write.csv(df.combined, "intermediate.csv")

#### Tidy up data and cast summary mean file ####

tidymelted <- melt(df.combined, id = c("subject", "activity"))
tidymeans <- dcast(tidymelted, subject + activity ~ variable, mean)

#### Write tidy data file for mean summaries to disk ####

write.table(tidymeans, "tidy.txt")
write.csv(tidymeans, "tidy.csv")
