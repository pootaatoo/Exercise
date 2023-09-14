library(dplyr)
library(ggplot2)

# extract emissions in the LA County
NEI_LA <- filter(NEI, fips == "06037")

# extract lines in NEI_LA based on the extracted SCC
NEI_motor_rows_LA <- intersect(NEI_LA$SCC, SCC_motor$SCC)
NEI_motor_LA <- NEI_LA[NEI_LA$SCC %in% NEI_motor_rows_LA,]

# calculate the sum of motor vehicle emissions of each year for LA County and
# combine with Baltimore City
NEI_LA_6 <- aggregate(Emissions ~ year, data = NEI_motor_LA, FUN = sum)
NEI_LA_6 <- NEI_LA_6 %>% mutate(city = "LA County")
NEI_Bal_5 <- NEI_Bal_5 %>% mutate(city = "Baltimore City")
NEI_6 <- rbind(NEI_LA_6, NEI_Bal_5)

# create plot 6 that compares the motor vehicle emissions of PM2.5 for Baltimore City
# and LA County from 1999 to 2008 and save it to an .png file
plot6 <- ggplot(NEI_6, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(stat = "identity") + facet_grid(. ~ city) +
  labs(title = "Emissions from motor vehicle sources in Baltimore City vs. LA County", 
       x = "year", y = "PM2.5 (tons)") +
  theme_classic()
ggsave("plot6.png", plot = plot6, width = 7, height = 3)

