GettingAndCleaningData
======================

Course Material for Coursera Course in Getting and Cleaning Data
Processing of Dataset: 
“Human Activity Recognition Using Smartphones” (Version 1.0) for Statistical Analysis
=====================================================================================
Stephen Gardner
sg8427@att.com
=====================================================================================
The  dataset includes the following files:
- This 'README.txt'
- 'run_analysis.R': An R script that creates a “tidy” data set from the raw data provided at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and 
takes the value of all the mean or standard deviation measurements and averages them over each 
subject and each activity (note: the original data set had multiple readings for each <subject,activity> 
pair.)  
- 'Codebook.pdf': A description of the variables in each of the processed data sets.
- 'X_merged.txt': The original raw data set with the training and test data merged together and the 
variable names applied to the column header and the activity labels applied to the activity column.
- 'X_culled.txt': The merged data from X_merged culled to remove all variables/columns that do not 
contain either a standard deviation or a mean.
-X_agr.txt': The aggregated data set containing the value of all mean or standard deviation variables in 
the original tidy data set averaged over each activity and each subject. 
=====================================================================================
For any questions about the original (unprocessed) data set please refer to 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


