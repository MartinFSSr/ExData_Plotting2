# R Script for generating ExData Project#2, plot3.png

# SETUP: Assumes that files: summarySCC_PM25.rds and Source_Classification_Code.rds
# are in the working directory. 
# If not, the data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# must be downloaded and unZipped, with the two extracted rds files moved to the working directory.

#Save time if script has been run before by skipping readRDS() step
if (!exists("NEI") || !is.data.frame(NEI)) {
  message("Please wait . . . executing: NEI <- readRDS(\"summarySCC_PM25.rds\")")
  NEI <- readRDS("summarySCC_PM25.rds")
}

p3sub = subset(NEI, fips=="24510")
p3data = aggregate(Emissions ~ type + year, p3sub,sum, na.rm=T)
names(p3data)[1:2] <- c("Type","Year")

dev.off
png("plot3.png")

# 2-line main title on the plot
mainlines = c("PM2.5 Emissions, by Year and Type\nBaltimore City")

plot3 = qplot(Year, Emissions, data=p3data, geom="line", color=Type, 
      main=mainlines, ylab="Emissions (tons)") 
print(plot3)
dev.off()
