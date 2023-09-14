# extract SCC lines with coal combustion-related sources
seg <- "Fuel Comb.*Coal"
SCC_coal <- SCC[grep(seg,SCC$EI.Sector),]

# extract lines in NEI based on the extracted SCC
NEI_coal_rows <- intersect(NEI$SCC, SCC_coal$SCC)
NEI_coal <- NEI[NEI$SCC %in% NEI_coal_rows,]

# calculate the sum of emissions of each year
NEI_4 <- aggregate(Emissions ~ year, data = NEI_coal, FUN = sum)

# create plot 4 that shows the total PM2.5 emission from coal combustion-related
# sources from 1999 to 2008 and save it to an .png file
png("plot4.png", width = 800, height = 600)
plot4 <- barplot(NEI_4$Emissions/1000, names.arg = NEI_4$year,
                 main = "Total emissions of PM2.5 from coal combustion-related sources in the US",
                 xlab = "year", ylab = "PM2.5 (kilotons)",
                 ylim = c(0,600), col = NEI_4$year)
text(plot4, NEI_4$Emissions/1000, label = round(NEI_4$Emissions/1000),
     pos = 3, cex = 1)
dev.off()

