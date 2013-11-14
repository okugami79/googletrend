# NOTE: http://www.google.com/trends/explore#q=asthma&geo=AU&date=1%2F2004%202m&cmpt=q 
# mod: chriso nov-13: first usage of google trend report file issue 
# 
gettrend<-function(keyword="boston", geo=NULL, year=NULL, plot=TRUE,simple=TRUE) 
{
  require(utils)

  #DOWNLOAD FILE NAMES 
  DOWNLOADDIR=.googletrend$DOWNLOADDIR    
  REPORTFILES=dir(DOWNLOADDIR, pattern='^report*.csv')  
  
  if( length(REPORTFILES) > 0 )
  {
    REPORTFILES=REPORTFILES[grep('.csv', REPORTFILES)]
    
    # finding next report number
    X<-gsub('report', '', REPORTFILES ) 
    X<-gsub('.csv', '', X ) 
    X<-gsub('\\(', '', X ) 
    X<-gsub('\\)', '', X ) 
    NEXT.REPORT.ID<-max( as.numeric(X), na.rm=T ) + 1    
  } else 
  {
    # first time to download
    NEXT.REPORT.ID <- 0 
  }
    
  if( NEXT.REPORT.ID == 0)
    REPORT.PATH<-paste(DOWNLOADDIR, "report.csv", sep='/') else
    {
      REPORT.PATH<-paste(DOWNLOADDIR, 'report', sep='/' )
      REPORT.PATH<-sprintf('%s (%d).csv', REPORT.PATH, NEXT.REPORT.ID)
      message(paste('download csv file path:', REPORT.PATH))
      REPORT.PATH <<- REPORT.PATH 
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
    x<-datareader(file=REPORT.PATH)   
    if( !is.null(x) & simple ) 
      return(x$trend) else 
        return(x)    
  }
  
} # f( gettrend ) 

