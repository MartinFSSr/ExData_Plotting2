# R Script for generating ExData Project#2, plot5.png

# SETUP: Assumes that files: summarySCC_PM25.rds and Source_Classification_Code.rds
# are in the working directory. 
# If not, the data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# must be downloaded and unZipped, with the two extracted rds files moved to the working directory.


require("ggplot2")

#Save time if script has been run before by skipping readRDS() step
if (!exists("NEI") || !is.data.frame(NEI)) {
  message("Please wait . . . executing: NEI <- readRDS(\"summarySCC_PM25.rds\")")
  NEI <- readRDS("summarySCC_PM25.rds")
}
SCCs = readRDS("Source_Classification_Code.rds")


# Selection criteria for "Motor Vehicle" emissions sources
mvcats = subset(SCCs, grepl("[Mm]obile",EI.Sector) & grepl("[Vv]ehicles", EI.Sector ))


# subset to leave just Baltimore data
NEIb = subset(NEI, fips=="24510")

# Merge() will drop any Baltimore data not matching selected Motor Vehicle SCC codes
p5sub = merge(NEIb, mvcats)

# Aggregate data by year to get sum of emissions by year for all Motor Vehicle SCC categories
p5data = aggregate(Emissions ~ year, p5sub,sum, na.rm=T)
names(p5data)[1] <- "Year"

# Do the Plot!!
dev.off
png("plot5.png", width=480, height=480)

plot5 = qplot(Year, Emissions, data=p5data, geom=c("line","point"), 
              main="PM2.5 Emissions from Motor Vehicle Sources, by Year\nBaltimore City", 
              ylab="Emissions (tons)") 
print(plot5)
dev.off()

