# merge multiple trend data into single data.frame 

mergetrend<-function(list.trend, plot=TRUE)
{
  KEYWORDS<-names(list.trend)
  
  #sequential merge 
  N <- 2
  M <- merge(list.trend[[1]],list.trend[[2]], by='week',suffixes=KEYWORDS[1:2]) 

  while (N < length(list.trend))
  {
    N<-N+1 # next index for merge 
    TMP<-merge(list.trend[[1]],list.trend[[N]], by='week',suffixes=KEYWORDS[c(1,N)])
    # merge them together, one by one 
        eval(parse(text=
                     sprintf('M<-cbind(M,%s=TMP[,3])', names(TMP)[3])
                     ))
  }
  
  # plot 
  if(plot)
  {
    require(ggplot2)
    require(reshape)
    DAT.PLOT<-melt(data=M,'week') 
    P<-ggplot(data=DAT.PLOT) + geom_line(aes(x=week,y=value,colour=variable,linetype=variable))  + ylab('Google trend index') + xlab(NULL)  
    print(P)
  }
  
  return(M)  
}

