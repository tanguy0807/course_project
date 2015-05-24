  setwd("C:/Users/Catherine/Desktop/R/getting_data")
  
  #getting the data if it had not been downloaded
  if(sum(grepl("dataset.zip",dir()))==0)
    {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "./dataset.zip")
    unzip("dataset.zip", exdir = ".")
    }
  
  #reading the training and testing X and y tables
  X_train = read.table("./UCI HAR Dataset/train/X_train.txt")
  X_test = read.table("./UCI HAR Dataset/test/X_test.txt")
  y_train = read.table("./UCI HAR Dataset/train/y_train.txt", colClasses = "factor")
  y_test = read.table("./UCI HAR Dataset/test/y_test.txt", colClasses = "factor")
  
  
  ############################# STEP 1 ##############################################
  #merging the training and testing tables in one table
  X <- rbind(X_train,X_test)
  y <- rbind(y_train, y_test)
  
  
  ############################# STEP 2 ##############################################
  #Extracting only the measurements on the mean and standard deviation for each measurement 
  features = read.table("./UCI HAR Dataset/features.txt", colClasses = "character")
  selection <- grepl("mean",features$V2) | grepl("std", features$V2)
  X <- X[,selection]
  
  ############################# STEP 3 ##############################################
  #using descriptive activity names
  activities = read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "factor")
  
  #install plyr and dplyr packages if not done with install.packages("name_of_package")
  library(plyr)
  library(dplyr)
  #mapping activites to the levels of y (a vector of characters must be given to the "from" and "to" arguments)
  y$V1 <- mapvalues(y$V1, from = levels(y$V1), to = as.character(activities$V2))
  y <- rename(y,activities = V1)
  
  ############################# STEP 4 ##############################################
  #using descriptive activity names
  names(X) <- features$V2[selection]
  
  ############################# STEP 5 ##############################################
  #calculating the mean of each feature for every subject and every activity per subject
  subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = "factor")
  subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = "factor")
  subject <- rbind(subject_train,subject_test)
  subject <- rename(subject, subject = V1)
  
  AllMerged <- cbind(subject, y, X)
  
  FinalTable <- aggregate(. ~ subject + activities, data = AllMerged, FUN = function(x) {mean(x)})
  
  ###################################################################################
  
  write.table(FinalTable, file="FinalTable.txt" , row.name=FALSE)
  
