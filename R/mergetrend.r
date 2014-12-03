# merge multiple trend data into single data.frame 

mergetrend<-function(list.trend, plot=TRUE)
{
  N <- length(list.trend)
  
  KEYWORDS<-names(list.trend)
  KEYWORDS<-gsub(' ','', KEYWORDS) # get rid of space for colname 
  
  M=NULL 
  
  #sequential merge 
  II=2
  message(sprintf('...merging KEYWORD[%s]',KEYWORDS[1]))
  while (II <= N )
  {
    message(sprintf('...merging KEYWORD[%s]',KEYWORDS[II]))
    if(is.null(M))
     M <- merge(list.trend[[1]],list.trend[[2]], by='week' ) else 
       M <- merge(M,list.trend[[II]], by='week', all.x = TRUE )
    
    II<-II+1 # next index for merge 
  }
   
  names(M) <- c('week', KEYWORDS) 
  
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

