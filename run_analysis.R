############################################################################
##  run_analysis.R -- R script to clean and process data from data set
##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##  The processing is divided into 4 phases:
##    1. Processing the training data
##    2. Processing the test data
##    3. Merging the two and culling the columns that are not means or stds
##    4. Calculating the means of each variable remaining by each activity
##        and subject.
##  See readme for details.
############################################################################

############################################################################
# First do the Training Data
############################################################################

# Set up directories so that we can operate in any working directory
trainDir<-"./train"
testDir<-"./test"

# read in column headers
features<-read.table("features.txt")

#read in the training data
X_train<-read.table(paste(trainDir,"X_train.txt",sep="/"))

# Apply the names to training data
names(X_train)<-features$V2


# read in the subject column (codes 1-30 for each measurement)
subject_train<-read.table(paste(trainDir,"subject_train.txt",sep="/"))

# read in activity codes(1-6 for each measurement)
y_train<-read.table(paste(trainDir,"y_train.txt",sep="/"))

# read in the activity labels
act_labels<-read.table("activity_labels.txt")

# map activity codes to text (i.e. the labels)
# The Sapply function applies the mapping to each element of the
# vector using the anonymous function defined and assigned to FUN.
mapped<-sapply(X=y_train$V1,FUN=function(x,a){z<-a[x,2]},act_labels)

# build a data frame from the new columns (i.e. activity and subject_code)
activity_and_subjectcodes<-data.frame("activity"=mapped,"subject_code"=subject_train$V1)


# apply new columns to the training data by binding the columns together
X_train_transformed<-cbind(activity_and_subjectcodes,X_train)

############################################################################
# Then repeat the process for the test data
############################################################################

#read in the test data
X_test<-read.table(paste(testDir,"X_test.txt",sep="/"))

# Apply the names to test data
names(X_test)<-features$V2


# read in the subject column
subject_test<-read.table(paste(testDir,"subject_test.txt",sep="/"))

# read in activity codes
y_test<-read.table(paste(testDir,"y_test.txt",sep="/"))

# map them to text
mapped<-sapply(X=y_test$V1,FUN=function(x,a){z<-a[x,2]},act_labels)


# build a data frame from the new columns
activity_and_subjectcodes<-data.frame("activity"=mapped,"subject_code"=subject_test$V1)

# apply new rows to the training data
X_test_transformed<-cbind(activity_and_subjectcodes,X_test)

# merge the two sets (can't use merge because that would create NAs)
X_merged<-rbind(X_train_transformed,X_test_transformed)
# sort them by subject_code (this is a purely esthetic operation for ease of reading)
X_merged<-X_merged[order(X_merged$subject_code),]


# Grab only the columns we want (mean and std columns)
meanStdNameCols<-grep("mean|std",names(X_merged),ignore.case=T)

# union the two sets
desiredNameCols<-union(c(1,2),meanStdNameCols)

# remove all but the columns we want
X_culled<-X_merged[,desiredNameCols]

# Cleanup: Get rid of everything except the merged and culled data
#  IMPORTANT: This line is commented out because it is unfriendly to
#  to this in a script but if you need or want to work in a clean space
#  remove the comment line. 
#rm(list=setdiff(ls(),c("X_culled","X_merged")))

# Create the data frame with the mean by subject and activity
byList<-list(activity=X_culled$activity,subject_code=X_culled$subject_code)
X_agr<-aggregate(X_culled[,3:ncol(X_culled)],by=byList,FUN=mean)

#Rename the columns appropriately
xNames<-names(X_agr)
xNames[3:length(xNames)]<-paste("Avg(",names(X_agr[,3:ncol(X_agr)]),")",sep="")
names(X_agr)<-xNames

# Write the processed data 
write.table(file="X_culled.txt",X_culled)
write.table(file="X_merged.txt",X_merged)
write.table(file="X_agr.txt",X_agr)




