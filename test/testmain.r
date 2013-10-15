# Main Test parsing Google trend data 
#

TEST.FILES= sprintf('test/testdata/%s', dir('test/testdata', pattern='.csv') )

require(testthat)

find.test.file<-function(x='allyear.csv')
{
  if(length(grep(x,TEST.FILES)) == 0 )
    return(NA) else 
  return( TEST.FILES[grep(x,TEST.FILES)] )  
}


# GRAB TYPICAL DOWNLOAD FILE FORMAT 
FPATH=find.test.file('allyear.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('Au2006.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('AuAllYears.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('Aunoregion.no.key2mos.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('only2006.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('world.2mos.csv')
RES=datareader(file=FPATH)

FPATH=find.test.file('nomatch.csv')
RES=datareader(file=FPATH)

