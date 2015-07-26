## prerequisite: the dataset has been downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and unpacked into subdirectory "data".

library(dplyr)

## First step: reading in different datasets, with some modification when needed:

activity_label <- read.table("./data/activity_labels.txt")  
## reading in activity labels

activity_test <- read.table("./data/test/y_test.txt")   
## reading test labels

activity_train <- read.table("./data/train/y_train.txt")
## reading training labels

subject_test <- read.table("./data/test/subject_test.txt")  
## reading in test subject labels

subject_train <-read.table("./data/train/subject_train.txt")  
##reading in train subject labels

features <- read.table("./data/features.txt")
## reading in features
feature <- features[ ,2]  
## subsetting data frame to the feature vector
featurec <- as.character(feature) 
## I want to use make.unique() and I need a character vector instead of factors
featureunique <- make.unique(featurec)
## to avoid duplicate column names

test <- read.table("./data/test/X_test.txt")  ## reading in test set
train <- read.table("./data/train/X_train.txt")  ## reading in train set

## Everything read into R. Now data sets should be combined and cleaned
## first the test and train data

testtrain<-rbind(test, train)  
## combining the test set and training set into one
names(testtrain) <- featureunique  
## renaming variables according to feature, so giving 'valid' variable names
testtrain <- tbl_df(testtrain) 
## to convert it to a 'nicer', dplyr-friendly format. Maybe I could have done it eariler...
tmainstd <- select(testtrain, contains("mean()"), contains("std()")) 
## leaving only the measurements on mean and standard deviation

## Training and test labels:
activity<- rbind(activity_test, activity_train) 
## putting together test and train labels
names(activity)<- "activity" 
## giving it a more understandeable name

## The data identifying subjects who performed the given activity
subject<- rbind(subject_test, subject_train) 
## putting together subject info for test and train
names(subject) <- "subject" ## re-naming it

## bringing together the combined test-train data with the activities and subjects:

data <- cbind(subject, activity, tmainstd) 
## adding the two columns (subject and activity info) to the data

## tidying the dataset:

tidy <- data %>%
        group_by(subject, activity) %>%
## grouping the data by activity and by subject
        summarise_each(funs(mean)) 
## calculating average of each variable for each activity and each subject.

## the data still needs some formatting:
## - replacing activity codes with the actual activities
## - editing variable names

activity_label2 <- as.character(activity_label[ ,2]) 
## transforming activity names from factors to characters so that I can use later more easily

for (i in 1:6) { tidy[tidy$activity == i, 2] <- activity_label2[i]} 
#replace activity numbers with activity names

names(tidy) <- tolower(names(tidy)) 
## getting rid of capital letters from variable names
names(tidy)<- gsub("-", ".", names(tidy))
## replacing "-" to "." in variable names
names(tidy)<- sub("[(]", "", names(tidy))
## removing "(" from variable names
names(tidy)<- sub("[)]", "", names(tidy))
## removing ")" from variable names

View(tidy) ## to see what happened

write.table(tidy, file = "./data/tidydata.txt", row.name = FALSE )
