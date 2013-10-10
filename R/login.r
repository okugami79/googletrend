login <- function(gmail, password) 
{
  # delete previously created cookie 
  if(file.exists('./cookies')) 
    file.remove('./cookies')
  
  # Load required libraries
  library(RCurl)  	# For getURL() and curl handler / cookie / google login
  library(stringr)	# For str_trim() to trip whitespace from strings
  
  # Google account settings
  username <- gmail
  password <- password
  
  # URLs
  loginURL <- "https://accounts.google.com/accounts/ServiceLogin"
  authenticateURL <- "https://accounts.google.com/accounts/ServiceLoginAuth"
  
  ############################################
  ## Perform Google login and get cookies ready
  ############################################
  .googletrend$ch <- getCurlHandle()
  
# OLD VERSION 
 curlSetOpt(curl = .googletrend$ch,
            ssl.verifypeer = FALSE,
            useragent = "Mozilla/5.0",
            timeout = 60,
            followlocation = TRUE,
            cookiejar = "./cookies",
            cookiefile = "./cookies")
  

# # CHRIS NEW VERSION 
#   curlSetOpt(curl = .googletrend$ch,
# #             ssl.verifypeer = FALSE,
#              useragent = "Mozilla/5.0",
#              timeout = 60,
#              followlocation = TRUE,
#              cookiejar = "./cookies"
# #             cookiefile = "./cookies"
# )
# 
  
  ## Perform Google Account login
  tryCatch(
{
  loginPage <- getURL(loginURL, curl=.googletrend$ch)
  
  galx.match <- str_extract(string = loginPage,
                            pattern = ignore.case('name="GALX"\\s*value="([^"]+)"'))
  
  galx <- str_replace(string = galx.match,
                      pattern = ignore.case('name="GALX"\\s*value="([^"]+)"'),
                      replacement = "\\1")
  
  authenticatePage <- postForm(authenticateURL, .params=list(Email=username, 
                                                             Passwd=password, GALX = galx), curl=.googletrend$ch)
  
  # getCurlInfo(ch) # To see if login was successful
  if( getCurlInfo(.googletrend$ch)$effective.url == "https://www.google.com/settings/account" 
      & getCurlInfo(.googletrend$ch)$response.code == 200) {
     message(" |- *** :) Google login successful :) *** ")
     message(" |- ")
     message(sprintf(" |- IP: %s", getCurlInfo(.googletrend$ch)$primary.ip )) 
     
     save(.googletrend, file='googletrendx') 

  } else {
    message("Google login _not_ successful. Check your login credentials!")
  }
  
},
error=function(e)
{
  message( ' |-  googletrend; error establishing connection !!### ') 
  message( ' |-   Are your gmail account and password correct? ')
}

    ) # tryCatch 
}

