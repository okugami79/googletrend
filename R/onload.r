.onLoad <- function(libname, pkgname)
{
  
  .googletrend <<- new.env()
  .googletrend$ch <- NULL 
  .googletrend$DOWNLOADDIR <<-sprintf('%s/Downloads', Sys.getenv('HOME') )
  
  message(paste(' |- your webbrowser download directory path : ', .googletrend$DOWNLOADDIR ))          
}

setdownloaddir <-function(path)
{
  .googletrend$DOWNLOADDIR <- path   
  message(paste(' |- your webbrowser download directory path : ', .googletrend$DOWNLOADDIR ))            
}

