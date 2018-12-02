library(tidyr)
library(dplyr)

corr<-function(directory, threshold=0){
        massivedf<-data.frame()

        result<-as.numeric()
  
  for (i in 1:332) {
        
        file1 <- paste(directory, "/", 
                             formatC(i, width = 3, flag = "0"), ".csv", sep="")
        readfile1<-read.csv(file1)
        
        massivedf<-rbind.data.frame(massivedf,readfile1)
        massivedf<-na.omit(massivedf)
        
}

        newdf<-massivedf%>%
                group_by(ID)%>%
                summarise(nobs=n())%>%
                filter(nobs>=threshold)
        
        joined_df<-inner_join(massivedf, newdf)
        
        joined_df%>%group_by(ID)%>%
                summarise(correlation_btw_NS=cor(nitrate,sulfate))%>%select(-ID)->result
        
        
        return(result)
                        
}
