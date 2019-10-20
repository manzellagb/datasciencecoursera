library(dplyr)

dados<-readRDS("C:/Users/gabri/Documents/Course4Data/summarySCC_PM25.rds")

dados%>%
        filter(fips=="24510")%>%
        group_by(year)%>%
        summarise(total_per_year=sum(Emissions))->dadosnew
        

png("./Course4_assignment/plot2.png")
plot(x=dadosnew$year, y=dadosnew$total_per_year, pch=20,
            xlab="Year", ylab="Total emmissions per year in Baltimore city", 
     col="coral2", cex=2)

dev.off()