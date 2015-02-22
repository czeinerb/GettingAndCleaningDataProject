---
title: "Getting and Cleaning Data - Course Project"
author: "Bela Czeiner"
date: "Sunday, February 22, 2015"
output: html_document
---

This is the markdown document of the R script of the Course Project of the Getting and Cleaning Data program (https://class.coursera.org/getdata-011) on Coursera.

**Goal of the project is to prepare tidy data that can be used for later analysis**
**The tasks is to create an R script called _ run__analysis.R_ to do the following:**

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Additionally, provide explanation of the data and the script in the related markdown files.

# Explanation of the *run_analysis.R* script:

## Initialisation.
Init 1. Load required libraries

```
    library(data.table)
    library(plyr)
```

Init 2. Downlaod the zip file and extract the contents to the working directory - if necessary
**_This script starts with the assumption that the Samsung data is available in the working directory in an unzipped "UCI HAR Dataset" folder_**

If the data is NOT available then it can be dowloaded with the following script:

```
    MS Windows:
        zipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(zipUrl,dest="dataset.zip", mode = "wb") 
        unzip ("dataset.zip",exdir = ".")

    Mac:
        zipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(zipUrl,dest="dataset.zip", method='curl') 
        unzip ("dataset.zip",exdir = ".")
```

**Notes:**

- If source data will be downloaded to your working directory and extracted to the ".\UCI HAR Dataset" folder. Allow at least 330 MB for the compressed and extracted data.
- Downloading the data (size 59.7 MB) may take a while depending on the speed of connection. 
- The second tidy (tidy2) dataset with the averages will be exported to your working directory as "averages.txt". Optionally you can chose to export the first tidy dataset (tidy1) as "alldata.txt" to the same folder.

    
## Task 1: Merge the training and the test sets to create one data set.
**First read data TRAINING and TEST files into separate dataframes**

```
    trainSubj = read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", head=FALSE)
    trainActiv = read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", head=FALSE)
    trainDetails = read.csv("./UCI HAR Dataset/train/x_train.txt", sep="", head=FALSE)
    testSubj = read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", head=FALSE)
    testActiv = read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", head=FALSE)
    testDetails = read.csv("./UCI HAR Dataset/test/x_test.txt", sep="", head=FALSE)
```
    
_Note that_
```
sep=""
```
_is used to treat consecutive spaces as one single delimiter._

Check structure of imported data with:

```
    str(trainSubj)
    str(trainActiv)
    str(trainDetails)
    str(testSubj)
    str(testActiv)
    str(testDetails)
```

As a result, _trainDetails_ and _testDetails_ dataframes should have 561 variables while the others should only have one. Also, training data must have 7352 and test data 2947 rows (objects).

**Next step is to combine training and test data per type:**

```
    Subj = rbind(trainSubj, testSubj)
    Activ = rbind(trainActiv, testActiv)
    Details = rbind(trainDetails, testDetails)
```
    
**And combine the three set of data into one data frame:**

Note that rbind/cbind works well here as all are dataframes, using 'deparse.level = 0' (default) is ok as there are no labels.

```
    theLot = cbind(Subj, Activ, Details)
```

**As part of the same task the script sorts out the column labes: **

This helps later on selecting the required measurements more easily.

```
    testLabels = read.csv("./UCI HAR Dataset/features.txt", sep="", head=FALSE)
    myLabels = c("Subject","Activity", as.character(testLabels[,2]))
    colnames(theLot) = myLabels
```

Check structure of combined data with:

```
    str(Subj)
    str(Activ)
    str(Details)
```
    
It should still have 1, 1 and 561 variables respectively, and all three dataframes need to have 10299 rows.

Also, with:

```
    str(theLot)    
    str(myLabels)
```

The resuting _theLot_ dataframe will have 563 (1+1+561) variables, while _myLabels_ is a character vector with the names of all 563 data columns (including "Subject" and "Activity"). It is not essential here but used to update the column headers of the combined dataframe to make the checking of results easier.


# Task 2: Extract only the measurements on the mean and standard deviation for each measurement.

Create a vector of all column labels (without "Subject" and "Activity"):
```
    xLab = as.character(testLabels[,2])
```

List column numbers of all lables with means and averages:
```
    ColMean = grep("mean()",xLab)
    ColStd = grep("std()",xLab)
```

Combine them together and set to accending order:
```
    ColMeanAndStd = c(ColMean, ColStd)
    ColMeanAndStd = sort(ColMeanAndStd)
```

Shift to the right by two, as the aggregated dataframe has two extra colums at the front:
```
    ColMeanAndStd = ColMeanAndStd + 2
```

Add the first two columns:
```
    ColMeanAndStd = c(c(1,2), ColMeanAndStd)
```
    
Finally use it to create new df with only the required columns!
```
    results0 = theLot[,ColMeanAndStd[1:81]]
```

Use:
```
    View(results0)
```
to see the extracted measurements.

# Task 3) Uses descriptive activity names to name the activities in the data set.

Read activity names:
```
    ActivityNames = read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", head=FALSE)
    colnames(ActivityNames) = c("Activity","ActivityNames")
```

Then merge it with the main dataframe and change the order of columns to make it more readable too:
```
    results1 = merge(x = results0, y = ActivityNames, by = "Activity", all.x=TRUE)
    results2 = results1[c(2,82,3:81)]
```
This will replace the Activity codes (from 1 to 6) in the second column with the names of the activities.

To check it, see a few lines extracted from the resulting data use:
```
    results2[1500:2000,1:5]
```

# Task 4) Appropriately label the data set with descriptive variable names.

_Note that the variable names used earlier were only to help with selecting the required measurements._
_This step is to replace it with more friendly, descriptive variable names, as well as to made the variable names legal in R._
_Additionally it corrects the discrepancies between the data description of the source files and the actual variable names._


First step of this task is to read the names to a vecor, then perform the clean up, and eventually write it back to the dataframe.

Note that as 't' and 'f' prefixes are denoting time and frequency, and they are replaced with 'Time' and 'Freq' in the variable names as an example to make it more descriptive.

```
    nn0 = names(results2)
    nn1 = gsub("\\.{3}|\\.{2}",".",make.names(nn0, unique = TRUE))
    nn2 = gsub("\\.$","", nn1)
    nn3 = gsub("^t","Time", gsub("^f","Freq", nn2))
```

Correct variable names containing "BodyBody" to "Body" because it is does not reflect the variable names as defined in the codebook of the source data ("features_info.txt").
```
    newLabels = gsub("BodyBody","Body", nn3)
```
    
Update labels of the main dataframe and load the completed tidy data set to 'tidy1' as the first output of the exercise:
```
    colnames(results2) = newLabels
    tidy1 = results2
```
_Note that it is NOT essential to use another dataframe (**tidy1**) but it is added here to make it easier to identify the outputs of the script._


Labels and the extracted tidy dataset can be checked with the scripts below, 
and also, writing the main tidy dataset to the working directory as "alldata.txt" can be a source for manual checing of the aggregations in the next task.
```
    nn0; nn1; nn2; newLabels;
    View(tidy1);
    write.table(tidy1,"alldata.txt",sep=",",row.names=FALSE)
```


# Task 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Create the second dataset with the averages per measurement
```
    tidy2 = ddply(tidy1, .(Subject,ActivityNames), numcolwise(mean))
```

Note that the example for the correct use _ddply_ with _numcolwise_ is from:
https://stat.ethz.ch/pipermail/r-help/2011-May/277800.html


Update the labels to reflect the content
```
    nn4 = names(tidy2)
    newLabels5 = gsub("^Time","Avg.Time", gsub("^Freq","Avg.Freq", nn4))
    colnames(tidy2) = newLabels5
```
        
To spot-check or grid view the aggregated data use:
```
    tidy2[1:40,1:10]
    View(tidy2)
```
This data set containd 180 rows of 81 (2 + 79) variables.

   
Write the dataset with the averages to the working directory as "averages.txt":
```
    write.table(tidy2,"averages.txt",sep=",",row.names=FALSE)
```

And finally, to re-test the exported data or to see the location of the exported file use:
```
    ReadBackTidy2 = read.table("./averages.txt", sep=",", head=TRUE)
    View(ReadBackTidy2)
```
or
```
    getwd()
```
    
# End-of-File     
