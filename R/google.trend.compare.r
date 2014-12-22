# NOTE: http://www.google.com/trends/explore#q=asthma&geo=AU&date=1%2F2004%202m&cmpt=q 
# mod: chriso nov-13: first usage of google trend report file issue 
# 
.gettrend.compare <-function(keyword="boston", geo=NULL, year=NULL, category=NULL, plot=TRUE,simple=TRUE, use.monthly=FALSE,compare=TRUE) 
{
  require(utils)
  
  COMPARE.ITEM=NULL 
  
  if( length( unlist( strsplit(keyword,',') )  )  > 1 ) COMPARE.ITEM='KEYWORD' else 
    if(is.vector(geo)) COMPARE.ITEM='GEO' else 
      if(is.vector(year)) COMAPRE.ITEM='YEAR'
  
  
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
  keyword=gsub(' ', "%20", keyword) # handling space 
  keyword=gsub('"', "%22", keyword) # handling double quote 
  keyword=gsub('\\+', "%2B", keyword) # operator plus 
  
  
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
  
  switch(COMPARE.ITEM,
         "KEYWORD"={
           keyword=gsub(',','%2C%20',keyword)
           if(!is.null(category) ) 
             trendsURL <- sprintf('http://www.google.com/trends/trendsReport?cat=%s&q=%s&cmpt=q&content=1&export=1', category, keyword)
           else trendsURL <- sprintf('http://www.google.com/trends/trendsReport?q=%s&cmpt=q&content=1&export=1', keyword)           
           
           # handling customizing query  
           if( !is.null(geo))
             trendsURL <- sprintf('%s&geo=%s', trendsURL, geo)
           
           if( !is.null(year))
             trendsURL <- paste(trendsURL, '&date=1%2F', year,'%2012m', sep='')
           
         },
         "GEO"={           
           geo=gsub(',','%2C%20',geo)
           if(!is.null(category) ) 
             trendsURL <- sprintf('http://www.google.com/trends/trendsReport?cat=%s&q=%s&cmpt=geo&geo=%scontent=1&export=1', category, keyword, geo)
           else trendsURL <- sprintf('http://www.google.com/trends/trendsReport?q=%s&cmpt=geo&content=1&export=1&geo=%s', keyword, geo)           

           if( !is.null(year))
             trendsURL <- paste(trendsURL, '&date=1%2F', year,'%2012m', sep='')
           
         },
         "YEAR"={
           stop('NOT SUPPORTED YET ')
           
         }
         )
  
  
  # CONSTRUCT GOOGLE TREND QUERY    
  
  utils::browseURL(trendsURL)
  message(trendsURL)
  
  retry=0
  while ( !file.exists(REPORT.PATH) ) 
  {
    Sys.sleep(1)
    retry<-retry+1 
    if(retry > 25) 
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
  # debugonce(datareader1)
  
  #debugonce(datareader1)
  switch(COMPARE.ITEM,
         'KEYWORD'={x<-datareader1(file=REPORT.PATH)},
         'GEO'={x<-datareader1(file=REPORT.PATH,skip=5)}
  )
         
  
  names(x$trend)[1] = 'week'
  return(x)    
}

} # f( gettrend ) 


# TREND <- .gettrend.compare(keyword = 'Basketball,Football,Tennis', geo= 'AU')
# TREND <- .gettrend.compare(keyword = 'Tennis', geo= 'AU,NZ',compare=TRUE)
# TREND <- .gettrend.compare(keyword = 'Tennis', time= '2013,2014')




