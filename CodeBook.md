## Code Book

This code book will give insight into the data and processes used to create a tidy data set

### Overview

30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements.

### Files Used

* 'features.txt': 561 features of the data set which we will pull the mean and std from
* 'activity_labels.txt': The name labels for each of the 6 activities recorded

* 'x_test.txt': 2947 observations of the 561 features, for 9 of the 30 volunteers.
* 'y_test.txt': 2947 integers, denoting the ID of the activity related to each of the observations in `X_test.txt`.
* 'subject_test.txt': 2947 integers, denoting the ID of the volunteer related to each of the observations in `X_test.txt`.

* 'x_train.txt': 7352 observations of the 561 features, for 21 of the 30 volunteers.
* 'y_train.txt': 7352 integers, denoting the ID of the activity related to each of the observations in `X_train.txt`.
* 'subject_train.txt': 7352 integers, denoting the ID of the volunteer related to each of the observations in `X_train.txt`.

### processes
1. The appropriate pacages necessary to clean the data were uploaded. ('data.table' and 'reshape2')
2. The aboce data was read into the data frames, the appropriate column headings were added, and the test and train data were merged
3. The features were extracted out that contained 'mean' and 'std.
4. the activity column was converted from an interger to a factor using the appropriate activity labels
5. The 'tidy_data' data set was written as a '.txt' file for submission
