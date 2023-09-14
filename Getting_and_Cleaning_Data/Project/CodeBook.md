==========================================================================================

This is the CodeBook for the week 4 project of "Getting and Cleaning Data Course Project"

==========================================================================================

The data named "Human Activity Recognition Using Smartphones" was used in this project, provided by the UCI machine learning repository.

A full descrpition is available at the site where the data was obtained:
https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


"run_analysis.R" does the following:

1. Merges the training and test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

By implementig the following step by step:
- unzip the file
- read data from the training and test data sets
- read features and activities and assign them to the variables
- merge the two parts of data into one
- read variable names
- extract only the measurements on the mean and standard deviation for each measurement
- create a new data set that calculate the average of each variable for each activity and each subject
- save the new data set to "tidyData.txt"

*Variables*  
subject_[train/test]: subject ID  
X_[train/test]: values of listed features  
y_[train/test]: type of activities  
dt: combined data set  
dt_extract: extract only the measurements on the mean and standard deviation for each measurement from the dt  
dt_tidy: data set that calculate the average of each variable for each activity and each subject from the dt_extract  

Refer to the decompressed file "features_info.txt" for the features information

