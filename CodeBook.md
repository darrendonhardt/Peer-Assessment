# CODE BOOK


**Variables**
* features.list - data.frame that stores the imported file relating to all features or measurements made surrounding the original experiement
* activity.list - data.frame that stores the list of activities. Activity code and name.

_Test Results_
* results.test.data - data.frame that stores the experiment results for the "test" set used for the machine learning exercise. Each row identifies the measurements made for each window sample. This data does not identify the activity nor the subject involved for each window sample.
* results.test.subject - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* results.test.activity - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
# results.test - data.frame that joins the results.test.data, results.test.subject and results.test.activity data.frames together. The end result is a data.frame that identifies for each row an experiment window: subject.code, activity.code, and related measurements. It also has a "type" column which identifies this as being "test" data.

_Train results_
* results.train.data - data.frame that stores the experiment results for the "train" set used for the machine learning exercise. Each row identifies the measurements made for each window sample. This data does not identify the activity nor the subject involved for each window sample.
* results.test.subject - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* results.test.activity - data.frame that stores the experiment results by subject. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Relates to the experiment results for the "test" set used for the machine learning exercise.
* results.train - data.frame that joins the results.train.data, results.train.subject and results.train.activity data.frames together. The end result is a data.frame that identifies for each row an experiment window: subject.code, activity.code, and related measurements. It also has a "type" column which identifies this as being "train" data.
* results.base - data.frame that consolidates or merges the two separate data sets for test and train. Equal to results.test + results.train.
* results.row.labels - contains the labels surrounding subject, activity and type
* results.final - data.frame that consolidates or merges the results.row.labels to the measurements columns only of results.base
* feature.stdmean - contains, by way of grep, the positions of those features or measurement columns relating to standard deviation or mean. This is identified by way of the feature label containing either "-mean()" or "-std()". It does not take into account any other measurements that contain wording such as "...meanFreq.."
* col.list - list of feature labels as identified by the positions mentioned in feature.stdmean. List of feature labels relating to measurements that have standard deviation or mean pre-processing.
* aggdata - aggregation of results.stdmean by subject and activity. This shows 180 combinations based on the existing data set.
**Data**




**Transforms**
