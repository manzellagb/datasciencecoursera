library(dplyr)
library(ggplot2)
dados<-readRDS("C:/Users/gabri/Documents/Course4Data/summarySCC_PM25.rds")
scc<-readRDS("C:/Users/gabri/Documents/Course4Data/Source_Classification_Code.rds")

fulldata<-merge(dados, scc, by=c("SCC"))

fulldata<-fulldata[,1:8]
fulldata[,7]<-NULL

newdata<-as.data.frame(subset(fulldata,grepl("Coal", 
                                fulldata$Short.Name)==TRUE))

newdata%>%
        group_by(year)%>%
        summarise(total_emissions=sum(Emissions, na.rm = TRUE))->plotthis

plot4<-ggplot(plotthis, aes(year, total_emissions))+
        geom_point()+
        xlab("Year")+
        ylab("Total mother vehicle related emissions per year in Baltimore city")


ggsave(plot4,file="plot4.png",width=10,height=5)
        