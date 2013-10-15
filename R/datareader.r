# parsing google trend file, extract information 
# option: geo, year 
# 

datareader <- function(file,  geo=NULL, year=NULL)
  # file : google trend download file 
  # geom : Location Code in character 
  # year : numeric integer, indicating single year 
{
  x<- read.csv(file=REPORT.PATH, skip=5,col.names=c("week", "index"))

  TOP.REGION = "^Top regions for"
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
  TOP.CITY.IDX=find.keyword.idx(TOP.CITY)
  TOP.SEARCH.IDX=find.keyword.idx(TOP.SEARCH)
  RISING.SEARCH.IDX=find.keyword.idx(RISING.SEARCH)
  
  browser() 
  
  # trend data 
  trend <- .parse.trend.data(x,0,TOP.REGION.IDX)
  plot(trend, type='l')  
  
  if( length(TOP.REGION.IDX) > 0 &  length(TOP.CITY.IDX) )
  {
    top.region <- .parse.top.region(x,
                                    start.idx=TOP.REGION.IDX,
                                    end.idx=TOP.CITY.IDX )    
  }

  if(length(TOP.CITY.IDX) > 0 & length(TOP.SEARCH.IDX))
  {
    top.city <- .parse.top.region(x,
                                  start.idx=TOP.CITY.IDX,
                                  end.idx=TOP.SEARCH.IDX )    
  }

  if( length(TOP.SEARCH.IDX) & length(RISING.SEARCH.IDX) )
  {
    top.search <- .parse.top.search(x,
                                    start.idx=TOP.SEARCH.IDX,
                                    end.idx=RISING.SEARCH.IDX )    
  }
 
  # append the way to dealing with NA entry 
  list(trend,top.region,top.city,top.earch)
  
}

.parse.trend.data<-function(x, start.idx=0, end.idx)
{
  # hard code parsing  
   y <- x[start.idx+1:(end.idx-4),]
  
  # convert to ordinary data frame 
  y[,1] <- as.character(y[,1])
  date <- do.call(rbind, (strsplit( y[,1], ' - ' ) ) ) 
  y[,1] <- as.Date( date[,1] ) 
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


