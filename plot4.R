# R Script for generating ExData Project#2, plot4.png

# SETUP: Assumes that files: summarySCC_PM25.rds and Source_Classification_Code.rds
# are in the working directory. 
# If not, the data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# must be downloaded and unZipped, with the two extracted rds files moved to the working directory.

#Save time if script has been run before by skipping readRDS() step
if (!exists("NEI") || !is.data.frame(NEI)) {
  message("Please wait . . . executing: NEI <- readRDS(\"summarySCC_PM25.rds\")")
  NEI <- readRDS("summarySCC_PM25.rds")
}
SCCs = readRDS("Source_Classification_Code.rds")
coalcats = subset(SCCs, grepl(".[Cc]oal.",Short.Name) & grepl(".[Cc]omb.",Short.Name))

p4sub = merge(NEI, coalcats)

p4data = aggregate(Emissions ~ year, p4sub,sum, na.rm=T)
names(p4data)[1] <- "Year"

dev.off
png("plot4.png")

# 2-line main title on the plot
mainlines = c("Nationwide PM2.5 Emissions, by Year\nFrom Coal Combustion Sources")

plot4 = qplot(Year, Emissions/1000, data=p4data, geom="line", 
              main=mainlines, ylab="Emissions (1,000 tons)") 
print(plot4)
dev.off()