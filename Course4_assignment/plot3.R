library(dplyr)
library(ggplot2)
dados<-readRDS("C:/Users/gabri/Documents/Course4Data/summarySCC_PM25.rds")

dados%>%
        group_by(type,year)%>%
        summarise(total_per_year=sum(Emissions))->dadosnew


plot3<-ggplot(dadosnew, aes(year, total_per_year, col=type))+
        geom_point()+
        xlab("Year")+
        ylab("Total emissions per year")


ggsave(plot3,file="plot3.png",width=10,height=5)


