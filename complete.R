library(tidyr)
library(dplyr)

complete<-function(directory, id=1:332){
        massivedf<-data.frame()
  
  for (i in id) {
        
        file1 <- paste(directory, "/", 
                             formatC(i, width = 3, flag = "0"), ".csv", sep="")
        readfile1<-read.csv(file1)
        
        massivedf<-rbind.data.frame(massivedf,readfile1)
        massivedf<-na.omit(massivedf)
        
        

        #sortedData = c(sortedData, thisFileRead[[pollutant]])
}

        newdf<-massivedf%>%
                group_by(ID)%>%
                summarise(nobs=n())
                return(newdf)
     
}
        