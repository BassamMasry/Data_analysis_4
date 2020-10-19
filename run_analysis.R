# NOTE: set the working directory to UCI HAR Dataset folder

# A function to change label index in to activity label
lab_to_act <- function(element)
{
    if (element == 1)
    {
        "walking"
    }
    else if (element == 2)
    {
        "walking upstairs"
    }
    else if (element == 3)
    {
        "walking downstairs"
    }
    else if (element == 4)
    {
        "sitting"
    }
    else if (element == 5)
    {
        "standing"
    }
    else if (element == 6)
    {
        "laying"
    }
    else
    {
        "unspecified"
    }
}

# Read features names
features <- read.table("features.txt")[,2]
# turn them to valid names
features <- make.names(features, unique = TRUE)
# Read the test file
x_test <- read.table("test/X_test.txt", header = FALSE)
# Give the test columns names
names(x_test) = features
# append the activity labels
test_labels <- read.table("test/y_test.txt", header = FALSE)[[1]]
x_test <- cbind(x_test, test_labels)
names(x_test)[562] = "activity_names"
# change labels to names
x_test$'activity_names' = sapply(x_test[,562], lab_to_act)
# Remove test_labels vector
rm("test_labels")
# Append subject index
test_subject <- read.table("test/subject_test.txt")[[1]]
x_test <- cbind(x_test, test_subject)
names(x_test)[563] = "subject_index"
# Remove test subject vector
rm("test_subject")
# Read the train file
x_train <- read.table("train/X_train.txt", header = FALSE)
# Give the train columns names
names(x_train) = features
# append the activity labels
train_labels <- read.table("train/y_train.txt", header = FALSE)[[1]]
x_train <- cbind(x_train, train_labels)
names(x_train)[562] = "activity_names"
# change labels to names
x_train$'activity_names' = sapply(x_train[,562], lab_to_act)
# Remove train labels vector
rm("train_labels")
# append train subject index
train_subject <- read.table("train/subject_train.txt", header = FALSE)[[1]]
x_train <- cbind(x_train, train_subject)
names(x_train)[563] = "subject_index"
# Remove train subject vector
rm("train_subject")
# import dplyr and tidyr libraries
library(dplyr)
library(tidyr)
# Merge train and test datasets
full_data <- rbind(x_train,x_test)
# OPTIONAL: clear the two separate datasets for memory space
rm("x_test")
rm("x_train")
# get names of features with only mean or std
mean_std_indeces <- c(grep("mean", features), grep("std", features))
# select only columns with mean and std
mean_std_only <- select(full_data, all_of(mean_std_indeces))

# make a new dataset with mean for each activity and subject
grouped_data <- group_by(full_data, activity_names, subject_index)
avg_activity_subject <- summarise(grouped_data, across(everything(), mean))
