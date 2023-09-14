rm(list = ls())

library(XML)
file <- "w3schools.com_xml_simple.xml"
doc <- xmlTreeParse(file, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

names(rootNode)

rootNode[[1]][[2]]

xmlSApply(rootNode, xmlValue)

xpathSApply(rootNode, '//name', xmlValue)

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
myjason <- toJSON(iris, pretty = TRUE)
cat(myjason)
iris2 <- fromJSON(myjason)
head(iris2)

library(data.table)
df = data.frame(x=rnorm(9), y=(rep(c(2,2,2), each=3)),z=rnorm(9))
head(df,3)
ls.str(df)
#tables()
df[2,]
df[df$y=="a",]
df[,c(2,3)]

{
  x = 1
  y = 2
}
k = {print(10);5}
print(k)

mean(df$x)
df[,table(y)]

df[,w:=z^2]

df[,m:= {tmp <- (x+z); log2(tmp+5)}]

df[,a:=x>0]
df[,b:=mean(x+w),by=a]

set.seed(123)
dt <- data.table(x=sample(letters[1:3],1E5,TRUE))
dt[,.N, by=x]

# key
dt <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
setkey(dt, x)
dt['a']

# fast reading
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df,file=file,row.names = FALSE, col.names = TRUE, sep = "\t",
            quote = FALSE)
system.time(fread(file))
