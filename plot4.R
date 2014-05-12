#install plyr package if not installed
library(plyr)

#install ggplot2 package if not already installed
#install.packages("ggplot2")

library(ggplot2)

source("loadData.R")


# Task4 Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999 t0 2008?

# figuring out what SCC values represent coal combustion-related sources
CoalRelated <- grep("Coal", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% CoalRelated
SCCCoal <- subset(SCC, split == T)$SCC

# creating a subset of the NEI dataset, only contain coal combustion-related sources
split <- NEI$SCC %in% SCCCoal
coal <- subset(NEI, split == T)

# calcuating total pm2.5 emissions per year
pm25Coal <- ddply(coal, .(year), summarise, totalEmissions = sum(Emissions))

# creating plot
png("plot4.png", width = 480, height = 480)

plot(pm25Coal$year,pm25Coal$totalEmissions, xlab="Year", ylab = "Total PM2.5 Emission", pch = 19, col = "magenta")
linreg <- lm(pm25Coal$totalEmissions ~ pm25Coal$year)
abline(linreg)

title(main= "Total PM2.5 Emissions From Coal Combustion Related Sources")

dev.off()