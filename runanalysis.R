#########################################################
#########################################################
#########################################################
#########################################################

#START run-analysis.R

#########################################################
#########################################################
#########################################################
#########################################################

setwd("C:/Users/Paul/Desktop/R")
library(httr) 

#get the data, create file folders
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "courseproject.zip"
#avoid redundant file folder names
if(!file.exists(file)){
	print("file does not exist, downloading now")
	download.file(url, file)
}
UCIdata <- "UCI HAR Dataset"
UCIresults <- "results"
#avoid redundant file folder names 
if(!file.exists(UCIdata)){
	print("No such file, unzipping the file now")
	unzip(file,list=FALSE, overwrite = TRUE)
} 
#avoid redundant file folder names
if(!file.exists(UCIresults)){
	print("creating the results folder")
	dir.create(UCIresults)
} 
#convert text to data frame 
make.table <- function(filename,cols = NULL){
	print(paste("Acquiring table:", filename))
	f <- paste(UCIdata,filename,sep="/")
	data <- data.frame()
	if(is.null(cols)){
		data <- read.table(f,sep="",stringsAsFactors=F)
	} else {
		data <- read.table(f,sep="",stringsAsFactors=F, col.names= cols)
	}
	data
}

features <- make.table("features.txt")

#read data by defining function 
getdata <- function(type, features){
	print(paste("Acquiring data for:", type))
	subject_data <- make.table(paste(type,"/","subject_",type,".txt",sep=""),"id")
	y_data <- make.table(paste(type,"/","y_",type,".txt",sep=""),"activity")
	x_data <- make.table(paste(type,"/","X_",type,".txt",sep=""),features$V2)
	return (cbind(subject_data,y_data,x_data))
}

test <- getdata("test", features)
train <- getdata("train", features)

results <- function (data,name){
	print(paste("saving results", name))
	file <- paste(UCIresults, "/", name,".csv" ,sep="")
	write.csv(data,file)
}

#########################################################
#########################################################
#########################################################
#########################################################

#Merge train and test with plyr package
library(plyr)
data <- rbind(train, test)
data <- arrange(data, id)

#Extract mean and stdev
#grep(pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE,
     #fixed = FALSE, useBytes = FALSE, invert = FALSE)
mean_and_std <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]
results(mean_and_std,"mean_and_std")

#Name activities in data 
activity_labels <- gettables("activity_labels.txt")

#Label variables from above  
data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#Create tidy data set (new and independent) 
tidy_dataset <- ddply(mean_and_std, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
results(tidy_dataset,"tidy_dataset")

#attempt at writing the csv files to txt files failed; simply opened csv and saved them as txt instead, then copy pasted into github 
setwd("C:/Users/Paul/Desktop/R/results")
#write.table(x, file = "", append = FALSE, quote = TRUE, sep = " ",
            #eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            #col.names = TRUE, qmethod = c("escape", "double"),
            #fileEncoding = "")
#write.table("mean_and_std.csv","mean_and_std.txt",row.name=FALSE)
#write.table("tidy_dataset.csv","tidy_dataset.txt",row.name=FALSE)

#reset working directory 
setwd("C:/Users/Paul/Desktop/R")

#########################################################
#########################################################
#########################################################
#########################################################

#END run-analysis.R

#########################################################
#########################################################
#########################################################
#########################################################



