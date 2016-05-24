rm(list = ls())
setwd(choose.dir())
library(plyr)
library(data.table)

# Downloading dataset
#if the file "getdata-projectfiles-UCI HAR Dataset.zip" exists in working directory there is no need to download it again
if(!file.exists("./datafile")){dir.create("./datafile")}
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./datafile/Data.zip")
} else{
  file.copy("./getdata-projectfiles-UCI HAR Dataset.zip","./datafile/Data.zip",overwrite = TRUE)
}
# Unzip dataSet to /data directory
unzip("./datafile/Data.zip",exdir = "./datafile")


# 1. Merging the training and the test sets to create one data set:

#  Reading files
Training_set <- read.table("./datafile/UCI HAR Dataset/train/X_train.txt", header = FALSE)
Training_labels <- read.table("./datafile/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./datafile/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Test_set <- read.table("./datafile/UCI HAR Dataset/test/X_test.txt", header = FALSE)
Test_labels <- read.table("./datafile/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./datafile/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
all_features <- read.table('./datafile/UCI HAR Dataset/features.txt', header = FALSE)
activityLabels = read.table('./datafile/UCI HAR Dataset/activity_labels.txt', header = FALSE)

#  Assigning column names:
colnames(Training_set) <- all_features[,2] 
colnames(Training_labels) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(Test_set) <- all_features[,2] 
colnames(Test_labels) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging all data in one set:
MergeTrain <- cbind(Training_labels, subject_train, Training_set)
MergeTest <- cbind(Test_labels, subject_test, Test_set)
ALL <- rbind(MergeTrain, MergeTest)

# 2. Extracting only the measurements on the mean and standard deviation for each measurement

#  Reading column names:
colNames <- colnames(ALL)

# Create vector for defining ID, mean and standard deviation:
Mean_Std_Set <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

# Making subset from ALL:
WithMeanAndStd <- ALL[ , Mean_Std_Set == TRUE]

# 3. Using descriptive activity names to name the activities in the data set:

for (i in 1:6){
  WithMeanAndStd$activityId[WithMeanAndStd$activityId == i] <- as.character(activityLabels[i,2])
}
colnames(WithMeanAndStd)[1] <-"activity"

# 4. Appropriately labeling the data set with descriptive variable names.
names(WithMeanAndStd)<-gsub("Acc", "Accelerometer", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("Gyro", "Gyroscope", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("BodyBody", "Body", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("Mag", "Magnitude", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("^t", "Time", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("^f", "Frequency", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("tBody", "TimeBody", names(WithMeanAndStd))
names(WithMeanAndStd)<-gsub("-mean()", "Mean", names(WithMeanAndStd), ignore.case = TRUE)
names(WithMeanAndStd)<-gsub("-std()", "STD", names(WithMeanAndStd), ignore.case = TRUE)
names(WithMeanAndStd)<-gsub("-freq()", "Frequency", names(WithMeanAndStd), ignore.case = TRUE)


# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

#  Making second tidy data set 
TidySet <- aggregate(. ~subjectId + activity, WithMeanAndStd, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activity),]


#  Writing the tidy data set in txt file
write.table(TidySet, "TidyData.txt", row.name=FALSE)
