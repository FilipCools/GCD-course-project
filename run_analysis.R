fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("projectData.zip")){download.file(fileUrl,destfile="projectData.zip")}

X_train<-read.table(unz("projectData.zip","UCI HAR Dataset/train/X_train.txt")) # > dim(X_train) [1] 7352 561
subject_train<-read.table(unz("projectData.zip","UCI HAR Dataset/train/subject_train.txt")) # > dim(subject_train) [1] 7352 1
y_train<-read.table(unz("projectData.zip","UCI HAR Dataset/train/y_train.txt")) # > dim(y_train) [1] 7352 1

X_test<-read.table(unz("projectData.zip","UCI HAR Dataset/test/X_test.txt")) # > dim(X_test) [1] 2947 561
subject_test<-read.table(unz("projectData.zip","UCI HAR Dataset/test/subject_test.txt")) # > dim(subject_test) [1] 2947 1
y_test<-read.table(unz("projectData.zip","UCI HAR Dataset/test/y_test.txt")) # > dim(y_test) [1] 2947 1

features<-read.table(unz("projectData.zip","UCI HAR Dataset/features.txt")) # > dim(features) [1] 561 2

activity_labels<-read.table(unz("projectData.zip","UCI HAR Dataset/activity_labels.txt"))
# 1 = WALKING, 2 = WALKING_UPSTAIRS, 3 = WALKING_DOWNSTAIRS, 4 = SITTING, 5 = STANDING, 6 = LAYING
# > dim(activity_labels) [1] 6 2

data<-rbind(cbind(X_train,subject_train,y_train),cbind(X_test,subject_test,y_test)) # > dim(data) [1] 10299 563
features$V2<-sapply(features$V2,as.character) # Transform variable names in features to character class.
variable_names<-c(features$V2,"Subject","Activity") # Make a vector containing all the variable names.
colnames(data)<-variable_names # The data table now has appropriate variable names.

subcolumns<-sort(union(grep("mean",variable_names),grep("std",variable_names)))
# The grep-command searches for a substring in a vector of strings and outputs where the substring has been found.
# So the subcolumns are all the columns where the corresponding variable name contains "mean" or "std".
subcolumns<-c(subcolumns,562,563) # We add the Subject and Activity row.
subdata<-data[,subcolumns] # >dim(subdata) [1] 10299 81
subdata$Activity<-activity_labels$V2[subdata$Activity] 
# The activity numbers are changed into the corresponding activity labels (obtained from features.txt).
# >dim(subdata) [1] 10299 81

library(plyr) # For the ddply command, we need the plyr R-package.
averagedata<-ddply(subdata,.(Subject,Activity), numcolwise(mean))
# For each combination of Subject (in {1,...,30}) and Activity (6 possibilities, e.g. WALKING), 
# we get the average of the mean and std variables.
# > dim(averagedata) [1] 180 81
# > head(names(averagedata)) 
# [1] "Subject" "Activity" "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X"
