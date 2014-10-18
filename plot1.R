# R Script for generating ExData Project#2, plot1.png

# SETUP: Assumes that files: summarySCC_PM25.rds and Source_Classification_Code.rds
# are in the working directory. 
# If not, the data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# must be downloaded and unZipped, with the two extracted rds files moved to the working directory.

#Save time if script has been run before by skipping readRDS() step
if (!exists("NEI") || !is.data.frame(NEI)) {
  message("Please wait . . . executing: NEI <- readRDS(\"summarySCC_PM25.rds\")")
  NEI <- readRDS("summarySCC_PM25.rds")

}

if (!exists("p1data") || !is.data.frame(p1data)) {
  message("Please wait . . . executing: 
    p1data = aggregate(NEI$Emissions, list(Year=NEI$year), sum)")
  p1data = aggregate(NEI$Emissions, list(Year=NEI$year), sum)
  names(p1data)[2] <- "Emissions"
  
}


dev.off
png("plot1.png")

# Create list for making 2-line main title on the plot in mtext() function below
mainlines = list("Total PM2.5 Emissions, All US Counties, by Years","(thousands of tons)")


with(p1data, plot(Emissions/1000 ~ Year, type="b"))
mtext(mainlines,side=3,line=1:0, cex=c(1,0.8)) 

dev.off()


