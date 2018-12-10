rankhospital <- function(state, outcome, num) {
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
        
        outcome<-"pneumonia"
        
        outcome <- if (outcome == "heart attack"){
                colnames(outcome_merged[8])
                
                }else if (outcome=="heart failure"){
                colnames(outcome_merged[9])
                        
                }else if (outcome=="pneumonia"){
                colnames(outcome_merged[10])
                 
                }
        
   
        
        
        outcome_perstate1<-outcome_merged%>%filter(outcome_merged$State==state)
        countrows<-as.numeric(length(outcome_perstate1$State))
        
        outcome_perstate2 <- outcome_perstate1%>%
                select(State, hospital, outcome)
        
        outcome_perstate2 <- outcome_perstate2[order(outcome_perstate2[,3], outcome_perstate2$hospital),]
        
        outcome_perstate2 <- outcome_perstate2 %>%
                mutate(rank_hosp= seq(1, countrows, 1))
        
                
                
      num <- if (num=="best"){
              min(outcome_perstate2$rank_hosp)
      }else if (num=="worst"){
              max(outcome_perstate2$rank_hosp)
      }else if (num>max(outcome_perstate2$rank_hosp) | num<min(outcome_perstate2$rank_hosp)){
              NA
      }else if (num <max(outcome_perstate2$rank_hosp) | num>min(outcome_perstate2$rank_hosp)){
              num
        }
    

     
      
      return(as.character(outcome_perstate2[num,2])) 
      
}
