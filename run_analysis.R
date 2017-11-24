library(dplyr)
library(tidyr)
library(lubridate)

data_dir <- "data"
filename <- "uci_har_dataset.zip"

if (!file.exists(data_dir)) {
  dir.create(data_dir)
}

dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_filename <- file.path(data_dir, filename)
download.file(dataset_url, destfile = dest_filename, method = "curl")
date_downloaded <- now()
unzip(dest_filename, exdir = data_dir)

# Read activity and features lists
activity_labels <- read.table(file.path(data_dir, "UCI HAR Dataset", "activity_labels.txt"), 
                              col.names = c("id", "label"))
features <- read.table(file.path(data_dir, "UCI HAR Dataset", "features.txt"), 
                       col.names = c("id", "name"))

# Create test dataset
test_subjects <- read.table(file.path(data_dir, "UCI HAR Dataset", "test", "subject_test.txt"), 
                               col.names = c("subject"))
test_activities <- read.table(file.path(data_dir, "UCI HAR Dataset", "test", "y_test.txt"), 
                                col.names = c("activity")) 
test_set_measures <- read.table(file.path(data_dir, "UCI HAR Dataset", "test", "X_test.txt"), 
                                 col.names = features$name) 
test_set <- cbind(test_subjects, test_activities, test_set_data) %>% as_tibble()

# Create training dataset
training_subjects <- read.table(file.path(data_dir, "UCI HAR Dataset", "train", "subject_train.txt"), 
                               col.names = c("subject"))
training_activities <- read.table(file.path(data_dir, "UCI HAR Dataset", "train", "y_train.txt"), 
                              col.names = c("activity")) 
training_set_measures <- read.table(file.path(data_dir, "UCI HAR Dataset", "train", "X_train.txt"), 
                           col.names = features$name)
training_set <- cbind(training_subjects, training_activities, training_set_measures) %>% as_tibble()

# - merge training and test datasets
# - give descriptive names to activity
combined_set <- rbind(training_set, test_set) %>%
    mutate(activity = activity_labels$label[activity]) 

# Extract measurements for mean and std into new dataset
mean_std_measures <- combined_set %>%  dplyr::select(subject, activity, matches("mean|std")) 

# Create new dataset with averages of each variable
averages <- mean_std_measures %>% dplyr::group_by(subject, activity) %>% 
  dplyr::summarize_all(funs(mean))

# Create tidy dataset of averages
tidy_means <- averages %>% gather(measure, mean, -subject, -activity)

# Write to file
write.table(tidy_means, file = "tidy_data.txt", row.names = FALSE)
