\name{gettrend}
\alias{gettrend}

\title{
Load Google Trends Data from Web
}

\description{
The \code{googletrend} package was developed to load and transform Google Trends data within R. The aim of the package is to minimize the effort of manually downloading and merging different CSV files from Google Trends.
}
   
\usage{
gettrend(keywords = 'Tennis', geo = NULL, year = NULL, plot=TRUE, simple = TRUE,
         use.monthly = FALSE, compare = FALSE)
}

\arguments{
  \item{keyword}{
   this argument allows to specify the Google Trend search term(s) (example: \code{keyword = 'Tennis'} or \code{keyword = 'Basketball, Tennis'})
}

  \item{geo}{
  this argument allows to specify country or state (example: use \code{geo = 'AU'} for Australia or \code{geo = 'AU-NSW'} for the state North South Wales in Australia). Default is NULL, i.e. worldwide.
}
  \item{year}{
  this argument allows to specify a particular year (example: \code{year = '2013'}). Default is NULL, i.e. entire time range ever since January 2004.
}
  \item{plot}{
  this binary argument allows to specify whether a trend figure shall be displayed or not. Default is TRUE, i.e. shows trend figures. 
}

  \item{simple}{
  this binary argument allows to specify whether full attribute data (such as top cities, countries, top related keyword list) shall be returned or not. Default is TRUE, i.e. the function only returns the Google Trend index without any further attributes. If FALSE, the function returns full attribute data (incl. top cities, countries, related top keywords list, raising new keywords, etc.).
}
 
  \item{use.monthly} 
 {
  this binary argument allows to specify whether the Google Trend index shall be aggregated to monthly frequency data or not. Default is FALSE, i.e. use weekly data. 
 }

 \item{compare}
 {
  this binary argument allows specify whether different search terms, locations or time ranges shall be compared or not. Default is FALSE, i.e. multiple search terms, multiple geo locations or multiple time ranges are loaded individually one-by-one. If TRUE the values of those attributes are compared for which there are multiple terms (either multiple keywords, multiple geos or multiple years).
 }

}

\value{
NULL             - no result matches with keyword; 
trend data frame - dataframe(Date,Index) if simple=TRUE; 
list             - all trend attributes like spatial info if simple=FALSE; 
}

\details{
USING GOOGLE SPECIAL SEARCH OPERATOR (+,-,"")

gettrend(keyword = 'tennis shoes') #result includes searches containing both 'tennis' and 'shoes' in any order. 
 
gettrend(keyword = '"tennis shoes"') #result includes exact search term 
 
gettrend(keyword = 'tennis+shoes') #result contains searches the word 'tennis' OR 'shoes' 
 
gettrend(keyword = 'tennis-shoes') #results will include searches with the word 'tennis' but excludes searches with the word 'shoes'
}


\author{
Chris Okugami 
}

\examples{
\dontrun 
{        
# (1) LOAD SINGLE KEYWORDS
  (1.1) Load single keyword index
  TREND.A <- gettrend(keyword = 'Basketball')
  TREND.B <- gettrend(keyword = 'Football')
  TREND.C <- gettrend(keyword = 'Tennis')
 
 > head(TREND.C)
          week index
  1 2004-01-04    42
  2 2004-01-11    43
  3 2004-01-18    55
  4 2004-01-25    57
  5 2004-02-01    45
  6 2004-02-08    42
 
 
 
# (2) LOAD AND MERGE MULTIPLE KEYWORDS
  TRENDS.ABC <- gettrend(keyword='Basketball, Football, Tennis')
  MERGED.TRENDS.ABC <- googletrend::mergetrend(TRENDS.ABC) 
 
 > head(MERGED.TRENDS.ABC)
          week Basketball Football Tennis
  1 2004-01-04         42       39     42
  2 2004-01-11         46       37     43
  3 2004-01-18         47       37     55
  4 2004-01-25         43       35     57
  5 2004-02-01         44       40     45
  6 2004-02-08         46       33     42



# (3) LOAD FULL ATTRIBUTE LISTS
# (3.1) Load full attribute list
  TREND.ATT <- gettrend(keyword = 'Tennis', simple=FALSE)  

  # Show attributea via $top.region, $top.city or $top.search  
  > head(TREND.ATT$top.region)
           region index
  576   Australia   100
  577     Bermuda    93
  578      Monaco    90
  579  San Marino    87
  580 Switzerland    82
  581      France    80
  
  > head(TREND.ATT$top.city)
                     region index
  747          Paris (France)   100
  748   Melbourne (Australia)    99
  749 London (United Kingdom)    94
  750    Zurich (Switzerland)    91
  751      Sydney (Australia)    85
  752      Brussels (Belgium)    78
  
  > head(TREND.ATT$top.search)
        top.search index
  764 tennis us open    75
  765        us open    70
  766     atp tennis    60
  767            atp    60
  768    live tennis    50
  769   tennis shoes    40
  
  
  
# (4) ADDITIONAL SPECIFICATIONS  
# (4.1) Search for keyword in a specific country or state (e.g. 'Australia' or 'New South Wales') 
  TREND.GEO <- gettrend(keyword = 'Tennis', geo = 'AU')
  TREND.GEO <- gettrend(keyword = 'Tennis', geo = 'AU-NSW')
 
# (4.2) Search for keyword during a particular year (e.g. '2012')
  TREND.GEO <- gettrend(keyword = 'Tennis', year = '2012')
  
# (4.3) Search for keyword within a particular category (e.g. 'Sports')
  TREND.CAT <- gettrend(keyword = 'Tennis', category='0-20')

# (4.4) Compare different search terms, locations, or time spans,
  TREND.COMP.KEY <- gettrend(keyword = 'Basketball, Football, Tennis', compare = TRUE)
  TREND.COMP.GEO <- gettrend(keyword = 'Tennis', geo = 'AU, IN, US', compare = TRUE)
  TREND.COMP.TSP <- gettrend(keyword = 'Tennis', year= '2011, 2012, 2013', compare = TRUE)
  
# (4.5) Use monthly values (i.e. index is aggregated/summed over different weeks)
  TREND.MTH <- gettrend (keyword = 'Tennis', use.monthly=TRUE)



# (5) COMPUTATIONS AND DATA MANIPULATION
# (5.1) Plot a single keyword (use $'...' for keywords with space)
  TRENDS.ABC <- gettrend(keyword='Basketball, Football, Tennis')
  MERGED.TRENDS.ABC <- googletrend::mergetrend(TRENDS.ABC) 
  plot(MERGED.TRENDS.ABC$Basketball,type='l')

# (5.2) Correlation among multiple keywords
  TRENDS.ABC <- gettrend(keyword='Basketball, Football, Tennis')
  MERGED.TRENDS.ABC <- googletrend::mergetrend(TRENDS.ABC) 
  cor(MERGED.TRENDS.ABC[,-1])
  
# (5.3) Fit linear regression to the data
  TRENDS.ABC <- gettrend(keyword='Basketball, Football, Tennis')
  MERGED.TRENDS.ABC <- googletrend::mergetrend(TRENDS.ABC) 
  REGMODELL <- lm(Basketball ~ Football + Tennis, data=MERGED.TRENDS.ABC)
  summary(REGMODELL)


}

}


