gettrend<-function(keyword="boston", ...) 
{
  if( is.null(.googletrend$ch) ) stop(' |- please, login at first! ')
    
  browser()
  
  trendsURL <- "http://www.google.com/trends/trendsReport"
  
  res <- getForm(trendsURL, q=keyword, ..., content="1", export="1", curl=.googletrend$ch)
  
  # Check if quota limit reached
  if( grepl( "You have reached your quota limit", res ) ) {
    message( " |- ## ERROR : Quota limit reached; ### :(  " ) 
  } else 
  {
    # Parse resonse and store in CSV
    # We skip ther first 5 rows which contain the Google header; we then read 503 rows up to the current date
    x <- try( read.table(text=res, sep=",", col.names=c("Week", "TrendsCount"), skip=5, nrows=503) )
    
    # convert to ordinary data frame 
    
    return(x)    
  }
}

