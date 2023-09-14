library(ggplot2)

# calculate the sum of emissions for different types of each year
NEI_Bal_3 <- aggregate(Emissions ~ year + type, data = NEI_Bal, FUN = sum)

# create plot 3 that shows the different types of PM2.5 emission of the Baltimore
# City from 1999 to 2008 and save it to an .png file
plot3 <- ggplot(NEI_Bal_3, aes(x = factor(year), y = Emissions, fill = type)) +
  geom_bar(stat = "identity") + facet_grid(. ~ type) +
  labs(title = "Emissions from PM2.5 in the Baltimore City, MD", 
       x = "year", y = "PM2.5 (tons)") +
  theme_classic()
ggsave("plot3.png", plot = plot3, width = 8, height = 3)
