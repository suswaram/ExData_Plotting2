#install plyr package if not installed
library(plyr)

#install ggplot2 package if not already installed
#install.packages("ggplot2")

library(ggplot2)

source("loadData.R")


# Task6 Compare emissions from motor vehicle sources in Baltimore 
# City with emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

# figuring out what SCC values represent motor vehicle-related sources
MotorRelated <- grep("On-Road", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% MotorRelated
SCCMotor <- subset(SCC, split == T)$SCC

# creating two  subsets of NEI dataset one for baltimore one for la
baltimore <- subset(NEI,NEI$fips == "24510")
la <- subset(NEI, NEI$fips == "06037")

# creating subsets of the two dataset, only contain motor vehicle related sources
split <- baltimore$SCC %in% SCCMotor
motorBaltimore <- subset(baltimore, split == T)
split <- la$SCC %in% SCCMotor
motorLa <- subset(la, split == T)

# calcuating total pm2.5 emissions per year
pm25MotorBaltimore <- ddply(motorBaltimore, .(year), summarise, totalEmissions = sum(Emissions))
pm25MotorLa <- ddply(motorLa, .(year), summarise, totalEmissions = sum(Emissions))

# combining the data sets
pm25MotorBaltimore$location <- "Baltimore"
pm25MotorLa$location <- "Los Angeles County"
two <- rbind(pm25MotorLa, pm25MotorBaltimore)

# creating the plot
png("plot6.png", width = 640, height = 640)

g <- qplot(year, totalEmissions, data = two, color = location, geom = c("point","line"))
g + geom_point(size = 4)+labs(y = "Total PM2.5 Emissions", title = "Motor Vehicle Related PM2.5 Emissions Per Year in Baltimore and Los Angeles County")

ggsave('plot6.png')

dev.off()