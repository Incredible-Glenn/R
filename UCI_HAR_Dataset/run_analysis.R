    ## Merges the training and the test sets to create one data set.
    # Read data
    library(dplyr)

    x_train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
    x_test <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
    
    features <- read.table("features.txt", stringsAsFactors = FALSE)
    
    subject_train <- read.table("train/subject_train.txt", 
                                stringsAsFactors = FALSE)
    subject_test <- read.table("test/subject_test.txt", 
                               stringsAsFactors = FALSE)
    
    y_train <- read.table("train/y_train.txt", stringsAsFactors = FALSE)
    y_test <- read.table("test/y_test.txt", stringsAsFactors = FALSE)
    
    # Assign columns name
    colnames(x_train) <- features$V2
    colnames(x_test) <- features$V2
    
    colnames(subject_train) <- "subject_id"
    colnames(subject_test) <- "subject_id"
    
    colnames(y_train) <- "activity_id"
    colnames(y_test) <- "activity_id"
    
    # Merge train and test data
    x_full <- bind_rows(x_train, x_test)
    subject_full <- bind_rows(subject_train, subject_test)
    y_full <- bind_rows(y_train, y_test)
    
    # Final dataset
    fulldata <- bind_cols(subject_full, y_full, x_full)
    
    ## Extracts only the measurements on the mean and standard deviation for 
    ## each measurement. 
    fulldata <- fulldata %>%
        select(subject_id, activity_id, matches("(mean|std)\\(\\)"))
    
    ## Uses descriptive activity names to name the activities in the data set
    # Read labels and assign names
    activity_labels <- read.table("activity_labels.txt", 
                                  stringsAsFactors = FALSE) %>%
        setNames(c("activity_id", "activity_name")) %>%
        mutate(activity_name = factor(activity_name))
    
    # join labels into fulldata and keep activity_name only
    fulldata <- fulldata %>%
        left_join(activity_labels, by = "activity_id") %>% 
        select(-activity_id)
    
    ## Appropriately labels the data set with descriptive variable names
    colnames(fulldata) <- colnames(fulldata) %>%
        gsub("^t", "time_", .) %>%
        gsub("^f", "freq_", .) %>%
        gsub("Acc", "_acceleration", .) %>%
        gsub("Gyro", "_gyro", . ) %>%
        gsub("Jerk", "_jerk", .) %>%
        gsub("Mag", "_magnitude", .) %>%
        gsub("BodyBody", "Body", .) %>%
        gsub("\\(\\)", "", .) %>%
        gsub("Freq$", "_freq", .) %>%
        gsub("mean$", "_mean", .) %>%
        gsub("-", "_", .) %>%
        tolower()
    
    ## From the data set in step 4, creates a second, independent tidy data set 
    ## with the average of each variable for each activity and each subject.
    tidydata_mean <- fulldata %>%
        group_by(activity_name, subject_id) %>%
        summarise(across(where(is.numeric), 
                         mean, 
                         .names = "{.col}_avg"), 
                  .groups = "drop") 
    # Write to file
    write.table(tidydata_mean, "tidydata_mean.txt", row.names = FALSE)