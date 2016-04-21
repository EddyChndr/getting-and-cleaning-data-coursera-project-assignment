# Getting and Cleaning Data - Project Assignment
The R script, run_analysis.R, does the following:
  
1.  Download and unzip the file if it doesn't exist.
2.  Load features.txt and activity_labels.txt into table.
3.  Filter the variables from features which only contain mean and standard deviation.
4.  Replace "-()" with blank.
5.  Load the test data based on the filtered variables.
6.  Load the train data based on the filtered variables.
7.  Merge test and train data and name the columns.
8.  Convert Subject and Activity into factor because they're categorical variables
9.  Create independent tidy data set with the average of each variable for each activity and each subject.
10. Melt data into long data
11. Average and widen the data
12. Create new text file (tidy.txt) for the new tidied data.
