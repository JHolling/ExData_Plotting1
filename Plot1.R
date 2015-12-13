# This R script loads a data file called "household_power_consumption.txt" that contains several years
# of electrical usage data. The data file can be located at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# The below code reads & subsets down the data set to just 2 days (2/1/2007 and 2/2/2007) of observations. 
# Then it plots using the basic plot (histogram) option in R to match the reference plot. 
# Lastly it outputs the completed plot to the working directory with the filename "Plot1.png"
#
# The above mentioned data file will need to be unzipped and placed in the root of your working directory or 
# use the "setwd" function to a set the desired location to this file.

# To Run this script, highlight all the code and select the "Run" button
# the upper left of this screen.

fullwatts <- read.table("household_power_consumption.txt", header=T, sep=";", quote="\"")
twodaywatts<-subset(fullwatts,Date=="1/2/2007"|Date=="2/2/2007")
twodaywatts<-twodaywatts[complete.cases(twodaywatts),] #cleans out any "NA" or converted "?"
twodaywatts$Global_active_power<-as.numeric(as.character(twodaywatts$Global_active_power)) 

png(filename = "Plot1.png", width = 480, height = 480)  #sets file to be written and pixel size 

hist(twodaywatts$Global_active_power,col="RED",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()   # copy plot to file
