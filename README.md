googletrend
===========
https://github.com/okugami79/googletrend

R package - 2013 google trend 

About
----
We need new package so we can grab google trend data in R console session. This implementation doesn't use RCurl, but it uses your default web browser (Google Chrome, Firefox etc.)
 
Example 
----
\# run index of Google trend keyword boston
BOSTON.INDEX <- gettrend(keyword='boston')
plot(BOSTON.INDEX)


\# run index of Google trend keyword boston only year 2013
BOSTON.INDEX <- gettrend(keyword='boston', year=2013)
plot(BOSTON.INDEX)


\# AU(Australia) region of firework query 
FIREWORK.INDEX <- gettrend('firework', geo='AU' )
plot(FIREWORK.INDEX)

\# AU(Australia, NSW) region of firework query 
FIREWORK.INDEX <- gettrend('firework', geo='AU-NSW' )
plot(FIREWORK.INDEX)


Note 
----

If your web browser uses different Download directory, use to change it. 
setdownloaddir('my new path to browser download directory' )


Reference
-----
Use web browser cookie mechanism to connect google trend, then download trend file. 

