# 1. Load Dplyr library
library("dplyr");

# 2. Load common data
features <- read.table("./UCI HAR Dataset/features.txt", quote="\"", col.names=c("variable_id","variable_name"));
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", col.names=c("activity_id","activity_name"));

# 3. Define columns to keep
columns_to_keep <- grep("mean\\(\\)|std\\(\\)", features$variable_name);

# 4. Create function to load data
# Param: source name ("test" or "train")
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

# 4. Merge data
data <- bind_rows(load_data("test"), load_data("train"));

# 5. Remove unused data
rm(features, activity_labels, columns_to_keep);