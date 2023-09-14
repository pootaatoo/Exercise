# press "ctrl+L"
rm(list = ls())

##### Subsetting and sorting #####
set.seed(12345)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA
X
X[(X$var1 <=3 & X$var3 > 11),]
X[(X$var1 <=3 | X$var3 > 11),]
X[which(X$var2 > 8),]

sort(X$var1, decreasing = T)
sort(X$var1, na.last = T)
X[order(X$var1),]
X[order(X$var1,X$var3),]

library(plyr)
arrange(X,var1)
arrange(X,desc(var1))
X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))
Y

##### summarizing data #####
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/row.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/restaurants.csv",method = "curl")
restData <- read.csv("./data/restaurants.csv")

head(restData,n=3)
tail(restData,n=3)
summary(restData)
str(restData)

quantile(restData$councilDistrict, na.rm=T)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

table(restData$zipCode, useNA = "ifany")
table(restData$councileDistrict,restData$zipCode)

sum(is.na(restData$councileDistrict))
any(is.na(restData$councileDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt
# flat tables
ftable(xt)

# size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = 'Mb')

##### Creating new variables #####
s1 <- seq(1,10, by=2)
s2 <- seq(1,10, length=3)
x <- c(1,3,8,25,100)
seq(along=x)

# subsetting vars
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
# create binary vars
restData$zipWrong = ifelse(restData$zipCode< 0, T, F)
table(restData$zipWrong, restData$zipCode< 0)

# create categorical vars
restData$zipGroups= cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
# easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# create factor vars
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# levels of factors
yn <- sample(c("yes","no"), size = 10, replace = T)
ynfac = factor(yn, levels = c("yes","no"))
relevel(ynfac, ref = "yes")
as.numeric(ynfac)

# use the mutate function
library(Hmisc)
library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))

##### Reshaping data #####
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars = c("mpg","hp"))
head(carMelt, n=3)

# casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# average values
head(InsectSprays)
# tapply: apply along the index
tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
# lapply: apply across the list
sprCount = lapply(spIns, sum)
sprCount

unlist(sprCount)
sapply(spIns, sum)

# use plyr package
library(plyr)
ddply(InsectSprays, .(spray), summarise, sum=sum(count))

# create a new variable
spraySums <- ddply(InsectSprays, .(spray), summarise, sum=ave(count, FUN = sum))
dim(spraySums)
head(spraySums)

# dplyr
library(dplyr)
chicago <- readRDS("chicago.rds")
dim(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[,-(i:j)])
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)

chicago <- arrange(chicago, desc(date))

chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)

chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = T))
head(select(chicago, pm25, pm25detrend))

chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), label = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)

summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(data)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% 
  group_by(month) %>% 
  summarize(pm25 = mean(pm25, na,rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))

##### Merging data #####
mergedData = merge(review, solution, by.x="solution_id", by.y="id", all= T)
intersect(names(solution), names(review))

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2), id)

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
df3 = data.frame(id=sample(1:10), z=rnorm(10))
dflist = list(df1, df2, df3)
join_all(dflist)
