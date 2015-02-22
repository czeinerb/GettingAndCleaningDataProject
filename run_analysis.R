# title          : "Getting and Cleaning Data - Course Project"
# author         : "Bela Czeiner"
# date completed : "Saturday, February 21, 2015"

# Initialisation
## Init 1: Load required libraries
    library(data.table)
    library(plyr)

## Init 2: Download the zip file and extract the contents to the working directory
##         If necessary..
    ### zipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    ### download.file(zipUrl,dest="dataset.zip", mode = "wb") 
    ### unzip ("dataset.zip",exdir = ".")
    
# Task 1: Merge the training and the test sets to create one data set:
    ## Read data TRAINING and TEST files
    trainSubj = read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", head=FALSE)
    trainActiv = read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", head=FALSE)
    trainDetails = read.csv("./UCI HAR Dataset/train/x_train.txt", sep="", head=FALSE)
    testSubj = read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", head=FALSE)
    testActiv = read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", head=FALSE)
    testDetails = read.csv("./UCI HAR Dataset/test/x_test.txt", sep="", head=FALSE)
    
    ## Combine training and test data per type:
    Subj = rbind(trainSubj, testSubj)
    Activ = rbind(trainActiv, testActiv)
    Details = rbind(trainDetails, testDetails)
    
    ## Combine the three set of data into one:
    theLot = cbind(Subj, Activ, Details)
    
    ## Sort out the column labes:
    testLabels = read.csv("./UCI HAR Dataset/features.txt", sep="", head=FALSE)
    myLabels = c("Subject","Activity", as.character(testLabels[,2]))
    colnames(theLot) = myLabels
    
# Task 2: Extract only the measurements on the mean and standard deviation for each measurement:

    ## Create a vector of all column labels
    xLab = as.character(testLabels[,2])
    
    ## List column numbers of all lables with means and averages
    ColMean = grep("mean()",xLab)
    ColStd = grep("std()",xLab)
    
    ## Combine them together and set to accending order 
    ColMeanAndStd = c(ColMean, ColStd)
    ColMeanAndStd = sort(ColMeanAndStd)
    
    ## Shift to the right by two, 
    ##  as the aggregated dataframe has two extra colums at the front
    ColMeanAndStd = ColMeanAndStd + 2
    
    ## Add the first two columns
    ColMeanAndStd = c(c(1,2), ColMeanAndStd)
    
    ## Finally use it to create new df with only the required columns!
    results0 = theLot[,ColMeanAndStd[1:81]]
    
# Task 3: Uses descriptive activity names to name the activities in the data set:

    ## read activity names
    ActivityNames = read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", head=FALSE)
    colnames(ActivityNames) = c("Activity","ActivityNames")

    ## and merge it with the main dataframe
    ##   also change the order of columns to make it more readable
    results1 = merge(x = results0, y = ActivityNames, by = "Activity", all.x=TRUE)
    results2 = results1[c(2,82,3:81)]

# Task 4: Appropriately label the data set with descriptive variable names: 

    ## First read the names to a vecor, then perform the clean up,
    ## and eventually write it back to the df.
    ## Note that as 't' and 'f' prefixes are denoting time and frequency 
    ## they are replaced with 'Time' and 'Freq' in the variable names 
    ## as an example to make it more descriptive

    nn0 = names(results2)
    nn1 = gsub("\\.{3}|\\.{2}",".",make.names(nn0, unique = TRUE))
    nn2 = gsub("\\.$","", nn1)
    nn3 = gsub("^t","Time", gsub("^f","Freq", nn2))

    ## Correct variable names containing "BodyBody" to "Body",
    newLabels = gsub("BodyBody","Body", nn3)

    ## Update labels of the main dataframe.
    ## and load the completed tidy data set to 'tidy1' as the first output of the exercise:
    colnames(results2) = newLabels
    tidy1 = results2
    
    
# Task 5: From the data set in step 4, create a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.

    ## Create the second, aggregated tidy data set
    tidy2 = ddply(tidy1, .(Subject,ActivityNames), numcolwise(mean))

    ## Update the labels to reflect the content
    nn4 = names(tidy2)
    newLabels5 = gsub("^Time","Avg.Time", gsub("^Freq","Avg.Freq", nn4))
    colnames(tidy2) = newLabels5
        
    ## Write the dataset with the averages to the working directory as "averages.txt"
    write.table(tidy2,"averages.txt",sep=",",row.names=FALSE)
    
    ## Show the location of the exported file
    getwd()
    
# End-of-File    

