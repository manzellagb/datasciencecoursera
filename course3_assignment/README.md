Explanation of run\_analysis.R
============================

Importing the data
------------------

##### The data is divided into two parts, "train" and "test". The procedure is the same for both of them:

##### 1. Read the observations (X\_train.txt & X\_test.txt) files into R together with the set labels for each one (y\_train.txt & y\_test.txt). The set labels specify the activity that was done for each row of observations.

##### 2. Read the activity\_labels.txt file into R. This file specifies the what activity each number means.

##### 3. Transform the activity\_labels.txt from numeric to factor.

##### 4. Import feature labels which specifies the column names for X\_train.txt & X\_test.txt.

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

<table>
<caption>Activity labels</caption>
<thead>
<tr class="header">
<th align="right">V1</th>
<th align="left">V2</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">1</td>
<td align="left">WALKING</td>
</tr>
<tr class="even">
<td align="right">2</td>
<td align="left">WALKING_UPSTAIRS</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="left">WALKING_DOWNSTAIRS</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="left">SITTING</td>
</tr>
<tr class="odd">
<td align="right">5</td>
<td align="left">STANDING</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="left">LAYING</td>
</tr>
</tbody>
</table>

##### Each data set has 561 columns. The test set has 2947 rows and the train set has 7352 rows. Showing only the first 5 columns, this is what each set looks like:

<table>
<caption>Extract of test set from columns 1:5.</caption>
<thead>
<tr class="header">
<th align="right">V1</th>
<th align="right">V2</th>
<th align="right">V3</th>
<th align="right">V4</th>
<th align="right">V5</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">0.2571778</td>
<td align="right">-0.0232852</td>
<td align="right">-0.0146538</td>
<td align="right">-0.9384040</td>
<td align="right">-0.9200908</td>
</tr>
<tr class="even">
<td align="right">0.2860267</td>
<td align="right">-0.0131634</td>
<td align="right">-0.1190825</td>
<td align="right">-0.9754147</td>
<td align="right">-0.9674579</td>
</tr>
<tr class="odd">
<td align="right">0.2754848</td>
<td align="right">-0.0260504</td>
<td align="right">-0.1181517</td>
<td align="right">-0.9938190</td>
<td align="right">-0.9699255</td>
</tr>
<tr class="even">
<td align="right">0.2702982</td>
<td align="right">-0.0326139</td>
<td align="right">-0.1175202</td>
<td align="right">-0.9947428</td>
<td align="right">-0.9732676</td>
</tr>
<tr class="odd">
<td align="right">0.2748330</td>
<td align="right">-0.0278478</td>
<td align="right">-0.1295272</td>
<td align="right">-0.9938525</td>
<td align="right">-0.9674455</td>
</tr>
<tr class="even">
<td align="right">0.2792200</td>
<td align="right">-0.0186204</td>
<td align="right">-0.1139020</td>
<td align="right">-0.9944552</td>
<td align="right">-0.9704169</td>
</tr>
</tbody>
</table>

<table>
<caption>Extract of train set from columns 1:5.</caption>
<thead>
<tr class="header">
<th align="right">V1</th>
<th align="right">V2</th>
<th align="right">V3</th>
<th align="right">V4</th>
<th align="right">V5</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">0.2885845</td>
<td align="right">-0.0202942</td>
<td align="right">-0.1329051</td>
<td align="right">-0.9952786</td>
<td align="right">-0.9831106</td>
</tr>
<tr class="even">
<td align="right">0.2784188</td>
<td align="right">-0.0164106</td>
<td align="right">-0.1235202</td>
<td align="right">-0.9982453</td>
<td align="right">-0.9753002</td>
</tr>
<tr class="odd">
<td align="right">0.2796531</td>
<td align="right">-0.0194672</td>
<td align="right">-0.1134617</td>
<td align="right">-0.9953796</td>
<td align="right">-0.9671870</td>
</tr>
<tr class="even">
<td align="right">0.2791739</td>
<td align="right">-0.0262006</td>
<td align="right">-0.1232826</td>
<td align="right">-0.9960915</td>
<td align="right">-0.9834027</td>
</tr>
<tr class="odd">
<td align="right">0.2766288</td>
<td align="right">-0.0165697</td>
<td align="right">-0.1153618</td>
<td align="right">-0.9981386</td>
<td align="right">-0.9808173</td>
</tr>
<tr class="even">
<td align="right">0.2771988</td>
<td align="right">-0.0100978</td>
<td align="right">-0.1051372</td>
<td align="right">-0.9973350</td>
<td align="right">-0.9904868</td>
</tr>
</tbody>
</table>

##### Import the features, which are the column names for both sets. Bind the activity labels to each set of data, each row specifies a set of variables for one of the 6 activities.

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

<table>
<caption>Extract of test set from columns 558 to 562.</caption>
<thead>
<tr class="header">
<th align="right">angle(tBodyGyroJerkMean,gravityMean)</th>
<th align="right">angle(X,gravityMean)</th>
<th align="right">angle(Y,gravityMean)</th>
<th align="right">angle(Z,gravityMean)</th>
<th align="left">activity</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">0.2711514</td>
<td align="right">-0.7200093</td>
<td align="right">0.2768010</td>
<td align="right">-0.0579783</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">0.9205932</td>
<td align="right">-0.6980908</td>
<td align="right">0.2813429</td>
<td align="right">-0.0838980</td>
<td align="left">5</td>
</tr>
<tr class="odd">
<td align="right">0.1450684</td>
<td align="right">-0.7027715</td>
<td align="right">0.2800830</td>
<td align="right">-0.0793462</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">0.2964071</td>
<td align="right">-0.6989538</td>
<td align="right">0.2841138</td>
<td align="right">-0.0771080</td>
<td align="left">5</td>
</tr>
<tr class="odd">
<td align="right">-0.1185447</td>
<td align="right">-0.6922450</td>
<td align="right">0.2907220</td>
<td align="right">-0.0738568</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">-0.0722164</td>
<td align="right">-0.6898161</td>
<td align="right">0.2948958</td>
<td align="right">-0.0684707</td>
<td align="left">5</td>
</tr>
</tbody>
</table>

<table>
<caption>Extract of train set from columns 558 to 562.</caption>
<thead>
<tr class="header">
<th align="right">angle(tBodyGyroJerkMean,gravityMean)</th>
<th align="right">angle(X,gravityMean)</th>
<th align="right">angle(Y,gravityMean)</th>
<th align="right">angle(Z,gravityMean)</th>
<th align="left">activity</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">-0.0184459</td>
<td align="right">-0.8412468</td>
<td align="right">0.1799406</td>
<td align="right">-0.0586269</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">0.7035106</td>
<td align="right">-0.8447876</td>
<td align="right">0.1802889</td>
<td align="right">-0.0543167</td>
<td align="left">5</td>
</tr>
<tr class="odd">
<td align="right">0.8085291</td>
<td align="right">-0.8489335</td>
<td align="right">0.1806373</td>
<td align="right">-0.0491178</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">-0.4853664</td>
<td align="right">-0.8486494</td>
<td align="right">0.1819348</td>
<td align="right">-0.0476632</td>
<td align="left">5</td>
</tr>
<tr class="odd">
<td align="right">-0.6159706</td>
<td align="right">-0.8478652</td>
<td align="right">0.1851512</td>
<td align="right">-0.0438923</td>
<td align="left">5</td>
</tr>
<tr class="even">
<td align="right">-0.3682240</td>
<td align="right">-0.8496316</td>
<td align="right">0.1848225</td>
<td align="right">-0.0421264</td>
<td align="left">5</td>
</tr>
</tbody>
</table>

Reshaping the data
------------------

##### Now that the activities are specified:

##### 1. Row bind both sets together to get the full dataset.

##### 2. Subset the full dataset based on the column names that contain the word "mean" or the word "std", this will filter out the other variables in which there is no interest.

    #now that both sets have the column names we can merge them together into one
    #dataset 
    fulldt<-rbind(trainset, testset)
    #remove other variables that arent being used anymore 
    rm(trainset, trainsetlabel, testset, testsetlabel, features)
    #now we want to pick only the mean and std from the column names
    subsetdt<-fulldt[,grepl("mean", colnames(fulldt)) | grepl("std", colnames(fulldt))
                     | grepl("^activity$", colnames(fulldt))]

Summarising
-----------

##### With the filtered data, it is possible to use dplyr to summarise it.

    #using subsetdt to find the mean for every activity 
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    finaldt<-subsetdt%>%
            group_by(activity)%>%
            summarise_all("mean")
    colnames(finaldt)<-tolower(colnames(finaldt))

<table>
<caption>Extract of final tidy dataset with 5 out of 80 columns</caption>
<thead>
<tr class="header">
<th align="left">activity</th>
<th align="right">tbodyacc-mean()-x</th>
<th align="right">tbodyacc-mean()-y</th>
<th align="right">tbodyacc-mean()-z</th>
<th align="right">tbodyacc-std()-x</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">1</td>
<td align="right">0.2763369</td>
<td align="right">-0.0179068</td>
<td align="right">-0.1088817</td>
<td align="right">-0.3146445</td>
</tr>
<tr class="even">
<td align="left">2</td>
<td align="right">0.2622946</td>
<td align="right">-0.0259233</td>
<td align="right">-0.1205379</td>
<td align="right">-0.2379897</td>
</tr>
<tr class="odd">
<td align="left">3</td>
<td align="right">0.2881372</td>
<td align="right">-0.0163119</td>
<td align="right">-0.1057616</td>
<td align="right">0.1007663</td>
</tr>
<tr class="even">
<td align="left">4</td>
<td align="right">0.2730596</td>
<td align="right">-0.0126896</td>
<td align="right">-0.1055170</td>
<td align="right">-0.9834462</td>
</tr>
<tr class="odd">
<td align="left">5</td>
<td align="right">0.2791535</td>
<td align="right">-0.0161519</td>
<td align="right">-0.1065869</td>
<td align="right">-0.9844347</td>
</tr>
<tr class="even">
<td align="left">6</td>
<td align="right">0.2686486</td>
<td align="right">-0.0183177</td>
<td align="right">-0.1074356</td>
<td align="right">-0.9609324</td>
</tr>
</tbody>
</table>
