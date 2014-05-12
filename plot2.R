#install plyr package if not already installed
# install.packages("plyr")

library(plyr)

source("loadData.R")

# Task 2 Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.

# create subset only contain data about baltimore
baltimore <- subset(NEI,NEI$fips == "24510")

# calculating total emissions for each year in baltimore
pm25Baltimore <- ddply(baltimore, .(year), summarise, totalEmissions = sum(Emissions))

# creating the plot
png("plot2.png", width = 480, height = 480)

plot(pm25Baltimore$year,pm25Baltimore$totalEmissions, xlab="Year", ylab = "Total PM2.5 Emissions", pch = 19, col = "blue")
linreg <- lm(pm25Baltimore$totalEmissions ~ pm25Baltimore$year)
abline(linreg)
title(main="Total PM2.5 Emissions Per Year in Baltimore")

dev.off()