rm(list = ls())

library(dplyr)
# read data from the file
dta <- read.table("../household_power_consumption.txt",header = T, sep = ";")

# brief check the data
names(dta)
head(dta)
str(dta)

# extract a subset of data from dates 2007-02-01 and 2007-02-02
dta_subset <- filter(dta, Date=="1/2/2007" | Date=="2/2/2007")

# create plot 1 and save it to an .png file
png("plot1.png", width = 800, height = 600)
dta_subset$Global_active_power <- as.numeric(dta_subset$Global_active_power)
hist(dta_subset$Global_active_power, col="red", xlab="Global Active Power(kilowatts)",
              ylab="Frequency", main="Global Active Power")
dev.off()
