googletrend
===========
https://github.com/okugami79/googletrend
 

R package - importing Google trend data to your R session :)   

About
----
Have you got tired of clicking manual download of Googletrend data from the web site for your data analysis? This package help you importing data to R. 

Something I like to share with R data analytic community.   
  
Example 
----

\# run index of Google trend keyword boston

BOSTON.INDEX <- gettrend(keyword='boston')
plot(BOSTON.INDEX)


\# run index of Google trend keyword boston only year 2013

BOSTON.INDEX <- gettrend(keyword='boston', year=2013);
plot(BOSTON.INDEX)


\# AU(Australia) region of firework query 

FIREWORK.INDEX <- gettrend('firework', geo='AU' );
plot(FIREWORK.INDEX)

\# AU(Australia, NSW) region of firework query 
\# How to find geo location code, see my wordpress page: 

FIREWORK.INDEX <- gettrend('firework', geo='AU-NSW' );
plot(FIREWORK.INDEX)


Installation 
----
require(devtools) 

install_github('googletrend','okugami79')

library(googletrend)

# Open your default web browser like, chrome, firefox. 
# NOW sign in your gmail account at  http://google.com/trends 

go back to R, again, type following 

> dat <- gettrend('boston')
download csv file path: C:\Users\oku003/Downloads/report (57).csv
TOP.REGION.IDX 513 TOP.SUBREGION.IDX  TOP.CITY.IDX 637 TOP.SEARCH.IDX 648 RISING.SEARCH.IDX 699
> 
> head(dat)
        week index
1 2004-01-11    12
2 2004-01-18    12
3 2004-01-25    12
4 2004-02-01    13
5 2004-02-08    13
6 2004-02-15    12


Note 
----
This package uses your default web browser features (Google Chrome, Firefox etc), automatically, download and convert data into R session from R console.  

If your web browser uses different Download directory, use to change it. 
setdownloaddir('my new path to browser download directory' )

Reference
-----
Use web browser cookie mechanism to connect google trend, then download trend file. 

