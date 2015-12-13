# This R script loads a data file called "household_power_consumption.txt" that contains several years
# of electrical usage data. The data file can be located at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# The below code reads & subsets down the data set to just 2 days (2/1/2007 and 2/2/2007) of observations. 
# Then it plots 4 seperate plots onto 1 page using the basic plot() function in R to match the reference plot. 
# Lastly, the completed plot is output to the working directory with the filename "Plot4.png"
#
# Note: The above mentioned data file will need to be unzipped and placed in the root of your working directory
# or use the "setwd" function to a set the desired location to the file. 
#
# To run this script, highlight this code and select "Run" in the upper right corner of this page's banner.

fullwatts <- read.table("household_power_consumption.txt", header=T, sep=";", quote="\"")
twodaywatts=subset(fullwatts,Date=="1/2/2007"|Date=="2/2/2007")
twodaywatts<-twodaywatts[complete.cases(twodaywatts),]                          #cleans out any "NA" or converted "?"
twodaywatts$Date=as.Date(strptime(twodaywatts$Date,"%d/%m/%Y"))                             #sets col to date format
twodaywatts$Global_active_power<-as.numeric(as.character(twodaywatts$Global_active_power))  #sets other col to numeric
twodaywatts$Voltage<-as.numeric(as.character(twodaywatts$Voltage))
twodaywatts$Sub_metering_3<-as.numeric(as.character(twodaywatts$Sub_metering_3))
twodaywatts$Sub_metering_2<-as.numeric(as.character(twodaywatts$Sub_metering_2))
twodaywatts$Sub_metering_1<-as.numeric(as.character(twodaywatts$Sub_metering_1))
twodaywatts$Global_reactive_power<-as.numeric(as.character(twodaywatts$Global_reactive_power))

png(filename = "Plot4.png", width = 480, height = 480)  #sets file to write & pixel size 
par(mfrow=c(2,2))  #  goes by row to fill 4 plots

## x axis "day" labels for plots##
tick=60*24                                                 #mins * hours in 1 day
day1=weekdays(twodaywatts$Date[1],abbreviate=T)              #looks up Day           
day2=weekdays(twodaywatts$Date[tick+1],abbreviate=T)
dayafter=weekdays((twodaywatts$Date[tick+1])+1,abbreviate=T)

##Plot 1 -Global Active Power##
  plot(twodaywatts$Global_active_power,type="l",xlab="",
  ylab="Global Active Power",axes=F)

  axis(2)  #adds back y labels
  box(lty=1) #adds solid box 
  axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))      #adds x labels to plot

##Plot 2-Voltage/datetime
  plot(twodaywatts$Voltage,type="l",axes=F,xlab="datetime",ylab="Voltage")

  box(lty=1) #solid box 
  axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))      #adds x labels to plot
  axis(2)

##Plot 3 -Energy sub metering##
  plot(twodaywatts$Sub_metering_1,type="l",axes=F,xlab="",ylab="Energy sub metering")

  box(lty=1) #adds solid box around plot
  lines(twodaywatts$Sub_metering_2,col="RED")  #adds 2nd var & specific color
  lines(twodaywatts$Sub_metering_3,col="BLUE") #adds 3rd var & specific color
  axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))  #adds x & y labels to plot
  axis(2,at=c(0,10,20,30),c("0","10","20","30"))
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=c("Black","RED","BLUE"), lty=1,cex=.95,bty="n")

##Plot 4 -Global_reactive_power & datetime##
  plot(twodaywatts$Global_reactive_power,type="l",axes=F,xlab="datetime",ylab="Global_reactive_power")

  box(lty=1) #solid box 
  axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))      #adds x labels to plot
  axis(2)

dev.off()   # copy plot to file
