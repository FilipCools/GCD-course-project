---
title: "CodeBook"
author: "FilipCools"
date: "Monday, September 15, 2014"
output: html_document
---
In the run_analysis.R script, the following objects are computed/made.

* data : this is a data.frame consisting of 10299 rows and 561 columns. It merges the training and test sets. More precisely, it is build up as follows.
  * The first 7352 rows of data corresponds to the training set. It is build up as follows.
    * The first 561 columns are taken from X_train.txt.
    * The column 562 contains the subject numbers (taken from subject_train.txt)
    * The last column 563 contains the activity numbers (taken from y_train.txt)
  * The last 2947 rows of data corresponds to the test set. It is build up as follows.
    * The first 561 columns are taken from X_test.txt.
    * The column 562 contains the subject numbers (taken from subject_test.txt)
    * The last column 563 contains the activity numbers (taken from y_test.txt)
  * The variable names for the first 561 columns are taken from features.txt; the last two variable names are "Subject"       and "Activity".
  * Overview of the transformations done to compute data: download the zip-file projectData.zip in working directory, read the tables from the needed txt-files, merge the tables together with rbind/cbind, add variable names

* subdata : this is a data.frame consisting of 10299 rows and 81 columns. This is a subframe of data, consisting of all the variables that contain info about the mean and std (and meanFreq), plus the subject numbers and activity labels.
  * The first 79 rows correspond to the variable names in features.txt that have a substring "mean" or "std". It could be that some of these rows not really represent a mean/std (in particular, the ones containing "meanFreq" as a substring), but I have included them anyway. 
  * Row 80 with variable name "Subject" corresponds to the subject numbers.
  * Row 81 with variable name "Activity" corresponds to the activity labels from activity\_labels.txt. Remark: this was not the case in the data object. The activity numbers and labels are related by 1 = WALKING, 2 = WALKING\_UPSTAIRS, 3 = WALKING_DOWNSTAIRS, 4 = SITTING, 5 = STANDING, 6 = LAYING.
  * Overview of the transformations done to compute subdata: search for variable names containing "mean" or "std" using the grep command, subset data by only considering these columns, change row with variable name activity such that it contains the labels instead of the numbers. 

* averagedata : this is a data.frame consisting of 180 rows and 81 columns. For each possible combination of activity (in {1,...,6}) and subject (6 possibilities, e.g. WALKING), the means of the variables that contain info about the mean and std are taken. 
  * The first row with variable name "Subject" corresponds to the subject number.
  * The second row with variable name "Activity" corresponds to the activity label (e.g. WALKING).
  * The rows 3 to 81 contain the means of the variables related to mean and std. 
  * Overview of the transformations done to compute averagedata: using the package plyr and the ddply command, take the means of the columns, for each combination of activity and subject.