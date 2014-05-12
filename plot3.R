#install plyr package if not installed
library(plyr)

#install ggplot2 package if not already installed
#install.packages("ggplot2")

library(ggplot2)

source("loadData.R")

# Task3 Of the four types of sources indicated by the type (point,
# nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999¨C2008 for Baltimore City?
# Which have seen increases in emissions from 1999¨C2008? Use the 
# ggplot2 plotting system to make a plot for this assignment.


# create subset only contain data about baltimore
baltimore <- subset(NEI,NEI$fips == "24510")

# calculating different sources' contribution to total emission
pm25TypeBaltimore <- ddply(baltimore, .(year, type), summarise, totalEmissions = sum(Emissions))

# creating the plot
png("plot3.png", width = 800, height = 600)

g <- qplot(year, totalEmissions, data = pm25TypeBaltimore, facets = .~type)
g + geom_point(aes(color = type), size = 4) + labs(y = "Total PM2.5 Emissions", title = "Sources of PM2.5 Emissions Per Year in Baltimore")
ggsave('plot3.png')
dev.off()