
gettrend<-function(keyword="boston", ...) 
{
  browser()
  
  if( is.null(.googletrend$ch) ) stop(' |- ## ERROR : please, login at first! ### ')
      
  trendsURL <- "http://www.google.com/trends/trendsReport"
  
  res <- getForm(trendsURL, q=keyword, ..., content="1", export="1", curl=.googletrend$ch)
  
  # Check if quota limit reached
  if( grepl( "You have reached your quota limit", res ) ) {
    message( " |- ## ERROR : Quota limit reached; ### :(  " ) 
  } else 
  {
    # Parse resonse and store in CSV
    # We skip ther first 5 rows which contain the Google header; we then read 503 rows up to the current date
    
    # convert to ordinary data frame 
    x <- try( read.table(text=res, sep=",", col.names=c("week", "index"), skip=5, nrows=503) )
        
    date <- do.call(rbind, (strsplit( x[,1], ' - ' ) ) ) 
    date[,1]
    x[,1] <- as.Date( date[,1] ) 
    
    plot(x, type='l') 
    title(keyword) 
    
    return(x)    
  }
  
} # f( gettrend ) 

