
## run_analysis.R ##
#places the folowing packages in your working directory before starting the code
#'features.txt', 'activity_labels.txt'
#'x-test.txt', 'y_test.txt', 
#'x_train.txt', 'y_train.txt', 
#'subject_test.txt', 'subject_train.txt'
#checks to see if the package is installed and installs it if it's not
if (!require(data.table)){
  install.packages("data.table")
}
if (!require(reshape2)){
  install.packages("reshape2")
}

require(data.table)
require(reshape2)

## test data ##
#reads in the data for the work out activity labels from the second column of the data
activityTable <- read.table("activity_labels.txt")[,2]

#downloads the labels for the matematical data that needs to be listed in the columns
features <- read.table("features.txt")[,2]

# seperates the information we want from the previuosly downloaded data set
#i.e. extracts the features
extractFeatures <- grepl("mean|std", features)

## downloads data from the test file(22:24) and names the columns for the 'x_test' data (25)
X_test <- read.table("x_test.txt")
Y_test <- read.table("y_test.txt")
subject_test <-read.table("subject_test.txt")
names(X_test) <- features

# parses the all the data from the x_test data set except for the mean and std data
X_test <- X_test[, extractFeatures]

## bind data ##
#places the data from the activityTabel object in the second column of 'y_test'
Y_test[,2] <- activityTable[Y_test[,1]]

# creates column names in the 'y_test' columns from a concatonated list
names(Y_test) <- c("Activity_ID", "Activity_Label")
# names column of the subjectdata
names(subject_test) <- "subject"

# binds the above objects in to one object as a data table
#data table is necessary for the '.txt' data type
test_data <- cbind(as.data.table(subject_test), Y_test, X_test)

### The previous is true for lines '48:63' except we are now tidying the the 'train' data

## train data ##
x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
names(x_train) <- features

x_train = x_train[, extractFeatures]

## Load Acitivity Data ##
y_train[,2] = activityTable[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

## Bind Data ##
train_data <- cbind(as.data.table(subject_train), x_train, y_train)

## MERGE TEST AND TRAIN DATA ##
# we now merge the two data tables we created ('test_data' and 'train_data')
data = rbind(test_data, train_data)

# setdiff finds variables that are in in one list but not in another
# this makes out dfs more efficent
id_labels <- c("subject", "Activity_ID","Activity_Label")
data_labels <- setdiff(colnames(data), id_labels)

# reshape the data down into a seperate, independent data set 
# with averages for each variable for each activity and subject
melt_data <- melt(data, id = id_labels, measure.vars = data_labels)
tidy_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)

# save the new tidy data table into your working directory as a '.txt' for submission
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
