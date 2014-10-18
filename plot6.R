# R Script for generating ExData Project#2, plot6.png

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


# subset to leave just Baltimore and Los Angeles data
NEIb = subset(NEI, fips %in% c("24510","06037") )

# Merge() will drop any Baltimore or LA data not matching selected Motor Vehicle SCC codes
p6sub = merge(NEIb, mvcats)

# Aggregate data by year to get sum of emissions by year for all Motor Vehicle SCC categories
p6data = aggregate(Emissions ~ year + fips, p6sub,sum, na.rm=T)
names(p6data)[1] <- "Year"

#Replace fips numbers with county names -- there must be a better way to do this, but it's late!
lookup=cbind(c("24510","06037"),c("Baltimore","Los Angeles"))
colnames(lookup) = c("fips","County")
p6data = merge(p6data,lookup)


# Do the Plot!!
dev.off
png("plot6.png", width=480, height=480)

plot6 = qplot(Year, Emissions, data=p6data, geom=c("line","point"), color=County,
              main="PM2.5 Emissions from Motor Vehicle Sources, by Year\nBaltimore City (fips 24510) and Los Angeles County (fips 06037)", 
              ylab="Emissions (tons)") 
print(plot6)
dev.off()
