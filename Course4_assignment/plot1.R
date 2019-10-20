library(dplyr)

dados<-readRDS("C:/Users/gabri/Documents/Course4Data/summarySCC_PM25.rds")

dados%>%
        group_by(year)%>%
        summarise(total_per_yer=sum(Emissions))->dadosnew

png("./Course4_assignment/plot1.png")
plot(dadosnew$year, dadosnew$total_per_yer, pch=20,
            xlab="Year", ylab="Total emmissions per year", col="coral2",cex=2)

dev.off()