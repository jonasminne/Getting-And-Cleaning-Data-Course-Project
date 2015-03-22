### Getting & Cleaning Data: Course Project

This document explains how the script run_analysis.R works.

#### 1) Load Dplyr library

Use Dplyr package to manipulate data.

#### 2) Load common data

Load features and activity data.

#### 3) Define columns to keep

Use a regex to define mean and standard deviation columns.

#### 4) Create function to load data

Write a function to load test or train data. This function returns mean and standard deviation with activity name.

```
load_data <- function(name = character()) {
        # Load subject and activity
        subject <- read.delim(paste("./UCI HAR Dataset/", name, "/subject_", name, ".txt", sep=""), header=FALSE, col.names=c("subject_id"));
        activity <- read.table(paste("./UCI HAR Dataset/", name, "/y_", name, ".txt", sep=""), quote="\"", col.names=c("activity_id"));
        
        # Load data
        read.table(paste("./UCI HAR Dataset/", name, "/X_", name, ".txt", sep=""), quote="\"", col.names=features$variable_name) %>%
        # Remove unused columns
        select(columns_to_keep) %>%
        # Map subject
        mutate(subject_id = subject$subject_id) %>%
        # Map activity and get activity name
        mutate(activity_id = activity$activity_id) %>%
        inner_join(activity_labels, by="activity_id") %>%
        # Remove activity_id column
        select(-activity_id);
}
```

#### 5) Merge data

Merge test and train data.

#### 6) Remove unused data

Remove features, activity_labels and columns_to_keep