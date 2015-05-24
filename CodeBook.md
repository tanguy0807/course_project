# Code Book for the data processed in "project.R"

The project.R script manipulates data from the UCI Samsung Galaxy S smartphone dataset.
A compressed version of the dataset can be found at: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/ (for the purpose of the course, the dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The dataset contains a test set and a training set (respectively in the "test" and "train" folders), where activities have been measured for 30 individuals ("y_test.txt" and "y_train.txt" files in the "test" and "train" folders). A number of features have been measured for each activity and for each individual ("X_test.txt" and "X_train.txt" files). More information on these features can be found in the description files (see "features_info.txt" and "features.txt" files)

The "project.R" processes the data with the 5 following steps:
- step 1: the training and the test sets are merged to create one data set.
- step 2: measurements on the mean and standard deviation are extracted for each measurement. 
- step 3: descriptive activity are used to name the activities in the data set
- step 4: the data set is labeled with descriptive variable names. 
- step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Warning: you will have to change the working directory and install the packages used in "project.R" in order to run code.