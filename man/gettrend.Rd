\name{gettrend}
\alias{gettrend}

\title{
 Get Google trend data from Web 
}

\description{
Acquire google trend data within R session. Transform google trend data to R format for quick data analysis. The aim of this package is to minimize the effort of manual download CSV file from Google trend data. 
}

\usage{
 # world wide query index (keyword boston)
 BOSTON.TREND=gettrend(keyword = "boston", geo = NULL, year = NULL, plot = TRUE, simple=TRUE)

 NY.TREND=gettrend(keyword = "new york", geo = NULL, year = NULL, plot = TRUE, simple=TRUE)

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

 # Using google category (Automobile)
 TREND2 <- gettrend('Jaguar,bentley', category='0-47')
 RR=mergetrend(TREND2)

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
 
  \item{use.monthly} 
 {
  TRUE, aggregate index for montly. In rare case, some index use monthly only so we add this function to cope with the issue. FALSE, use default weekly index.  
 }

 \item{compare}
 {
  TRUE, google compare functionatires. Support multiple keywords, multile geo parameter 
 }

}

\value{
NULL             - no result match with keyword 
trend data frame - dataframe(Date,Index) if simple=TRUE 
list             - all trend attributes like spatial info if simple=FALSE 
}

\details{
 USING GOOGLE SPECIAL SEARCH OPERATOR (+,-) in query 
 
 Example 
 getgrend('tennis shoes') #result contains includes searches containing both tennis and shoes in any order. 
 
 getgrend('"tennis shoes"') #result contains includes exact search term 
 
 getgrend('"tennis+shoes"') #result contains searches the word tennis OR shoes 
 
 getgrend('"tennis-shoes"') #result contains searches containing tennis but excludes searches with the word shoes
 
 USING CATEGORY in query 
 head( list.category() ) # FIND YOUR QUERY category code. 
 
 # for example "Celebrities & Entertainment News Celebrities" - category code 0-3-184 
 PARIS = gettrend('"Paris Hilton"', category='0-3-184')

 # category reduce the size of data, often doesn't get enough weekly count. Use use.monthly=TRUE
 TREND.B2 <- gettrend(keyword = 'Jaguar,Bentley', category = '0-47', use.monthly = TRUE)
 OO=mergetrend(TREND.B2)


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

# running multiple keywords trends, speparated by commas.
# return object will be in R list object for individual keywords
M.TREND<- gettrend('boston,marathon,bom')

str(M.TREND)

# JOIN the multiple keyword object into column oriented format
# for ease of use of modelling 

M.TREND<-mergetrend(M.TREND)
str(M.TREND) # column oriented dataset 

# fitting boston index with other index 
model<-lm(indexboston ~ indexmarathon + indexbom,data=M.TREND) 
summary(model) 

# correlation (remove first column contains week)
cor(M.TREND[,-1] )

# GET MONTHLY INDEX 
MONTHLY.INDEX = gettrend('boston',use.monthly=TRUE)

# COMPARE RESULT 
TREND <- .gettrend(keyword = 'Basketball,Football,Tennis', geo= 'AU',compare=TRUE) # by keyword
TREND <- .gettrend(keyword = 'Tennis', geo= 'AU,NZ',compare=TRUE) # by different location 

}

}
