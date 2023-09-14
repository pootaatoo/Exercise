rm(list = ls())
dt <- read.csv('getdata_data_ss06hid.csv')
length(which(dt$VAL == 24))

dt$FES
table(dt$FES)

library(openxlsx)
dat <- read.xlsx('getdata_data_DATA.gov_NGAP.xlsx',
                 rows = c(18:23), cols = c(7:15))
sum(dat$Zip*dat$Ext, na.rm = T)

library(XML)
file <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
my.doc <- xmlTreeParse(file=file,useInternal=TRUE)
root.Node <- xmlRoot(my.doc)
xmlName(root.Node)

zipcode <- xpathSApply(root.Node, "//zipcode", xmlValue)
length(zipcode[zipcode==21231])

rm(list = ls())
DT <- fread("getdata_data_ss06pid.csv", sep=",")
a <- vector("numeric", length = 6)
library(data.table)
a[1] <- system.time(mean(DT$pwgtp15,by=DT$SEX))["user.self"]
library(data.table)
a[2] <- system.time(tapply(DT$pwgtp15,DT$SEX,mean))["user.self"]
library(data.table)
a[3] <- system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))["user.self"]
library(data.table)
a[4] <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))["user.self"]
library(data.table)
a[5] <- system.time(DT[,mean(pwgtp15),by=SEX])["user.self"]
library(data.table)
a[6] <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))["user.self"]

which.min(a)
