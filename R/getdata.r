
gettrend<-function(keyword="boston", geo=NULL, year=NULL, plot=TRUE) 
{
  require(utils)

  #DOWNLOAD FILE NAMES 
  DOWNLOADDIR=.googletrend$DOWNLOADDIR    
  REPORTFILES=dir(DOWNLOADDIR, pattern='report')  
  REPORTFILES=REPORTFILES[grep('.csv', REPORTFILES)]
  
  # finding next report number  
  X<-gsub('report', '', REPORTFILES ) 
  X<-gsub('.csv', '', X ) 
  X<-gsub('\\(', '', X ) 
  X<-gsub('\\)', '', X ) 
  NEXT.REPORT.ID<-max( as.numeric(X), na.rm=T ) + 1
  
  if(is.na(NEXT.REPORT.ID))
    REPORT.PATH<-paste(DOWNLOADDIR, NEWREPORTFILES, sep='/') else
    {
      REPORT.PATH<-paste(DOWNLOADDIR, 'report', sep='/' )
      REPORT.PATH<-sprintf('%s (%d).csv', REPORT.PATH, NEXT.REPORT.ID)
    }
   
  # CONSTRUCT GOOGLE TREND QUERY  
  trendsURL <- sprintf('http://www.google.com/trends/trendsReport?q=%s&content=1&export=1', keyword)
  
  # handling customizing query  
  if( !is.null(geo))
    trendsURL <- sprintf('%s&geo=%s', trendsURL, geo)
  
  if( !is.null(year))
    trendsURL <- paste(trendsURL, '&date=1%2F', year,'%2012m', sep='')
          
  utils::browseURL(trendsURL)
  
  retry=0
  while ( !file.exists(REPORT.PATH) ) 
  {
    Sys.sleep(1)
    retry<-retry+1 
    if(retry > 8) 
      stop(" |- DID YOU LOGIN your gmail/gtrend account ??? : see http://www.google.com/trends/")
  } 
    
  # All succeed case 
  {
    # Parse resonse and store in CSV
    # We skip ther first 5 rows which contain the Google header; we then read 503 rows up to the current date    
    x<- read.csv(file=REPORT.PATH, skip=5, nrows=503,col.names=c("week", "index"))
    
    # convert to ordinary data frame 
    x[,1] <- as.character(x[,1])
    date <- do.call(rbind, (strsplit( x[,1], ' - ' ) ) ) 
    x[,1] <- as.Date( date[,1] ) 
     
    if(plot)
    {
      plot(x, type='l') 
      title(paste(keyword, geo, year) )        
    }
    
    return(x)    
  }
  
} # f( gettrend ) 

