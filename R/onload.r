.onLoad <- function(libname, pkgname)
{
  
  .googletrend <<- new.env()
  .googletrend$ch <- NULL 
  .googletrend$DOWNLOADDIR <<-sprintf('%s/Downloads', Sys.getenv('HOME') )
  
  message(paste(' |- your webbrowser download directory path : ', .googletrend$DOWNLOADDIR ))          
}

setdownloaddir <-function(path)
{
  # mod: 20-01-2014 
  # fix windows path, backslash to forward slash    
  .googletrend$DOWNLOADDIR <- gsub('\\\\' ,'/' , path )    
  
  # check directry 
  if( !file.exists(.googletrend$DOWNLOADDIR) )
    stop(sprintf('directory path ["%s"] was not found!',
                 .googletrend$DOWNLOADDIR)) 
  
  message(paste(' |- your webbrowser download directory path : ', .googletrend$DOWNLOADDIR ))            
}
