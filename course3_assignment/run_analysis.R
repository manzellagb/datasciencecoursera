library(knitr)
library(dplyr)
library(rmarkdown)
library(tidyr)

trainset<-read.table("./train/X_train.txt", header=FALSE, sep="") #train set with
#561 variables, mostly statistical calculations, mean and std are columns 
trainsetlabel<-read.table("./train/y_train.txt", header=FALSE, sep="") 
#each of the numbers indicates an acitivity listed in activity_labels.txt
activity_labels<-read.table("./activity_labels.txt", header=FALSE, sep=" ")
#change trainsetlabel to be levels 
trainsetlabel$V1<-factor(trainsetlabel$V1,
                         as.vector(activity_labels$V2),
                         as.vector(activity_labels$V1))

#import test set and test set labels 
testset<-read.table("./test/X_test.txt", header=FALSE, sep="") #train set with
testsetlabel<-read.table("./test/y_test.txt", header=FALSE, sep="") 
testsetlabel$V1<-factor(testsetlabel$V1,
                         as.vector(activity_labels$V2),
                         as.vector(activity_labels$V1))

#import features 
features<-read.table("./features.txt", header=FALSE, sep="") #train set with

#add column names to each of the test and training sets using features 
colnames(trainset)<-as.vector(as.character(features$V2))
colnames(testset)<-as.vector(as.character(features$V2))

#bind the factors to each of the data sets so we know what activity are 
#they performing but first change the name of the label df
colnames(trainsetlabel)<-c("activity")
colnames(testsetlabel)<-c("activity")
trainset<-cbind(trainset,trainsetlabel)
testset<-cbind(testset, testsetlabel)

#now that both sets have the column names we can merge them together into one
#dataset 
fulldt<-rbind(trainset, testset)
#remove other variables that arent being used anymore 
rm(trainset, trainsetlabel, testset, testsetlabel, features)
#now we want to pick only the mean and std from the column names
subsetdt<-fulldt[,grepl("mean", colnames(fulldt)) | grepl("std", colnames(fulldt))
                 | grepl("^activity$", colnames(fulldt))]


#using subsetdt to find the mean for every activity 
library(reshape2)
finaldt<-subsetdt%>%
        group_by(activity)%>%
        summarise_all("mean")
colnames(finaldt)<-gsub("-", "", colnames(finaldt))
colnames(finaldt)<-gsub("()", "", colnames(finaldt))

colnames(finaldt)<-tolower(colnames(finaldt))
