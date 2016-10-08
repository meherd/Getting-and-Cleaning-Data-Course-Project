
## Download and unzip the data files from
### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Read train data sets

### Read X_train.txt data into data table
dataFeaturesTrain <- read.table("~/UCI HAR Dataset/train/X_train.txt")
dim(dataFeaturesTrain)
head(dataFeaturesTrain,n=3)

## Read y_train.txt data into data table
trainactivity <- read.table("~/UCI HAR Dataset/train/y_train.txt")

## Read subject_train.txt file into data table
subjecttrain <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
names(subjecttrain)
dim(subjecttrain)
head(subjecttrain)

## Read test data sets

###Read X_test.txt into data table
dataFeaturesTest <- read.table("~/UCI HAR Dataset/test/X_test.txt")
dim(dataFeaturesTest)
head(dataFeaturesTest,n=3)

### Read y_test.txt into data table
testactivity <- read.table("~/UCI HAR Dataset/test/y_test.txt")
head(testactivity)
names(testactivity)
dim(testactivity)

### Read Subject_test.txt into data table
subjecttest <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
head(subjecttest)
names(subjecttest)
dim(subjecttest)


### Read features.txt file into data table
dataFeaturesNames <- read.table("~/UCI HAR Dataset/features.txt")
head(datafeatureNames )
names(datafeatureNames )
dim(datafeatureNames )

## Merge the training and test data tables by row 

### merge data subject_test and subject_train
dataSubject <- rbind(subjecttrain, subjecttest)
head(dataSubject)
dim(dataSubject)

### merge activity tables by row 
dataActivity<- rbind(trainactivity, testactivity)
head(dataActivity)
dim(dataActivity)

### merge test data and train data as dataFeatures. 

dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
head(dataFeatures)
dim(dataFeatures)

### set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
names(dataFeatures)<- dataFeaturesNames$V2

### merge columns to get the combined data 

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

head(dataCombine)


## Extracts only the measurements on the mean and standard deviation for each measurement
### Subset Name of Features by measurements on the mean and standard deviation

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
###Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
###Check the structures of the data frame Data
str(Data)

### Read descriptive activity names from “activity_labels.txt”

activityLabels <- read.table( "~/UCI HAR Dataset/activity_labels.txt",header = FALSE)

### update activity column in Data to descriptive activity names
Data$activity[Data$activity == 1]<- "WALKING"
Data$activity[Data$activity == 2]<-  "WALKING_UPSTAIRS"
Data$activity[Data$activity == 3]<- "WALKING_DOWNSTAIRS"
Data$activity[Data$activity == 4]<- "SITTING"
Data$activity[Data$activity == 5]<- "STANDING"
Data$activity[Data$activity == 6]<- "LAYING"

head(Data$activity,30)

##Appropriately labels the data set with descriptive variable names

###prefix t is replaced by time
###Acc is replaced by Accelerometer
###Gyro is replaced by Gyroscope
###prefix f is replaced by frequency
###Mag is replaced by Magnitude
###BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


##Create a tidy data set and ouput it
### tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 4.

library(plyr);
TidyData<-aggregate(. ~subject + activity, Data, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
## write tidy data to a file
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)



