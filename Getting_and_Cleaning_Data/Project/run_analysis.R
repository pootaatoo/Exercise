rm(list = ls())

## 1. Merge the training and test sets to create one data set
# read from the training set
subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt", header = F)
X_train <- read.table("../UCI HAR Dataset/train/X_train.txt", header = F)
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt", header = F)

# read from the test set
subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt", header = F)
X_test <- read.table("../UCI HAR Dataset/test/X_test.txt", header = F)
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt", header = F)

# read features and activities name
features <- read.table("../UCI HAR Dataset/features.txt", header = F)
activity_labels <- read.table("../UCI HAR Dataset/activity_labels.txt", header = F)

# merge two sets and assign names to variables
subject <- rbind(subject_train,subject_test)
X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
colnames(subject) <- "subject"
colnames(X) <- features[,2]
colnames(y) <- "activity"

dt <- cbind(subject, y, X)

## 2. Extract only the measurements on the mean and standard deviation for each
##    measurement
dt_extract <- dt[, grep("min|std", names(dt))]
# attach "subject" and "activity" to the extract data set
dt_extract <- cbind(dt[,1:2],dt_extract)

## 3. Use descriptive activity names to name the activities in the data set
# names the activities in the data set
for (i in 1:nrow(activity_labels)) {
  dt_extract$activity[which(dt_extract$activity == i)] = activity_labels[i,2]
}
## 4. Appropriately labels the data set with descriptive variable names
# it is done in question 1
# check the variable names of the data set
names(dt_extract)

## 5. From the data set in step 4, create a second, independent tidy data set
##    with the average of each variable for each activity and each subject
dt_tidy <- aggregate(. ~subject + activity, data = dt_extract, FUN = mean)
write.table(dt_tidy, "tidyData.txt",row.names = F)
