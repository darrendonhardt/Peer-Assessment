# Author comment ---------------------------------------------------------------
# created by: Darren Donhardt
# create date: 19 Apr 2014
# modified date: 19 Apr 2014
# style guide: Google R Style Guide (refer below)
#   http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml


# Purpose of program -----------------------------------------------------------
# The intent of this program is produce two "tidy data sets" by loading and 
# cleaning data from "UCI Machine Learning website. See address below
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using
#   +Smartphones
# As required for Coursera "Getting and Cleansing Data" course peer assessment.
#
# note: Errors are generated on the aggregate function for the non integer/
# numeric column of activity name label.


# Get dataset ------------------------------------------------------------------
# url = paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2",
#  "FUCI%20HAR%20Dataset.zip")
# download.file(url = url, destfile = "./Dataset.zip", method = "auto")


# Source statements ------------------------------------------------------------
# None required to source


# Library statements -----------------------------------------------------------
# None required to load

# Create Features Table --------------------------------------------------------

# Load features table
filename = "./UCI HAR Dataset/features.txt"
feature.list <- read.table(filename, col.names = c("feature.id","feature.name"))


# Create Activity Table --------------------------------------------------------

# Load activity table
filename = "./UCI HAR Dataset/activity_labels.txt"
activity.list <- read.table(filename, col.names = c("activity.code"
                                                    ,"activity.name"))


# Create Test Results Tables ---------------------------------------------------

# Load test subject file
filename <- "./UCI HAR Dataset/test/subject_test.txt"
test.subject <- read.table(filename,header=FALSE,col.names="subject.code")

# load test results data file
filename <- "./UCI HAR Dataset/test/x_test.txt"
initial <- read.table(filename, nrows = 100)
classes <- sapply(initial,class)
results.test.data <- read.table(filename, colClasses = classes)

# load test results activity file
filename <- "./UCI HAR Dataset/test/y_test.txt"
test.results.activity.code <- read.table(filename,header=FALSE,
                                       col.names="activity.code")

# make the results data.frame column labels meaningful
colnames(results.test.data) <- feature.list$feature.name


# add activity codes to train results
results.test <- data.frame(type="train",
                           test.subject, 
                           test.results.activity.code, 
                           results.test.data,
                           check.names=FALSE)



# Create Train Results Tables --------------------------------------------------

# Load train subject file
filename <- "./UCI HAR Dataset/train/subject_train.txt"
train.subject <- read.table(filename,header=FALSE,col.names="subject.code")

# load train results data from file
filename = "./UCI HAR Dataset/train/x_train.txt"
initial <- read.table(filename, nrows = 100)
classes <- sapply(initial,class)
results.train.data <- read.table(filename, colClasses = classes)

# load train results activity file
filename <- "./UCI HAR Dataset/train/y_train.txt"
results.train.labels <- read.table(filename,header=FALSE, 
                                   col.names="activity.code")

# make the results data.frame column labels meaningful
colnames(results.train.data) <- feature.list$feature.name

# add activity codes to train results
results.train <- data.frame(type="train",
                            train.subject, 
                            results.train.labels, 
                            results.train.data, 
                            check.names=FALSE)


# Append test results to train results -----------------------------------------
# also add activity name labels

# append train results to test results
results.base <- rbind(results.test, results.train)


# get full list of subject.code and activity.code for all rows
results.row.labels <- results.base[,c(1:3)]

# update activity labels to results.row.labels
results.row.labels$activity.name <- activity.list[match(
                results.row.labels$activity.code 
                ,activity.list$activity.code), 
        'activity.name']

# generate final result data set
results.final <- data.frame(type = results.row.labels$type,
                            subject.code=results.row.labels$subject.code,
                            activity.name=results.row.labels$activity.name,
                            results.base[,3:ncol(results.base)],
                            check.names=FALSE)



# Extract only measurements for mean and std dev -------------------------------

# Identify columns in results where feature like "mean" or "std" deviation.
feature.stdmean <- grep("-mean\\(\\)|-std\\(\\)",colnames(results.final),
                        fixed=FALSE)
col.list <- c(which(colnames(results.final)=="subject.code"),
              which(colnames(results.final)=="activity.name"),
              feature.stdmean)

# create data.frame using previous results.final for above specified columns
results.stdmean <- results.final[,col.list]


# get mean of each variable for each subject / activity combination ------------

aggdata <- aggregate(results.stdmean,
                     by = list(results.stdmean$subject.code,
                               results.stdmean$activity.name),
                     FUN = mean,
                     na.rm = TRUE)

# rename group columns to something readable
names(aggdata)[names(aggdata)=="Group.1"] <- "subject.code.group"
names(aggdata)[names(aggdata)=="Group.2"] <- "activity.name.group"

# change order of data set by subject then activity
results.agg <- aggdata[order(aggdata$subject.code.group,
                         aggdata$activity.name.group),]

# write table to dput and csv
dput(results.agg, file="tidy_data_dput_dataset.R")
write.csv(results.agg, file = "tidy_data_csv.csv")