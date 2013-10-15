\name{gettrend}
\alias{gettrend}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
 Get Google trend data from Web 
}
\description{
Acquire google trend data 
}

\usage{
gettrend(keyword = "boston", geo = NULL, year = NULL, plot = TRUE, simple=TRUE)
}

\arguments{
  \item{keyword}{
   google trend keyword 
}
  \item{geo}{
  character for specifiy country|state, example, 'AU-NSW'. See wordpress for more info. 
}
  \item{year}{
  specific year only data - defaul NULL, grab entire dataset 
}
  \item{plot}{
  plot is FALSE, doesn't display trend figure. Default is TRUE, show result. 
}

  \item{simple}{
  Default is simple=TRUE, only return trend index, simple=FALSE, return full attribute data like, top cities, countries, associated keyword top list, raising new keywords topic. List object will be return. 
  
  To extract trend data, 
  ret<-gettrend('boston',simple=FALSE)
  plot( ret$trend ) 
  
 }

}


\value{
NULL             - no result match with keyword 
trend data frame - dataframe(Date,Index) if simple=TRUE 
list             - all trend attributes like spatial info if simple=FALSE 
}


\author{
chris okugami 
}

\examples{
\dontrun 
{
boston.world.index <- gettrend('boston')
> head(boston.world.index)
        week index
1 2004-01-11    12
2 2004-01-18    12
3 2004-01-25    12
4 2004-02-01    13
5 2004-02-08    13
6 2004-02-15    12



# geo give you narrow region of trend. For example, (AU-Australia)
# we are interested in people in Australia interested in firework.
# Look my wordpress page to find out how find those region symbol. 

au.region.firework.index <- gettrend('firework', geo='AU')

# you can get full detail report 
au.region.firework.index.detail <- gettrend('firework', geo='AU', simple=FALSE)

au.region.firework.index.detail$top.region
                          region index
515              New South Wales   100
516                   Queensland    93
517              South Australia    88

au.region.firework.index.detail$top.city
       region index
525    Sydney   100
526  Brisbane    86
527 Melbourne    83
528  Adelaide    79


> au.region.firework.index.detail$top.search
                  top.search index
534            katy firework    95
535               katy perry    95
536      firework katy perry    95
537                fireworks    40
538        katy perry lyrics    35
539          firework sydney    20

# hmm, Currently, katy perry, song "firework"" is most hot topic in Australia 

}

}

