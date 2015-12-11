# This R script loads a data file called "household_power_consumption.txt" that contains several years
# of electrical usage data.
#
# The below code reads & subsets down the data set to just 2 days (2/1/2007 and 2/2/2007) of observations. 
# Then it plots using the basic plot (histogram) option in R to match the Instructors plot. 
# Lastly it outputs the completed plot to the working directory with the filename "Plot1.png"
#
#The above mentioned file will need to be unzipped and placed in the root of your working directory or 
#use the "setwd" to a set the desired location of this file. 

fullwatts <- read.table("household_power_consumption.txt", header=T, sep=";", quote="\"")
twodaywatts<-subset(fullwatts,Date=="1/2/2007"|Date=="2/2/2007")
twodaywatts$Global_active_power<-as.numeric(as.character(twodaywatts$Global_active_power)) 

png(filename = "Plot1.png", width = 480, height = 480)  #sets file to be written and pixel size 

hist(twodaywatts$Global_active_power,col="RED",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()   # copy plot to file