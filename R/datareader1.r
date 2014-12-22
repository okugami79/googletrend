# parsing google trend file, extract information 

datareader1 <- function(file, skip=4)
  # file : google trend download file 
  # geom : Location Code in character 
  # year : numeric integer, indicating single year 
{

  .parse.trend.data <- function(x, start.idx=0, end.idx)
  {
    # hard code parsing  
    # y <- x[start.idx+1:(end.idx-4),]
    y <- x[start.idx+1:(end.idx-1),]
    
    # convert to ordinary data frame 
    date <- as.character(y[,1])
    date <- do.call(rbind, (strsplit( date, ' - ' ) ) ) 
    
    # need code to handle monthly & weekly data data 
    if ( length( strsplit(date[,1],'-')[[1]]) == 2 ) # monthly data 
      y[,1] <- as.Date( sprintf('%s-01',date[,1]) ) else 
        y[,1] <- as.Date( date[,1] )
    
    .internal=function(x)  # convert to numeric by col
    {
      return( as.numeric(y[,x]) )
    }
    
    LL=lapply(2:(ncol(y)),FUN=.internal)
    RR=do.call(cbind, LL)  
    y[,-1] <- RR
    
    return(y)
  }
  
  .parse.top.region<-function(x,start.idx,end.idx)
  {
    # hard code parsing  
    y <- x[(start.idx+2):(end.idx-1),] 
    colnames(y) <- c('region','index')
    
    y[,1] <- as.character(y[,1])
    y[,2] <- as.numeric( y[,2] ) 
    return(y)  
  }
  
  .parse.top.city<-function(x,start.idx,end.idx)
  {
    # hard code parsing  
    y <- x[(start.idx+2):(end.idx-1),] 
    colnames(y) <- c('city','index')
    
    y[,1] <- as.character(y[,1])
    y[,2] <- as.numeric( y[,2] ) 
    return(y)  
  }
  
  .parse.top.search <-function(x,start.idx,end.idx)
  {
    # hard code parsing  
    y <- x[(start.idx+2):(end.idx-1),]
    y
    colnames(y) <- c('top.search','index')
    
    y[,1] <- as.character(y[,1])
    y[,2] <- as.numeric( y[,2] ) 
    return(y)  
  }

  
  #  x<- read.csv(file=file, skip=5,col.names=c("week", "index"), stringsAsFactors=FALSE)
  x<- read.csv(file=file, skip=skip, stringsAsFactors=FALSE)
  
  TOP.REGION = "^Top regions for" 
  TOP.SUBREGION = "^Top subregions for"   
  TOP.CITY   = "^Top cities for"
  TOP.SEARCH = "^Top searches for"
  RISING.SEARCH="^Rising searches for"
  
  
  find.keyword.idx<-function(key)
  {
    # grep through key term in first column of google trend data 
    return( grep(key,x[,1]) )  
  }
  
  
  # 
  TOP.REGION.IDX=find.keyword.idx(TOP.REGION) # Range(TOP.REGION.IDX-TOP.CITY.IDX, Countries)
  TOP.SUBREGION.IDX=find.keyword.idx(TOP.SUBREGION) # Range(TOP.REGION.IDX-TOP.CITY.IDX, Countries)
  TOP.CITY.IDX=find.keyword.idx(TOP.CITY)
  TOP.SEARCH.IDX=find.keyword.idx(TOP.SEARCH)
  RISING.SEARCH.IDX=find.keyword.idx(RISING.SEARCH)
  
  message(
    paste("TOP.REGION.IDX",TOP.REGION.IDX, 
          "TOP.SUBREGION.IDX",TOP.SUBREGION.IDX,
          "TOP.CITY.IDX",TOP.CITY.IDX,
          "TOP.SEARCH.IDX",TOP.SEARCH.IDX,
          "RISING.SEARCH.IDX",RISING.SEARCH.IDX )    
  )
  
  
  # trend data 
  if ( 
    # checking only single entry form 
    is.null( 
      unlist(sapply(c(TOP.REGION.IDX,TOP.SUBREGION.IDX,TOP.CITY.IDX,TOP.SEARCH.IDX,RISING.SEARCH.IDX),FUN=function(X)length(x)))    
    )    
  ) 
  { # single entry, no associatge 
    if(nrow(x) == 0 )
      return (NULL)
    
    MIN.IDX<-nrow(x)
    trend <- .parse.trend.data(x,0,MIN.IDX)
    plot(trend, type='l')  
    
    ret<-list() 
    ret$trend <- trend
    return(ret)      
  }
  
  MIN.IDX<-min(TOP.REGION.IDX,TOP.SUBREGION.IDX,TOP.CITY.IDX,TOP.SEARCH.IDX,RISING.SEARCH.IDX, na.rm=T)  
  
  trend <- .parse.trend.data(x,0,MIN.IDX) 
  require(reshape)
  require(ggplot2) 
  
  MM=melt(id='Week',data=trend)
  print( ggplot(data=MM) + geom_line(aes(x=Week,y=value,color=variable)) ) 
    
  ret<-list() 
  ret$trend <- trend 
  
  
  # return value 
  return(ret)
  
}
