#run-analysis.R

setwd("C:/Users/Paul/Desktop/R")
library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "instancia.zip"
if(!file.exists(file)){
	print("file does not exist, downloading now")
	download.file(url, file, method="curl")
}
datafolder <- "UCI HAR Dataset"
resultsfolder <- "results"
if(!file.exists(datafolder)){
	print("unzipping the file")
	unzip(file,list=FALSE, overwrite = TRUE)
} 
if(!file.exists(resultsfolder)){
	print("creating the results folder")
	dir.create(resultsfolder)
} 
gettables <- function (filename,cols = NULL){
	print(paste("Acquiring table:", filename))
	f <- paste(datafolder,filename,sep="/")
	data <- data.frame()
	if(is.null(cols)){
		data <- read.table(f,sep="",stringsAsFactors=F)
	} else {
		data <- read.table(f,sep="",stringsAsFactors=F, col.names= cols)
	}
	data
}
features <- gettables("features.txt")
getdata <- function(type, features){
	print(paste("Getting data", type))
	subject_data <- gettables(paste(type,"/","subject_",type,".txt",sep=""),"id")
	y_data <- gettables(paste(type,"/","y_",type,".txt",sep=""),"activity")
	x_data <- gettables(paste(type,"/","X_",type,".txt",sep=""),features$V2)
	return (cbind(subject_data,y_data,x_data))
}
test <- getdata("test", features)
train <- getdata("train", features)
saveresults <- function (data,name){
	print(paste("saving results", name))
	file <- paste(resultsfolder, "/", name,".csv" ,sep="")
	write.csv(data,file)
}

###
###

#Merge train and Test 
library(plyr)
data <- rbind(train, test)
data <- arrange(data, id)

#Extract mean and stdev
mean_and_std <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]
saveresults(mean_and_std,"mean_and_std")

#Name activities in data 
activity_labels <- gettables("activity_labels.txt")

#Label variables from above  
data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#Create tidy data set (new and independent) 
tidy_dataset <- ddply(mean_and_std, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
saveresults(tidy_dataset,"tidy_dataset")













