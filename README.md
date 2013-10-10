googletrend
===========

R package - 2013 google trend 

About
----
We need new package so we can grab google trend data in R console session. 
 

Example 
----

login(gmail='mx@gmail.com', password='xyz') 

# run index of Google trend keyword boston
BOSTON.INDEX <- gettrend(q='boston')

plot(BOSTON.INDEX)


# AU(Australia) region of firework query 
FIREWORK.INDEX <- gettrend(q='firework', geo='AU' )

plot(FIREWORK.INDEX)

Note 
----


Reference
-----
I took christoph's example, put it around R package framework, add spatial parameter to select to work with location specific google trend index. 
Christoph Riedl - http://christophriedl.net/2013/08/22/google-trends-with-r/ 

