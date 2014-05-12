#install plyr package if not installed
library(plyr)

#run loadData.R first


# Task5 How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# figuring out what SCC values represent motor vehicle-related sources
MotorRelated <- grep("On-Road", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% MotorRelated
SCCMotor <- subset(SCC, split == T)$SCC

# creating a subset of NEI dataset, only contain data in baltimore
baltimore <- subset(NEI,NEI$fips == "24510")

# creating a subset of the baltimore dataset, only contain motor vehicle related sources in Baltimore
split <- baltimore$SCC %in% SCCMotor
motorBaltimore <- subset(baltimore, split == T)

# calcuating total pm2.5 emissions per year
pm25Motor <- ddply(motorBaltimore, .(year), summarise, totalEmissions = sum(Emissions))

# creating plot
png("plot5.png", width = 480, height = 480)

plot(pm25Motor$year,pm25Motor$totalEmissions, xlab="Year", ylab = "Total PM2.5 Emission", pch = 19, col = "cyan")

linreg <- lm(pm25Motor$totalEmissions ~ pm25Motor$year)
abline(linreg)

title(main= "Total PM2.5 Emissions From Motor Vehicle Related Sources In Baltimore")

dev.off()