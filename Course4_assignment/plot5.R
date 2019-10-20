library(dplyr)
library(ggplot2)
dados<-readRDS("C:/Users/gabri/Documents/Course4Data/summarySCC_PM25.rds")
scc<-readRDS("C:/Users/gabri/Documents/Course4Data/Source_Classification_Code.rds")

fulldata<-merge(dados, scc, by=c("SCC"))

fulldata<-fulldata[,1:8]
fulldata[,7]<-NULL

newdata<-as.data.frame(subset(fulldata,grepl("Highway", 
                                fulldata$Short.Name)==TRUE))

newdata%>%
        filter(fips=="24510")%>%
        group_by(year)%>%
        summarise(total_emissions=sum(Emissions, na.rm = TRUE))->plotthis

plot4<-ggplot(plotthis, aes(year, total_emissions))+
        geom_point()+
        xlab("Year")+
        ylab("Total Coal-related emissions per year")


ggsave(plot4,file="plot5.png",width=10,height=5)
        