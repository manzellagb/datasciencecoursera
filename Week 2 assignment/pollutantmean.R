#Write a function named 'pollutantmean' that calculates the mean of a pollutant 
#(sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' 
#takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 
#'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 
#''directory' argument and returns the mean of the pollutant across all of the monitors

pollutantmean<-function(directory, pollutant, id=1:332){
        massivedf<-data.frame()
  
  for (i in id) {
        
        file1 <- paste(directory, "/", 
                             formatC(i, width = 3, flag = "0"), ".csv", sep="")
        readfile1<-read.csv(file1)
        
        massivedf<-rbind.data.frame(massivedf,readfile1)
        massivedf<-na.omit(massivedf)

        
}

        mean2<-mean(massivedf[[pollutant]])  
        
        return(mean2)
     
}
        
