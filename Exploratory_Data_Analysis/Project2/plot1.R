rm(list = ls())

# unzip the data files
unzip(zipfile = '../data/exdata_data_NEI_data.zip')

# read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds")

# brief check the data 
head(NEI)
unique(NEI$Pollutant)
sum(is.na(NEI))

head(SCC)
names(SCC)

# calculate total of emissions for each year
NEI_total <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

# create plot 1 that shows the total PM2.5 emission from all sources for each of
# the years 1999, 2002, 2005, and 2008 and save it to an .png file
png("plot1.png", width = 800, height = 600)
plot1 <- barplot(NEI_total$Emissions/1000, names.arg = NEI_total$year,
     main = "Total emissions from PM2.5 in the US",
     xlab = "year", ylab = "PM2.5 (kilotons)",
     ylim = c(0,8000), col = NEI_total$year)
text(plot1, NEI_total$Emissions/1000, label = round(NEI_total$Emissions/1000),
     pos = 3, cex = 1)
dev.off()


