rankall <- function(outcome, num = "best") {
        
        library(dplyr)
        library(tidyr)
        library(tibble)
        ## Read outcome data
        outcome_raw <- read.csv("outcome-of-care-measures.csv", header = TRUE,
                                na.strings = "Not Available")
        outcome_rates<-grep("^Hospital.30.Day.Death..Mortality..Rates.from.", 
                            names(outcome_raw), value=TRUE)
        outcome_interm<-outcome_raw[,outcome_rates]
        outcome_data<-outcome_raw[,1:9]
        outcome_merged<-cbind(outcome_data,outcome_interm)
        outcome_merged[,4:5]<-NULL
        
        colnames(outcome_merged)<-c("provider_number", "hospital", "adress",
                                    "city", "State", "zip_code", "county_name", "heart attack", 
                                    "heart failure", "pneumonia")
        
      
        
        # if((outcome %in% c("heart attack", "heart failure",
        #                       "pneumonia")) == FALSE) {
        #         
        #       stop("invalid outcome")
        #         
        #         }
    
        
        outcome <- if (outcome == "heart attack"){
                colnames(outcome_merged[8])
                
        }else if (outcome=="heart failure"){
                colnames(outcome_merged[9])
                
        }else if (outcome=="pneumonia"){
                colnames(outcome_merged[10])
                
        }
        
        
        
        outcome_perstate2 <- outcome_merged%>%
                select(State, hospital, outcome)
        
        outcome_perstate2<-as.data.frame(outcome_perstate2)
        outcome_perstate2 <- outcome_perstate2[order(outcome_perstate2[,3], outcome_perstate2$hospital),]
        
        outcome_perstate2 <- outcome_perstate2 %>% group_by(State)%>%
                mutate(rank_hosp= seq(1, length(State), 1))%>%
                arrange(State)
        
   
        
        num <- if (num=="best"){
                min(outcome_perstate2$rank_hosp)
        }else if (num=="worst"){
                max(outcome_perstate2$rank_hosp)
        }else if (num>max(outcome_perstate2$rank_hosp) | num<min(outcome_perstate2$rank_hosp)){
                NA
        }else if (num <max(outcome_perstate2$rank_hosp) | num>min(outcome_perstate2$rank_hosp)){
                num
        }
        
        outcome_perstate2<-as.data.frame(outcome_perstate2)%>%ungroup()
     
                
        for (i in unique(outcome_perstate2$State)){
                
                if (length(outcome_perstate2$State[outcome_perstate2$State==i])< num){
                      outcome_perstate2<-add_row(outcome_perstate2, State=i, rank_hosp=NA, hospital=NA)
                        
                }
                
        }
        
        
        answer<-outcome_perstate2%>%group_by(State)%>%
                filter(rank_hosp==num | is.na(hospital))%>%
                
                select(-outcome, -rank_hosp)
        
        
        return(answer)
               
      
}