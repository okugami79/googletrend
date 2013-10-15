googletrend
===========
https://github.com/okugami79/googletrend
WORDPRESS REFERENCE OF HOW TO SET UP HERE 

R package - importing Google trend data to your R session :)   

About
----
I got sick of tired of clicking manual download of Googletrend data on web site. Spent investigate alternative way of doing data analysis with GoogleTrend, ended up writing new package, something I like to share with R data analytic community.   
 
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
1. login to your web browser http:/google.com/trends 
2. library(googletrend)
3. x = gettrend(keyword='boston')
   Does it works? 
   3.1: check your browsers *cookie* setting 
   3.2: check where is your browser's default downloads directory (Our packages uses $HOME/Downloads), it's different to user download directory. use *googletrend::setdownloaddir* to specify your location
   3.3  If this doesn't work, contact me!  
   

Note 
----
This package uses your default web browser features (Google Chrome, Firefox etc), automatically, download and convert data into R session from R console.  

If your web browser uses different Download directory, use to change it. 
setdownloaddir('my new path to browser download directory' )

Reference
-----
Use web browser cookie mechanism to connect google trend, then download trend file. 

