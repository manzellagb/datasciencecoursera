---
title: "Run analysis script"
author: "Gabriela"
date: "7th Jan 2019"
output: html_document
---

#Codebook for run_analysis.R

##Importing the data

#####The data is divided into two parts, "train" and "test". The procedure is the same for both of them: 

#####1. Read the observations (X_train.txt & X_test.txt) files into R together with the set labels for each one (y_train.txt & y_test.txt). The set labels specify the activity that was done for each row of observations. 
#####2. Read the activity_labels.txt file into R. This file specifies the what activity each number means. 
#####3. Transform the activity_labels.txt from numeric to factor.
#####4. Import feature labels which specifies the column names for X_train.txt & X_test.txt. 


```{r}
setwd("C:/Users/gabri/Documents/datasciencecoursera/course3_assignment/UCI HAR Dataset")
trainset<-read.table("./train/X_train.txt", header=FALSE, sep="") #train set with
#561 variables, mostly statistical calculations, mean and std are columns 
trainsetlabel<-read.table("./train/y_train.txt", header=FALSE, sep="") 
#each of the numbers indicates an acitivity listed in activity_labels.txt
activity_labels<-read.table("./activity_labels.txt", header=FALSE, sep=" ")
#change trainsetlabel to be levels 
trainsetlabel$V1<-factor(trainsetlabel$V1)

#import test set and test set labels 
testset<-read.table("./test/X_test.txt", header=FALSE, sep="") #train set with
testsetlabel<-read.table("./test/y_test.txt", header=FALSE, sep="") 
testsetlabel$V1<-factor(testsetlabel$V1)

```
```{r echo=FALSE, results='asis'}
library(knitr)
kable(activity_labels, caption="Activity labels")
```

#####Each data set has 561 columns. The test set has 2947 rows and the train set has 7352 rows. Showing only the first 5 columns, this is what each set looks like:

```{r echo=FALSE, results='asis'}
library(knitr)
kable(head(testset[1:5]), caption="Extract of test set from columns 1:5.")
kable(head(trainset[1:5]), caption="Extract of train set from columns 1:5.")
```

#####Import the features, which are the column names for both sets. Bind the activity labels to each set of data, each row specifies a set of variables for one of the 6 activities. 


```{r}
#import features 
setwd("C:/Users/gabri/Documents/datasciencecoursera/course3_assignment/UCI HAR Dataset")

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

```
 
```{r echo=FALSE, results='asis'}
library(knitr)
kable(head(testset[558:562]), caption="Extract of test set from columns 558 to 562.")
kable(head(trainset[558:562]), caption="Extract of train set from columns 558 to 562.")
```

##Reshaping the data 

#####Now that the activities are specified:

#####1. Row bind both sets together to get the full dataset. 
#####2. Subset the full dataset based on the column names that contain the word "mean" or the word "std", this will filter out the other variables in which there is no interest. 

```{r}
#now that both sets have the column names we can merge them together into one
#dataset 
fulldt<-rbind(trainset, testset)
#remove other variables that arent being used anymore 
rm(trainset, trainsetlabel, testset, testsetlabel, features)
#now we want to pick only the mean and std from the column names
subsetdt<-fulldt[,grepl("mean", colnames(fulldt)) | grepl("std", colnames(fulldt))
                 | grepl("^activity$", colnames(fulldt))]
```

##Summarising

#####With the filtered data, it is possible to use dplyr to summarise it. 

```{r}
#using subsetdt to find the mean for every activity 
library(dplyr)
finaldt<-subsetdt%>%
        group_by(activity)%>%
        summarise_all("mean")
colnames(finaldt)<-tolower(colnames(finaldt))
```

```{r echo=FALSE, results='asis'}
library(knitr)
kable(head(finaldt[1:5]), caption="Extract of final tidy dataset with 5 out of 80 columns")

```
