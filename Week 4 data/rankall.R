rankall <- function(outcome, num = "best") {
        
        library(dplyr)
        library(tidyr)
        library(tibble)
        
        ## Read outcome data
        outcome_raw <- read.csv("outcome-of-care-measures.csv", header = TRUE,
                                na.strings = "Not Available", stringsAsFactors = FALSE)
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
        outcome_perstate2 <- outcome_perstate2[order(outcome_perstate2[,3], 
                                                     outcome_perstate2$hospital),]
        outcome_perstate2<-outcome_perstate2%>%
                group_by(State)%>%
                arrange(State)%>%
                mutate(rank_hosp=seq(1, length(State), 1))
        
 
        
        
         num <- if (num=="best"){
                1
        }else if (num=="worst"){
                num
        }else if (num>max(outcome_perstate2$rank_hosp) | num<min(outcome_perstate2$rank_hosp)){
                NA
        }else if (num <max(outcome_perstate2$rank_hosp) | num>min(outcome_perstate2$rank_hosp)){
                num
        }
        
        
       
        
        outcome_perstate2<-as.data.frame(outcome_perstate2)%>%ungroup()
     
      
        vector_list<-list()
        
if (num!="worst"){   
        
                for (i in as.character(unique(outcome_perstate2$State))){
          
                
                        if (length(outcome_perstate2$State[outcome_perstate2$State==i])< num){
                       
                                my_vector<-(c(i, NA, NA, num))
                                my_vector<-as.data.frame(my_vector, stringsAsFactors=FALSE)
                        
                       
                        
                                vector_list<-append(vector_list, my_vector)
                        }
                      
                }
  
        if (length(vector_list)>0){
                
        names(vector_list)<-seq(1:length(vector_list))
        df_nas<-as.data.frame(do.call(rbind, vector_list))
        colnames(df_nas)<-c("State", "hospital", outcome,
                                            "rank_hosp")
        
        
        
        final_outcome<-rbind(outcome_perstate2, df_nas)
        final_outcome<-final_outcome%>%
                arrange(State)

        
        answer<-final_outcome%>%
                filter(rank_hosp==num | is.na(hospital))%>%
                
                select(-outcome, -rank_hosp)
        
        }else{
                
        answer<-outcome_perstate2%>%
                arrange(State)%>%
                filter(rank_hosp==num | is.na(hospital))%>%
                select(-outcome, -rank_hosp)        
        }
        
        return(answer)           
        

}else{        
     answer<-outcome_perstate2%>%
             group_by(State)%>%
             arrange(State)%>%
             na.omit()%>%
             filter(rank_hosp==max(rank_hosp))%>%
             select(-outcome, -rank_hosp) 
     
     return(answer)
}
        
}
                
      
          
      
