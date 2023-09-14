rm(list = ls())

### Reading mySQL
lapply(dbListConnections(MySQL()), dbDisconnect)

library(RMySQL)

# Create a connection
ucsbDb <- dbConnect(MySQL(), user = 'genome', host = 'genome-mysql.cse.ucsc.edu')

# Perform operations with the connection
result <- dbGetQuery(ucsbDb, 'show databases;')

# Close the connection when done
dbDisconnect(ucsbDb)

hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
affyData <- dbListFields(hg19, "affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMiss <- fetch(query)
quantile(affyMiss$misMatches)

affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dim(affyMisSmall)

### Reading HDF5
library(rhdf5)
file <- h5createFile("example.h5")
A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1), dim = c(5,2,2))
attr(B,"scale") <- "liter"
created = h5createGroup("example.h5","foo/foobaa")
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

df = data.frame(1L:5L, seq(0,1, length.out=5),
                c("ab","cde","fghi","a","s"),stringsAsFactors = FALSE)

### Reading data from the web
con = url("https://scholar.google.com/citations?user=WSPk5JQAAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(httr) 
library(XML)
url <- "http://scholar.google.com/citations?user=WSPk5JQAAAAJ&hl=en"                
r <- GET(url)
html <- htmlTreeParse(r, useInternalNodes = T)
writeLines(as.character(html),"test.txt")
xpathSApply(html, "//title", xmlValue)
#xpathSApply(html,"//td[@id='col-citedby']",xmlValue)

library(XML)
url="http://web.archive.org/web/20130207021632/http://scholar.google.com:80/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes=TRUE)
xpathSApply(html,"//title",xmlValue)
xpathSApply(html,"//td[@id='col-citedby']",xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2,asText = T)
xpathSApply(parsedHtml,"//title",xmlValue)

pg1 = GET("http://htttpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg1
names(pg1)

google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

## Reading data from APIs
myapp = oauth_app("twitter",
                  key = "yourConsumerKeyHere",secret = "yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

library(jsonlite)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
