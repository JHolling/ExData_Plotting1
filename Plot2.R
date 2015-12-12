# This R script loads a data file called "household_power_consumption.txt" that contains several years
# of electrical usage data.
#
# The below code reads & subsets down the data set to just 2 days (2/1/2007 and 2/2/2007) of observations. 
# Then it plots using the basic plot() function in R. Lastly it outputs the completed 
# plot to the working directory with the filename "Plot2.png"
#
#The above mentioned data file will need to be unzipped and placed in the root of your working directory or 
#use the "setwd" function to a set the desired location to these files. 

# To Run this script, highlight all the code and select the "Run" button
# the upper left of this screen.

fullwatts <- read.table("household_power_consumption.txt", header=T, sep=";", quote="\"")
twodaywatts=subset(fullwatts,Date=="1/2/2007"|Date=="2/2/2007")
twodaywatts<-twodaywatts[complete.cases(twodaywatts),] #cleans out any "NA" or converted "?"
twodaywatts$Global_active_power<-as.numeric(as.character(twodaywatts$Global_active_power))
twodaywatts$Date=as.Date(strptime(twodaywatts$Date,"%d/%m/%Y"))       #sets col to date format

png(filename = "Plot2.png", width = 480, height = 480)  #sets file to be written and pixel size 
plot(twodaywatts$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",axes=F)

# x axis labels determination#
tick=60*24                                                 #mins * hours in 1 day
day1=weekdays(twodaywatts$Date[1],abbreviate=T)              #looks up Day           
day2=weekdays(twodaywatts$Date[tick+1],abbreviate=T)
dayafter=weekdays((twodaywatts$Date[tick+1])+1,abbreviate=T)
axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))          #adds x labels to plot

axis(2)                                                    #adds back y labels
box(lty=1) #adds solid box 

dev.off()   # copy plot to file
