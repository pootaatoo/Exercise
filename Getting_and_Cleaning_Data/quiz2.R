##### 1 #######
rm(list = ls())

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "95231af5276ad45db80a",
                   secret = "33e0628ba47b74cf08c1fc3fcec0b302e569127d"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

##### 2 #######
rm(list = ls())
library(data.table)
library(sqldf)
acs <- fread("getdata_data_ss06pid.csv", sep=",")
sqldf("select pwgtp1 from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs")
sqldf("select * from acs where AGEP < 50")

##### 4 #######
con = url("https://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode
nchar(htmlCode)[100]

##### 5 #######
library(utils)
column_widths <- c(10, 5, 5, 5, 7, 6)
data <- read.fwf("getdata_wksst8110.f", widths = column_widths)
head(data)
data <- as.numeric(data[5:nrow(data), 5])
sum(data)
