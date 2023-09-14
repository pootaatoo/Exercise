# press "ctrl+L"
rm(list = ls())

#### 1 ####
library(dplyr)
acs <- fread("getdata_data_ss06hid.csv", sep=",")
acs <- acs %>% 
  mutate(agricultureLogical = (ACR == 3 & AGS == 6))
which(acs$agricultureLogical == T)

#### 2 ####
library(jpeg)
pic <- readJPEG("getdata_jeff.jpeg", native = T)
quantile(pic, c(0.3, 0.8))

#### 3 ####
library()
GDP <- read.csv("getdata_data_GDP.csv", header = F, skip = 5, nrows = 190)
GDP <- select(GDP, c(1,2,4,5))
colnames(GDP)  <- c('CountryCode', 'Ranking', 'Economy', 'GDP')

EDS <- read.csv("getdata_data_EDSTATS_Country.csv")

mergeDF <- merge(GDP, EDS, by="CountryCode", all = FALSE)
nrow(mergeDF)
sortedDF <- arrange(mergeDF, desc(Ranking))
sortedDF[13,"Economy"]

#### 4 ####
library(dplyr)

groupedDF <- group_by(mergeDF, Income.Group)
avgRankings<- summarize(groupedDF, agvGDP = mean(Ranking))
filter(avgRankings, Income.Group %in% c('High income: nonOECD', 'High income: OECD'))

#### 5 ####
cutGDP <- cut2(sortedDF$Ranking, g=5)
table(cutGDP, sortedDF$Income.Group)
