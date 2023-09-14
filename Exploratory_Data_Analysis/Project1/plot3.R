rm(list = ls())

library(dplyr)
# read data from the file
dta <- read.table("../household_power_consumption.txt",header = T, sep = ";")

# brief check the data
names(dta)
head(dta)
str(dta)
sum(is.na(dta))

# extract a subset of data from dates 2007-02-01 and 2007-02-02
dta_subset <- filter(dta, Date=="1/2/2007" | Date=="2/2/2007")

# add an extra point of 2007-02-03 00:00:00 to show the beginning of Saturday
extra <- filter(dta, Date=="3/2/2007" & Time=="00:00:00")
dta_subset <- rbind(dta_subset, extra)
rm(dta)

# change dates format
dta_subset$Date <- as.Date(dta_subset$Date, format = "%d/%m/%Y")
dta_subset$Time <- as.POSIXct(dta_subset$Time, format = "%H:%M:%S")

# Combine date and time
dta_subset$combined_datetime <- as.POSIXct(paste(dta_subset$Date, format(dta_subset$Time, "%H:%M:%S")))
dta_subset$Global_active_power <- as.numeric(dta_subset$Global_active_power)

# create plot 3 and save it to an .png file
png("plot3.png", width = 800, height = 600)
dta_subset$combined_datetime <- as.numeric(dta_subset$combined_datetime)

plot(dta_subset$combined_datetime, dta_subset$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering", xaxt = "n", col = "black")
lines(dta_subset$combined_datetime, dta_subset$Sub_metering_2, col = "red")
lines(dta_subset$combined_datetime, dta_subset$Sub_metering_3, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1)

selected_ticks <- seq(from = 1, to = nrow(dta_subset), by = floor(nrow(dta_subset)/2))
axis(1, at = dta_subset$combined_datetime[selected_ticks], labels = c("Thu","Fri","Sat"), las = 2)

dev.off()
