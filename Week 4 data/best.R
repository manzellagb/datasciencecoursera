

best <- function(state, outcome) {
        library(dplyr)
        library(tidyr)
## Read outcome data
        outcome_raw <- read.csv("outcome-of-care-measures.csv", header = TRUE,
                                na.strings = "Not Available")
        outcome_rates<-grep("^Hospital.30.Day.Death..Mortality..Rates.from.", 
                            names(outcome_raw), value=TRUE)
        outcome_interm<-outcome_raw[,outcome_rates]
        outcome_data<-outcome_raw[,1:9]
        outcome_merged<-cbind(outcome_data,outcome_interm)
        outcome_merged[,4:5]<-NULL
        outcome_merged<-na.omit(outcome_merged)
        colnames(outcome_merged)<-c("provider_number", "hospital", "adress",
                        "city", "State", "zip_code", "county_name", "heart attack", 
                        "heart failure", "pneumonia")
        
        
        
        if(!any(state == outcome_merged$State)){
                
                stop("invalid state")}
        
        else if((outcome %in% c("heart attack", "heart failure",
                          "pneumonia")) == FALSE) {
                
                stop("invalid outcome")
                
        }
       
        outcome_perstate<-outcome_merged%>%filter(
                outcome_merged$State==state)
        
        minrow<-which(as.numeric(outcome_perstate[,outcome]) == 
                     min(as.numeric(outcome_perstate[,outcome]), na.rm = TRUE))
        
        
        hospitals1 <- as.character(outcome_perstate[minrow,2])
         
        return(hospitals1)
        
        
}
