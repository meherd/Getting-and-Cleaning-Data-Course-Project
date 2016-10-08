
## Getting and Cleaning Data Course Project

### Download the zip file and unzip it in the data folder

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Read data from the targeted files
1. Values of Varible Activity consist of data from Y_train.txtù and Y_test.txtù
2. Values of Variable Subject consist of data from subject_train.txtù and subject_test.txt
3. Values of Varible Features consist of data from X_train.txt and X_test.txt
4. Names of Varible Features come from features.txtù
5. levels of Variable Activity come from activity_labels.txt

## Read train data sets

### Read features data from X_train.txt data into data table
  dataFeaturesTrain 

### Read activity data from y_train.txt data into data table
  trainactivity 

### Read subject data subject_train.txt file into data table
  subjecttrain 

## Read test data sets into data tables

### Read features data from X_test.txt into data table   dataFeaturesTest 

### Read activity data from y_test.txt into data table
  testactivity <- read.table("/UCI HAR Dataset/test/y_test.txt")

### Read subject training datad from Subject_test.txt into data table subjecttest 

### Read features datad from features.txt into data table
  dataFeaturesNames 

## Merge the training and test data tables by row 

### merge data subject_test and subject_train
  dataSubject <- rbind(subjecttrain, subjecttest)

### merge activity tables by row 
  dataActivity<- rbind(trainactivity, testactivity)

### merge test data and train data as dataFeatures. Test
  dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

### set names to variables
  names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
names(dataFeatures)<- dataFeaturesNames$V2

### Merge columns to get the combine data 

  dataCombine <- cbind(dataSubject, dataActivity)
  Data <- cbind(dataFeatures, dataCombine)


## Extracts only the measurements on the mean and standard deviation for each measurement
### Subset Name of Features by measurements on the mean and standard deviation
  
###Subset the data frame Data by seleted names of Features 
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

### Read descriptive activity names from activity_labels.txt in  activityLabels 

### update activity column in Data to descriptive activity names

##Appropriately labels the data set with descriptive variable names

1. prefix t is replaced by time
2. Acc is replaced by Accelerometer
3. Gyro is replaced by Gyroscope
4. prefix f is replaced by frequency
5. Mag is replaced by Magnitude
6. BodyBody is replaced by Body

##Create a tidy data set 

###tidy data set will be created with the average of each variable for each activity and each subject 

##Write tidy data to a file
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)
