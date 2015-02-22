---
title: "CodeBook for Getting and Cleaning Data - Course Project"
author: "Bela Czeiner"
date: "Sunday, February 22, 2015"
output: html_document
---

This is the CodeBook document of the Getting and Cleaning Data program Course Project (https://class.coursera.org/getdata-011) on Coursera.

This CodeBook contains:
1. General notes and reference to original source data
2. Data dictionary

1. General notes and reference to original source data
---

*Full description of the original source data:*
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

*Original source data for the project can be foud in:*
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Important notes**

- As it was not clearly stated in the project description I decided to use mean() and std() variables as well as the meanFeq() variables. Consequently I have 33+33+13=79 variables in total.
- Not all files are used from the source data. List and details of the all original files can be found in the README.txt of the source data (_".\UCI HAR Dataset" folder._).


2. Data dictionary
---

####Files used from the source data are the following

```
    Data files:
        - 'train/X_train.txt': Training set.
        - 'train/y_train.txt': Training labels.
        - 'train/subject_train.txt' : Training subjects.
        - 'test/X_test.txt': Test set.
        - 'test/y_test.txt': Test labels.
        - 'test/subject_test.txt' : Test subjects. 
    
    Data definiton files:
        - 'features_info.txt': Shows information about the variables used on the feature vector.
        - 'features.txt': List of all features.
        - 'activity_labels.txt': Links the class labels with their activity name.
        - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
```


####Data description of the two output data set of the project

**'tidy1' dataset contains 2 identifiers and 79 features**

- The two identifers are the id-s of the Subjects who performed the activity, 
- and names of the performed activities (ActivityNames).
- Features are selected from the source data by extracting only the measurements with means and standard deviations:
(mean() and std() variables as well as the meanFeq() variables in the original features list)
- Features are normalized and bounded within [-1,1] - just as in the source data
- Each feature vector is a row on the text file - just as in the source data

Features variable names are descriptive variable names based on the logic of the source data respective variables with the following differeces:
 - Hyphens (-) and Parentheses () are replaced with Period signs (.) to made the variable names legal in R.
 - Discrepancies between the data description of the source files and the actual variable names are corrected ("BodyBody" changed to "Body").
 - 't' and 'f' prefixes (denoting time and frequency) replaced with 'Time' and 'Freq'.


```
    Coloumn #   Variable Name
                    Description
                    .potential values
    =========   ======================             
                    
            1   Subject
                    Integer values, each number identifies the subject 
                    (See in: 'subject_____train.txt' and 'subject_train.txt' in the source data)
                    .1..30
                    
            2   ActivityNames
                    Six distinct string, each representing an activity of the test subjects.
                    (Source: 'activity_labels.txt' in the source data)
                    .WALKING
                    .WALKING_UPSTAIRS
                    .WALKING_DOWNSTAIRS
                    .SITTING
                    .STANDING
                    .LAYING

            3	TimeBodyAcc.mean.X
            4	TimeBodyAcc.mean.Y
            5	TimeBodyAcc.mean.Z
            6	TimeBodyAcc.std.X
            7	TimeBodyAcc.std.Y
            8	TimeBodyAcc.std.Z
            9	TimeGravityAcc.mean.X
            10	TimeGravityAcc.mean.Y
            11	TimeGravityAcc.mean.Z
            12	TimeGravityAcc.std.X
            13	TimeGravityAcc.std.Y
            14	TimeGravityAcc.std.Z
            15	TimeBodyAccJerk.mean.X
            16	TimeBodyAccJerk.mean.Y
            17	TimeBodyAccJerk.mean.Z
            18	TimeBodyAccJerk.std.X
            19	TimeBodyAccJerk.std.Y
            20	TimeBodyAccJerk.std.Z
            21	TimeBodyGyro.mean.X
            22	TimeBodyGyro.mean.Y
            23	TimeBodyGyro.mean.Z
            24	TimeBodyGyro.std.X
            25	TimeBodyGyro.std.Y
            26	TimeBodyGyro.std.Z
            27	TimeBodyGyroJerk.mean.X
            28	TimeBodyGyroJerk.mean.Y
            29	TimeBodyGyroJerk.mean.Z
            30	TimeBodyGyroJerk.std.X
            31	TimeBodyGyroJerk.std.Y
            32	TimeBodyGyroJerk.std.Z
            33	TimeBodyAccMag.mean
            34	TimeBodyAccMag.std
            35	TimeGravityAccMag.mean
            36	TimeGravityAccMag.std
            37	TimeBodyAccJerkMag.mean
            38	TimeBodyAccJerkMag.std
            39	TimeBodyGyroMag.mean
            40	TimeBodyGyroMag.std
            41	TimeBodyGyroJerkMag.mean
            42	TimeBodyGyroJerkMag.std
            43	FreqBodyAcc.mean.X
            44	FreqBodyAcc.mean.Y
            45	FreqBodyAcc.mean.Z
            46	FreqBodyAcc.std.X
            47	FreqBodyAcc.std.Y
            48	FreqBodyAcc.std.Z
            49	FreqBodyAcc.meanFreq.X
            50	FreqBodyAcc.meanFreq.Y
            51	FreqBodyAcc.meanFreq.Z
            52	FreqBodyAccJerk.mean.X
            53	FreqBodyAccJerk.mean.Y
            54	FreqBodyAccJerk.mean.Z
            55	FreqBodyAccJerk.std.X
            56	FreqBodyAccJerk.std.Y
            57	FreqBodyAccJerk.std.Z
            58	FreqBodyAccJerk.meanFreq.X
            59	FreqBodyAccJerk.meanFreq.Y
            60	FreqBodyAccJerk.meanFreq.Z
            61	FreqBodyGyro.mean.X
            62	FreqBodyGyro.mean.Y
            63	FreqBodyGyro.mean.Z
            64	FreqBodyGyro.std.X
            65	FreqBodyGyro.std.Y
            66	FreqBodyGyro.std.Z
            67	FreqBodyGyro.meanFreq.X
            68	FreqBodyGyro.meanFreq.Y
            69	FreqBodyGyro.meanFreq.Z
            70	FreqBodyAccMag.mean
            71	FreqBodyAccMag.std
            72	FreqBodyAccMag.meanFreq
            73	FreqBodyBodyAccJerkMag.mean
            74	FreqBodyBodyAccJerkMag.std
            75	FreqBodyBodyAccJerkMag.meanFreq
            76	FreqBodyBodyGyroMag.mean
            77	FreqBodyBodyGyroMag.std
            78	FreqBodyBodyGyroMag.meanFreq
            79	FreqBodyBodyGyroJerkMag.mean
            80	FreqBodyBodyGyroJerkMag.std
            81	FreqBodyBodyGyroJerkMag.meanFreq
```


**'tidy2' dataset contains 2 identifiers and 79 features**

- Details are identican as described for 'tidy1' dataset with the exception that feature variables are averaged values for each activity and each subject.
- To reflect this aggregation the 79 fearure variable names are prefixed with 'Avg.'.

```
    Coloumn #   Variable Name
                    Description
                    .potential values
    =========   ======================             
                    
            1   Subject
                    Integer values, each number identifies the subject 
                    (See in: 'subject_____train.txt' and 'subject_train.txt' in the source data)
                    .1..30
                    
            2   ActivityNames
                    Six distinct string, each representing an activity of the test subjects.
                    (Source: 'activity_labels.txt' in the source data)
                    .WALKING
                    .WALKING_UPSTAIRS
                    .WALKING_DOWNSTAIRS
                    .SITTING
                    .STANDING
                    .LAYING

            3   Avg.TimeBodyAcc.mean.X
            4	Avg.TimeBodyAcc.mean.Y
            5	Avg.TimeBodyAcc.mean.Z
            6	Avg.TimeBodyAcc.std.X
            7	Avg.TimeBodyAcc.std.Y
            8	Avg.TimeBodyAcc.std.Z
            9	Avg.TimeGravityAcc.mean.X
            10	Avg.TimeGravityAcc.mean.Y
            11	Avg.TimeGravityAcc.mean.Z
            12	Avg.TimeGravityAcc.std.X
            13	Avg.TimeGravityAcc.std.Y
            14	Avg.TimeGravityAcc.std.Z
            15	Avg.TimeBodyAccJerk.mean.X
            16	Avg.TimeBodyAccJerk.mean.Y
            17	Avg.TimeBodyAccJerk.mean.Z
            18	Avg.TimeBodyAccJerk.std.X
            19	Avg.TimeBodyAccJerk.std.Y
            20	Avg.TimeBodyAccJerk.std.Z
            21	Avg.TimeBodyGyro.mean.X
            22	Avg.TimeBodyGyro.mean.Y
            23	Avg.TimeBodyGyro.mean.Z
            24	Avg.TimeBodyGyro.std.X
            25	Avg.TimeBodyGyro.std.Y
            26	Avg.TimeBodyGyro.std.Z
            27	Avg.TimeBodyGyroJerk.mean.X
            28	Avg.TimeBodyGyroJerk.mean.Y
            29	Avg.TimeBodyGyroJerk.mean.Z
            30	Avg.TimeBodyGyroJerk.std.X
            31	Avg.TimeBodyGyroJerk.std.Y
            32	Avg.TimeBodyGyroJerk.std.Z
            33	Avg.TimeBodyAccMag.mean
            34	Avg.TimeBodyAccMag.std
            35	Avg.TimeGravityAccMag.mean
            36	Avg.TimeGravityAccMag.std
            37	Avg.TimeBodyAccJerkMag.mean
            38	Avg.TimeBodyAccJerkMag.std
            39	Avg.TimeBodyGyroMag.mean
            40	Avg.TimeBodyGyroMag.std
            41	Avg.TimeBodyGyroJerkMag.mean
            42	Avg.TimeBodyGyroJerkMag.std
            43	Avg.FreqBodyAcc.mean.X
            44	Avg.FreqBodyAcc.mean.Y
            45	Avg.FreqBodyAcc.mean.Z
            46	Avg.FreqBodyAcc.std.X
            47	Avg.FreqBodyAcc.std.Y
            48	Avg.FreqBodyAcc.std.Z
            49	Avg.FreqBodyAcc.meanFreq.X
            50	Avg.FreqBodyAcc.meanFreq.Y
            51	Avg.FreqBodyAcc.meanFreq.Z
            52	Avg.FreqBodyAccJerk.mean.X
            53	Avg.FreqBodyAccJerk.mean.Y
            54	Avg.FreqBodyAccJerk.mean.Z
            55	Avg.FreqBodyAccJerk.std.X
            56	Avg.FreqBodyAccJerk.std.Y
            57	Avg.FreqBodyAccJerk.std.Z
            58	Avg.FreqBodyAccJerk.meanFreq.X
            59	Avg.FreqBodyAccJerk.meanFreq.Y
            60	Avg.FreqBodyAccJerk.meanFreq.Z
            61	Avg.FreqBodyGyro.mean.X
            62	Avg.FreqBodyGyro.mean.Y
            63	Avg.FreqBodyGyro.mean.Z
            64	Avg.FreqBodyGyro.std.X
            65	Avg.FreqBodyGyro.std.Y
            66	Avg.FreqBodyGyro.std.Z
            67	Avg.FreqBodyGyro.meanFreq.X
            68	Avg.FreqBodyGyro.meanFreq.Y
            69	Avg.FreqBodyGyro.meanFreq.Z
            70	Avg.FreqBodyAccMag.mean
            71	Avg.FreqBodyAccMag.std
            72	Avg.FreqBodyAccMag.meanFreq
            73	Avg.FreqBodyAccJerkMag.mean
            74	Avg.FreqBodyAccJerkMag.std
            75	Avg.FreqBodyAccJerkMag.meanFreq
            76	Avg.FreqBodyGyroMag.mean
            77	Avg.FreqBodyGyroMag.std
            78	Avg.FreqBodyGyroMag.meanFreq
            79	Avg.FreqBodyGyroJerkMag.mean
            80	Avg.FreqBodyGyroJerkMag.std
            81	Avg.FreqBodyGyroJerkMag.meanFreq
```


# End-of-File  


