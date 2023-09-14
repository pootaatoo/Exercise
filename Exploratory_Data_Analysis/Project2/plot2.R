library(dplyr)

# extract emissions in the Baltimore City
NEI_Bal <- filter(NEI, fips == "24510")

# calculate total of emissions for each year
NEI_Bal_total <- aggregate(Emissions ~ year, data = NEI_Bal, FUN = sum)

# create plot 2 that shows the total PM2.5 emission of the Baltimore City from
# 1999 to 2008 and save it to an .png file
png("plot2.png", width = 800, height = 600)
plot2 <- barplot(NEI_Bal_total$Emissions, names.arg = NEI_Bal_total$year,
                 main = "Total emissions from PM2.5 in the Baltimore City, MD",
                 xlab = "year", ylab = "PM2.5 (tons)",
                 ylim = c(0,4000), col = NEI_Bal_total$year)
text(plot2, NEI_Bal_total$Emissions, label = round(NEI_Bal_total$Emissions),
     pos = 3, cex = 1)
dev.off()
