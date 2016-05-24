CodeBook
---------------------------------------------------------------
This document describes the data and transofrmations used by *run_analysis.R* and the definition of variables in *Tidy.txt*.

##Dataset Used

This data is obtained from "Human Activity Recognition Using Smartphones Data Set". The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

The data set used can be downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 

##Input Data Set

The input data containts the following data files:

- `X_train.txt` contains variable features that are intended for training.
- `y_train.txt` contains the activities corresponding to `X_train.txt`.
- `subject_train.txt` contains information on the subjects from whom data is collected.
- `X_test.txt` contains variable features that are intended for testing.
- `y_test.txt` contains the activities corresponding to `X_test.txt`.
- `subject_test.txt` contains information on the subjects from whom data is collected.
- `activity_labels.txt` contains metadata on the different types of activities.
- `features.txt` contains the name of the features in the data sets.

##Transformations

Following are the transformations that were performed on the input dataset:

- `X_train.txt` is read into `Training_set`.
- `y_train.txt` is read into `Training_labels`.
- `subject_train.txt` is read into `subject_train`.
- `X_test.txt` is read into `Test_set`.
- `y_test.txt` is read into `Test_labels`.
- `subject_test.txt` is read into `subject_test`.
- `features.txt` is read into `all_features`.
- `activity_labels.txt` is read into `activityLabels`.
- The `Training_labels`, `subject_train` and `Training_set` are merged to form `MergeTrain`.
- The `Test_labels`, `subject_test` and `Test_set` are merged to form `MergeTest`.
- The `MergeTrain` and `MergeTest` are merged to form `ALL`.
- Indices of columns that contain std or mean, activity and subject are taken into `Mean_Std_Set` .
- `WithMeanAndStd` is created with data from columns in `Mean_Std_Set`.
- `ActivityId` column in `WithMeanAndStd` is updated with descriptive names of activities taken from `activityLabels`.
- `ActivityId` lable name change to `Activity`.
- Acronyms in variable names in `WithMeanAndStd`, like 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and 'Frequency'.
- `tidySet` is created as a set with average for each activity and subject of `WithMeanAndStd`. Entries in `tidySet` are ordered based on activity and subject.
- Finally, the data in `tidySet` is written into `TidyData.txt`.

##Output Data Set

The output data `TidyData.txt` is a a space-delimited value file. The header line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files. The header is restructued in an understandable manner.
###Variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix `t` to denote time-we change it to `Time`-) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly to the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently to the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag to tGravityAccMag to tBodyAccJerkMag to tBodyGyroMag to tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ to fBodyAccJerk-XYZ to fBodyGyro-XYZ to fBodyAccJerkMag to fBodyGyroMag to fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
'-XYZ' is used to denote 3-axial signals in the X to Y and Z directions.

####We change names of
- `Acc` to `Accelerometer` 
- `Gyro` to `Gyroscope` 
- `BodyBody` to `Body` 
- `Mag` to `Magnitude` 
- `^t` to `Time` 
- `^f` to `Frequency`
- `tBody` to `TimeBody` 
- `-mean()` to `Mean` 
- `-std()` to `STD`
- `-freq()` to `Frequency`

The set of variables that were estimated from these signals are: 
- mean(): Mean value
- std(): Standard deviation

