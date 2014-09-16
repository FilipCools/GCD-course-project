---
title: "README"
author: "FilipCools"
date: "Monday, September 15, 2014"
output: html_document
---
This is my solution for the Getting and Cleaning Data course project of the Coursera John Hopkins Specialization on Data Analysis.  

There is only one R-script included called run_analysis.R. Please write source("run_analysis.R") in your R console to use this script. Running this script will automatically give you some data objects (you don't need to use any function for this). The most important objects are: data, subdata and averagedata. For more information about what the script precisely does and what these objects are, please read the CodeBook.md file (or the comments in the R-script).

Two remarks:
* Make sure that the plyr package is already installed. Otherwise, write the commando install.packages("plyr") before you run the R-script. 
* If you have already downloaded the zip-file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, then renaming it to projectData.zip will prevent the R-script to download it once more.