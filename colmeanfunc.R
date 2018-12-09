colmean<-function(x, removeNA=TRUE){
        nc<-ncol(x)
        means<-vector()
        for (i in 1:nc){
                means[i]<-mean(x[,i], na.rm = removeNA)
        }
        means
}

