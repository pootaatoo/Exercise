rm(list = ls())

##### Edit text vars #####
acs <- fread("getdata_data_ss06pid.csv", sep=",")
names(acs)
tolower(names(acs))
splitNames = strsplit(names(acs), "\\tp")
splitNames[[160]]

mylist <- list(letters =  c("A","B","C"), numbers = 1:3, matrix(1:25, ncol=5))
head(mylist)
mylist[1]
mylist[[1]]

splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

# subtract characters from the names
sub("pwgtp","",names(acs),)

gsub("_","", "this_is_a_test")

grep("P", acs$RT)

table(grepl("P", acs$RT))

acs[!grepl("P",acs$RT),]

grep("P", acs$RT, value = T)
length(grep("P",acs$RT))

library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1, 7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff     ")

##### Working with dates #####
d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)

format(d2, "%a, %b, %d")

x = c("1jan1960","2jan1960","31mar1960","30jul1960")
z = as.Date(x, "%d%b%Y")
z[1] - z[2]
as.numeric(z[1] - z[2])

weekdays(d2)
months(d2)
julian(d2)

library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("08/04/2013")

ymd_hms("2011-08-03 10:15:23")
ymd_hms("2011-08-03 10:15:23", tz="Pacific/Auckland")
?Sys.timezone

x = dmy(x)
wday(x[1])
wday(x[1], label = T)
