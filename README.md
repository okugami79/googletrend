googletrend
===========
https://github.com/okugami79/googletrend
 

R package - importing Google trend data to your R session :)   

About
----
Google trend is useful data source among data science, which often used for obserbing real-time change of trends of public. Such as the change of people getting flu, market interest of product and so on. Source of information can be used to model your statistical analysis.  

Googletrend package is written to download avialable data from Google in R session. This replaces the manual process of downloading CSV file, importing to R.   

We recently added new google trend features, such google operator (keyword + keyword), google category, specifying the google trend. It allows to query the trend data fits to your data analysis.   

  
Example 
----

<pre>
# INSTALLATION
# (1.1) Install and load package "devtools"
  library(devtools)

# (1.2) install and load package "googletrend"
  install_github('googletrend','okugami79')
  library(googletrend)

# (1.3) Now open your default web browser like chrome or firefox and sign into your gmail account at http://google.com/trends on your browser.

# (1.4) Specify the location of your default browser download directory path (replace '...' with your own path. The path refers to the place where the default broswer downloads files.):
  googletrend::setdownloaddir('C:/Users/...') # Fill in your own download directory 

# (1.5) Define your working directory
  setwd("C:/Users/...")

# EXAMPLE: Load Google Trends data for the keyword "Twitter" (for the location "New York"):

# get google trend data, with keyword, "Twitter". 
x<- googletrend::gettrend(keyword='Twitter') 

# Installation: 
require(devtools) 
install_github('googletrend','okugami79')
library(googletrend)
# (1.1) Install the package "devtools"

  
# (1.2) Follow the steps below; run each code. 
  library(devtools)
  install_github('googletrend','okugami79')
  library(googletrend)

# (1.3) Optional: In case you want to use multiple keywords
  library(ggplot2)
  library(reshape)

# (1.4) Now open your default web browser like chrome or firefox and sign into your gmail account at http://google.com/trends on your browser.

# (1.5) Specify the location of your default browser download directory path (replace '...' with your own path. The path refers to the place where the default broswer downloads files.):
  googletrend::setdownloaddir('/Users/danielwochner/Downloads') 

# (1.6) Define your working directory
  setwd("/Users/danielwochner/Desktop/R/TestDataSets")

# get google trend data, with keyword, "Twitter". 
x-". example (US-NY) : US, state of New York
 NY.TREND=gettrend(keyword = "new york", geo = "US-NY")

# REGION SPECIFIC trend query by country "". example (AU) : First 2 characters 
 NY.TREND=gettrend(keyword = "new york", geo = "AU")

</pre>
