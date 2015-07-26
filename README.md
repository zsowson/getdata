# getdata
Getting and Cleaning Data - project assignment

This repo contains 3 files:
1. run_analysis.R: the script that describes all the steps taken in order to arrive from the original data files to the tidy data output
2. codebook.txt: describes the variables in the tidy dataset.
3. the tidy data itself which was created with taking into consideration Hadley Wickham's tidy data definition:
* each variable forms a column
* each observation forms a row
* each type of observational unit forms a table

The dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unpacked into a subdirectory of the working directory (named 'data').

Project requirements were:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

run_analysis.R describes how the different steps were performed. 
