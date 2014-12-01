# NOTE: http://www.google.com/trends/explore#q=asthma&geo=AU&date=1%2F2004%202m&cmpt=q 
# mod: chriso nov-13: first usage of google trend report file issue 
# 
gettrend<-function(keyword="boston", geo=NULL, year=NULL, plot=TRUE,simple=TRUE) 
{
  require(utils)
 
  # set download directory path 
  # mod: 20-01-2014 fix for download directory path error 
  setup.download.dir <- function()
  {
  
    if( ! file.exists(.googletrend$DOWNLOADDIR) ) 
    {
      text<-sprintf(' |- error : your default browser download path [%s] was not found.', 
                    .googletrend$DOWNLOADDIR) 
      message(text)
      
      message (' |- type googletrend::setdownloaddir("your browser download path") and try again! :) ')
      
      return(NULL)
    }
    
    # cleaning up old downloaded good trend data files  
    for ( item in dir(.googletrend$DOWNLOADDIR, pattern='^report', full.names=TRUE) )
    {
      file.remove(item) # delete old trend data file 
    }
        
    return(.googletrend$DOWNLOADDIR)
  }
  
    # 
    # handling multiple keywords with comman,
    keyword=gsub(' ', "%20", keyword)
    
    KEYS <- unlist( strsplit(keyword, ','))
  
    if( length(KEYS) > 1 ) 
    {

      L <- list()
      for(item in KEYS)
      {
       item=gsub('%20',' ', item)
       command<-sprintf('L$`%s` <- gettrend(keyword=item,geo=geo, year=year, plot=plot, simple=simple )', item)
                
        eval(parse(text=command))
        
      }
      
      message(' Note: returning R list object contains multiple keywords!')
      message(' TIP')
      message(' LIST.RESULT <-gettrend("boston,chris")')
      message(' JOINED <- googletrend::mergetrend(LIST.RESULT) # to joint them together')
      
      return(L)
    }
  
  # setup download directory 
  DOWNLOADDIR<-setup.download.dir() 
  if( is.null(DOWNLOADDIR)) return(NULL)
  
  REPORTFILES=dir(DOWNLOADDIR, pattern='^report')  
  if(length(REPORTFILES)>0) # filtering suffix extention
    REPORTFILES=REPORTFILES[ grep('.csv$', REPORTFILES) ]
  
  # handing report id number 
  if(length(REPORTFILES) == 1) # only 1st download file 
  {
      if (REPORTFILES == "report.csv") # first one 
        NEXT.REPORT.ID <- 1 
  }
  
  # never download case 
  if( length(REPORTFILES) == 0 )
    NEXT.REPORT.ID <- 0 
      
  # has been downloaded more than once 
  if( length(REPORTFILES) > 1 ) # normal case incremental report number 
  {    
    # finding next report number
    X<-gsub('report', '', REPORTFILES ) 
    X<-gsub('.csv', '', X ) 
    X<-gsub('\\(', '', X ) 
    X<-gsub('\\)', '', X ) 
    NEXT.REPORT.ID<-max( as.numeric(X), na.rm=T ) + 1    
  } 
  
    
# handling path   
      if( NEXT.REPORT.ID == 0)
        REPORT.PATH<-paste(DOWNLOADDIR, "report.csv", sep='/') else
        {
          REPORT.PATH<-paste(DOWNLOADDIR, 'report', sep='/' )
          REPORT.PATH<-sprintf('%s(%d).csv', REPORT.PATH, NEXT.REPORT.ID)
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
    {
      message(' |- Something went wrong!')
      message(' |- Did you login to your gmail account at http://www.google.com/trends?')
      message(' |- or Maybe, your browser default download directory path is different!') 
      message(' |- type googletrend::setdownloaddir("YOUR BROWSER DOWNLOAD DIRECTORY PATH")')
      stop(" |- timeout ")
    }
        
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

