# extract SCC lines with motor vehicle sources
seg <- "Motor Vehicles|Motorcycles"
SCC_motor <- SCC[grep(seg,SCC$Short.Name),]

# extract lines in NEI_Bal based on the extracted SCC
NEI_motor_rows <- intersect(NEI_Bal$SCC, SCC_motor$SCC)
NEI_motor <- NEI_Bal[NEI_Bal$SCC %in% NEI_motor_rows,]

# calculate the sum of motor vehicle emissions of each year for Baltimore City
NEI_Bal_5 <- aggregate(Emissions ~ year, data = NEI_motor, FUN = sum)

# create plot 5 that shows the motor vehicle emissions of PM2.5 for Baltimore City
# from 1999 to 2008 and save it to an .png file
png("plot5.png", width = 800, height = 600)
plot5 <- barplot(NEI_Bal_5$Emissions, names.arg = NEI_Bal_5$year,
                 main = "Emissions from motor vehicle sources of PM2.5 in the Baltimore City",
                 xlab = "year", ylab = "PM2.5 (tons)",
                 ylim = c(0,0.6), col = NEI_Bal_5$year)
text(plot5, NEI_Bal_5$Emissions, label = round(NEI_Bal_5$Emissions, 2),
     pos = 3, cex = 1)
dev.off()
