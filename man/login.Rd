\name{login}
\alias{login}
\title{
login
}
\description{
establis SSH connect to your google gmail account 
}
\usage{
 login(gmail='you@gmail.com', password='xyz')
}

\arguments{
  \item{gmail}{
   your gmail email 
}
  \item{password}{
  your gmail password 
}
}

\details{
it initialise *Rcurl* connection channel 
}



\author{
chris okugami
}

\note{
Google API has limitation of 10,000 requests per day, 10 concurrent connection per IP. If you exceed this request, you will get locked for future query. See more detail about "quote limit error" in google API restrictin. Workaround?? you wait a day to clear this lock! or restart your computer !  
}

\seealso{
Google API restriction 
https://developers.google.com/analytics/devguides/config/mgmt/v3/limits-quotas
}

\examples{
## Login ----

  
}
