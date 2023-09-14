rm(list = ls())

# 1
Q1Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
Q1 <- read.csv(Q1Url)
Q1
Q1_colnames <- names(Q1)
strsplit(Q1_colnames, "^wgtp")[[123]]

# 2
Q2_File <- read.csv("getdata_data_GDP.csv", nrow = 190, skip = 4)
Q2_File <- Q2_File[,c(1, 2, 4, 5)]
colnames(Q2_File) <- c("CountryCode", "Rank", "Country", "Total")
Q2_File
Q2_File$Total <- as.integer(gsub(",", "", Q2_File$Total))
mean(Q2_File$Total, na.rm = T)

# 3
Q2_File$Country <- as.character(Q2_File$Country)
Q2_File$Country[grep("^United", Q2_File$Country)]

# 4
library(data.table)

Q4GDP <- fread("getdata_data_GDP.csv", skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "Economy", "Total"))
Q4Edu <- fread("getdata_data_EDSTATS_Country.csv")
Q4_Merge <- merge(Q4GDP, Q4Edu, by = 'CountryCode')
Q4_Merge
FiscalJune <- grep("Fiscal year end: June", Q4_Merge$`Special Notes`)
NROW(FiscalJune)

# 5
library(quantmod)
amzn = getSymbols("AMZN", auto.assign = F)
sampleTimes = index(amzn)
library(lubridate)
amzn = getSymbols("AMZN", auto.assign = F)
sampleTimes = index(amzn)
amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)
NROW(amzn2012[weekdays(amzn2012) == "Monday"])