# RCurl Authentification is too difficult, let's work around with browser cookies 
# login <- function(gmail, password) 
# {
#   # delete previously created cookie 
#   if(file.exists('./cookies')) 
#     file.remove('./cookies')
#   
#   # Load required libraries
#   library(RCurl)  	# For getURL() and curl handler / cookie / google login
#   library(stringr)	# For str_trim() to trip whitespace from strings
#   
#   # Google account settings
#   username <- gmail
#   password <- password
#   c_file <- './cookies'
#   
#   # URLs
#   loginURL <- "https://accounts.google.com/accounts/ServiceLogin"
#   # loginURL <- "http://gmail.com"
#   authenticateURL <- "https://accounts.google.com/accounts/ServiceLoginAuth"
#  
#   ############################################
#   ## Perform Google login and get cookies ready
#   ############################################  
#   if (file.exists(c_file))
#   {
#     message(' |- ### reusing previous cookie file ### - ')
#     .googletrend$ch <- getCurlHandle(cookiefile=c_file, cookiejar=c_file)
#     return(.googletrend$ch)
#   }
#    
#   message(" |- ###  OPENING NEW AUTHENTIFICATION ### ")    
#   .googletrend$ch <- getCurlHandle()
#       
#   curlSetOpt(curl = .googletrend$ch,
#                  ssl.verifypeer = FALSE,
#                  useragent = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13",
#                  timeout = 60,
#                  followlocation = TRUE,
#                  cookiejar = c_file,
#                  cookiefile = c_file)
#                   
#   ## Perform Google Account login
#       tryCatch(
#   {
#     loginPage <- getURL(loginURL, curl=.googletrend$ch, verbose=TRUE) 
#     
#     galx.match <- str_extract(string = loginPage,
#                               pattern = ignore.case('name="GALX"\\s*value="([^"]+)"'))
#     
#     galx <- str_replace(string = galx.match,
#                         pattern = ignore.case('name="GALX"\\s*value="([^"]+)"'),
#                         replacement = "\\1")
#     
#     authenticatePage <- postForm(authenticateURL, .params=list(Email=username, 
#                                                                Passwd=password, GALX = galx), curl=.googletrend$ch)
#     
#     # getCurlInfo(ch) # To see if login was successful
#     if( getCurlInfo(.googletrend$ch)$effective.url == "https://www.google.com/settings/account" 
#         & getCurlInfo(.googletrend$ch)$response.code == 200) {
#       message(" |- *** :) Google login successful :) *** ")
#       message(" |- ")
#       message(sprintf(" |- IP: %s", getCurlInfo(.googletrend$ch)$primary.ip )) 
#       
#       save(.googletrend, file='googletrendx') 
#       
#     } else {
#       message("Google login _not_ successful. Check your login credentials!")
#     }
#     
#   },
#   error=function(e)
#   {
#     message( ' |-  googletrend; error establishing connection !!### ') 
#     message( ' |-   Are your gmail account and password correct? ')
#     
#     # clean up old cookie file 
#     # file.remove(c_file)
#   }
#   
#       ) # tryCatch 
#           
# } # fun(login)
# 
