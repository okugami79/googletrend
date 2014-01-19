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
library(googletrend)

\#specify where your default browser download file 

setdownloadir('C:/User/Downloads')

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

<pre>
<b># Open your default web browser like, chrome, firefox. 
# NOW sign in your gmail account at  http://google.com/trends </b> 
</pre>
go back to R, again, type following 


dat <- gettrend('boston')

head(dat)

<pre>
        week index
1 2004-01-11    12
2 2004-01-18    12
3 2004-01-25    12
4 2004-02-01    13
5 2004-02-08    13
6 2004-02-15    12
</pre> 


Note 
----

This package uses your default web browser cookie features. No Rcurl version.  

If your web browser uses different Downloads directory path, use googletrend:: 
setdownloaddir('my new path to browser download directory' )

Reference
-----
Use web browser cookie mechanism to connect google trend, then download trend file. 

