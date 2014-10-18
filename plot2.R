# R Script for generating ExData Project#2, plot2.png

# SETUP: Assumes that files: summarySCC_PM25.rds and Source_Classification_Code.rds
# are in the working directory. 
# If not, the data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# must be downloaded and unZipped, with the two extracted rds files moved to the working directory.

#Save time if script has been run before by skipping readRDS() step
if (!exists("NEI") || !is.data.frame(NEI)) {
  message("Please wait . . . executing: NEI <- readRDS(\"summarySCC_PM25.rds\")")
  NEI <- readRDS("summarySCC_PM25.rds")
  }

  p2sub = subset(NEI, fips=="24510", select=c(year,Emissions))
  p2data = aggregate(p2sub, by=list(p2sub$year), FUN=sum, na.rm=T)
  names(p2data)[1] <- "Year"
  
dev.off
png("plot2.png")

# Create list for making 2-line main title on the plot in mtext() function below
mainlines = list("Total PM2.5 Emissions, Baltimore City, by Years","(thousands of tons)")


with(p2data, plot(Emissions/1000 ~ Year, type="b"))
mtext(mainlines,side=3,line=1:0, cex=c(1,0.8)) 
dev.off()