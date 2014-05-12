#install plyr package if not already installed
# install.packages("plyr")
library(plyr)

#Run loadData.R first

# task 1 Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot showing
# the total PM2.5 emission from all sources for each of the years 1999, 
# 2002, 2005, and 2008.

# calculate total pm2.5 emissions for each year
pm25 <- ddply(NEI, .(year), summarise, totalEmissions = sum(Emissions))

# creating plots
png("plot1.png", width = 480, height = 480)

plot(pm25$year,pm25$totalEmissions,xlab="Year", ylab = "Total PM2.5 Emissions", pch = 19, col = "blue")
linreg <- lm(pm25$totalEmissions ~ pm25$year)
abline(linreg)
title(main = "Total PM2.5 Emissions Per Year")

dev.off()
