# CODE BOOK


**Variables**
* `features.list` - data.frame that stores the imported file relating to all features or measurements made surrounding the original experiement
* `activity.list` - data.frame that stores the list of activities. Activity code and name.

_Test Results_
* `results.test.data` - data.frame that stores the experiment results for the "test" set used for the machine learning exercise. Each row identifies the measurements made for each window sample. This data does not identify the activity nor the subject involved for each window sample.
* `results.test.subject` - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* `results.test.activity` - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
# `results.test` - data.frame that joins the results.test.data, results.test.subject and results.test.activity data.frames together. The end result is a data.frame that identifies for each row an experiment window: subject.code, activity.code, and related measurements. It also has a "type" column which identifies this as being "test" data.

_Train results_
* `results.train.data` - data.frame that stores the experiment results for the "train" set used for the machine learning exercise. Each row identifies the measurements made for each window sample. This data does not identify the activity nor the subject involved for each window sample.
* `results.test.subject` - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* `results.test.activity` - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* `results.train` - data.frame that joins the results.train.data, results.train.subject and results.train.activity data.frames together. The end result is a data.frame that identifies for each row an experiment window: subject.code, activity.code, and related measurements. It also has a "type" column which identifies this as being "train" data.
* `results.base` - data.frame that consolidates or merges the two separate data sets for test and train. Equal to results.test + results.train.
* results.row.labels - contains the labels surrounding subject, activity and type
* results.final - data.frame that consolidates or merges the results.row.labels to the measurements columns only of results.base
* feature.stdmean - contains, by way of grep, the positions of those features or measurement columns relating to standard deviation or mean. This is identified by way of the feature label containing either "-mean()" or "-std()". It does not take into account any other measurements that contain wording such as "...meanFreq.."
* col.list - list of feature labels as identified by the positions mentioned in feature.stdmean. List of feature labels relating to measurements that have standard deviation or mean pre-processing.
* aggdata - aggregation of results.stdmean by subject and activity. This shows 180 combinations based on the existing data set.

**Data**

The source data is comprised of essentially 2 areas:

_Metadata (labels)_
* activity_labels.txt - describe the activities in terms of labels rather than codes.
* features.txt - describes the features in terms of labels rather than codes.
* features_info.txt - describes the feature content / selection. This was not used by the R script.

_Data_
The Data area is further broken down into "train" and "test" data sets. I explain the test data set, which applies equally to the "train" data set
* X_test.txt - file containing the measurements for each experiment window sample. In test there are 2947 samples, in train there are 7352 samples.
* Y_test.txt - file containing the activity codes relating to each experiment window sample.
* subject_test.txt - file containing the subject codes relating to each experiment window sample.


**Transforms**

The transforms are as follows:

1. Load features.txt into `feature.list`
2. Load activity_labels.txt into `activity.list`
3. Load data from X_test.txt to `results.test.data`
4. Load data from y_test.txt to `results.test.activity`
5. Replaced the feature column labels of `results.test.data` with the labels found in `feature.list`
6. Created new data frame called `results.test`. Load test data, activity code and subject code to this new data frame . Also added to this data frame a column labelled "Type" which identifies whether the data is from the "test" or "train" data sets.
7. Repeat steps 3 to 6, however this is for the "Train" data set.
8. Created new data frame called `results.base` which includes both the test and train data sets.
9. Added activity names or labels to the `results.base` data frame.
10. Generated a list of columns from the `results.base` data frame that related to "-std()" or "-mean()". This was done programmatically using regular expressions, rather than manually declaring them. These identified columns were stored in a data frame called `col.list`
11. Created a new data frame called `results.stdmean` that was filled using the `results.final` data frame with a selection of columns based on those identified in step 10 (`col.list`)
12. Aggregated the data frame `results.stdmean` using the `aggregate` function and performed a `mean` aggregation across the columns of `subject_code` and `activity_name`. Excluded NA results. Results were piped into a data frame called `results.agg`
13. Then renamed the resultant column names of `Group.1` and `Group.2` to `subject_code_group` and `activity_name_group` respectively.
14. Output the data frame `results.agg` to two separate files. 1st file is a CSV file called "tidy_data_csv.csv" and the 2nd file is a dput file called "tidy_data_dput_dataset.R"
