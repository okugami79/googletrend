googletrend
===========
https://github.com/okugami79/googletrend
 

R package - importing Google trend data to your R session :)   

About
----
Have you got tired of clicking manual download of Googletrend data from the web site for your data analysis? This package help you importing data to R. 
  
Example 
----


<pre>
# Installation: 
require(devtools) 
install_github('googletrend','okugami79')
library(googletrend) 

# get google trend data, with keyword, "Twitter". 
x<- googletrend::gettrend(keyword='Twitter') 
head(x)
        week index
1 2004-01-11    12
2 2004-01-18    12
3 2004-01-25    12
4 2004-02-01    13
5 2004-02-08    13
6 2004-02-15    12

plot(x)

# get full detail trend, including top region etc .. 
DETAIL<- googletrend::gettrend(keyword='Twitter') 
DETAIL$top.search 
DETAIL$top.region
str( DETAIL$trend )


# AU(Australia) region of firework query 
FIREWORK.INDEX <- gettrend('firework', geo='AU' );
plot(FIREWORK.INDEX)

# AU(Australia, NSW) region of firework query 
# How to find geo location code, see my wordpress page: 

FIREWORK.INDEX <- gettrend('firework', geo='AU-NSW' );
plot(FIREWORK.INDEX)

# world wide query index (keyword boston)
 BOSTON.TREND=gettrend(keyword = "boston")

 NY.TREND=gettrend(keyword = "new york")

# handling multiple keywords 
 MULTIPLE.TREND=gettrend(keyword='new york,boston')
 
 plot(MULTIPLE.TREND$`new york`,type='l') # USE `` because it contains space 
 plot(MULTIPLE.TREND$`boston`,type='l')
 
# joint 2 trend together for multivariate analysis 
 JOINED <- googletrend::mergetrend(MULTIPLE.TREND)

# REGION SPECIFIC trend query by country & state "<country-code>-<state>". example (US-NY) : US, state of New York
 NY.TREND=gettrend(keyword = "new york", geo = "US-NY")

# REGION SPECIFIC trend query by country "<country-code>". example (AU) : First 2 characters 
 NY.TREND=gettrend(keyword = "new york", geo = "AU")


</pre>
