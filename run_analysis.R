zipfile <- "getdata-projectfiles-UCI HAR Dataset.zip"

## Download and unzip the file:
if (!file.exists(zipfile)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, destfile = zipfile)
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(zipfile) 
}

## Load features and activity labels
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features[,2] <- as.character(features[,2])

## Filter the variables from features which only contain mean and std
featuresdesired <- grep(".*mean.*|.*std.*", features[,2])
featuresdesirednames <- features[featuresdesired,2]

## Replace "-()" with blank
featuresdesirednames <- gsub('[-()]', '', featuresdesirednames)

## Load the test data 
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
testdata <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresdesired]
testlabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testdata <- cbind(subjecttest, testlabels, testdata)

## Load the train data
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresdesired]
trainlabels <- read.table("UCI HAR Dataset/train/y_train.txt")
traindata <- cbind(subjecttrain, trainlabels, traindata)

## Merge test and train data and name the columns
merged <- rbind(traindata, testdata)
names(merged) <- c("subject", "activity", featuresdesirednames)

## Convert Subject and Activity into factor because they're categorical variables
merged$subject <- as.factor(merged$subject)
merged$activity <- factor(merged$activity, levels = activitylabels[,1], labels = activitylabels[,2])

## Load the reshape2 package
library(reshape2)

## Create independent tidy data set with the average of each variable for each activity and each subject
## Melt data into long data
moltendata <- melt(merged, id = c("subject", "activity"))
## Average and widen the data
widendata <- dcast(moltendata, subject + activity ~ variable, mean)

## Create new text file for the new tidied data
write.table(widendata, "tidy.txt", row.names = FALSE, quote = FALSE)
