# This R script loads a data file called "household_power_consumption.txt" that contains several years
# of electrical usage data.
#
# The below code reads & subsets down the data set to just 2 days (2/1/2007 and 2/2/2007) of observations. 
# Then it plots 3 variables onto one plots using the basic plot() function in R to match the 
# Instructors plot. Lastly the completd plot is output to the working directory with the 
# filename "Plot3.png"
#
#The above mentioned file will need to be unzipped and placed in the root of your working directory or 
#use the "setwd" to a set the desired location of the file. 

fullwatts <- read.table("household_power_consumption.txt", header=T, sep=";", quote="\"")
twodaywatts=subset(fullwatts,Date=="1/2/2007"|Date=="2/2/2007")
twodaywatts$Date=as.Date(strptime(twodaywatts$Date,"%d/%m/%Y"))     #sets col to date format
twodaywatts$Sub_metering_3<-as.numeric(as.character(twodaywatts$Sub_metering_3))
twodaywatts$Sub_metering_2<-as.numeric(as.character(twodaywatts$Sub_metering_2))
twodaywatts$Sub_metering_1<-as.numeric(as.character(twodaywatts$Sub_metering_1))

png(filename = "Plot3.png", width = 480, height = 480)  #sets file to be written and pixel size 
plot(twodaywatts$Sub_metering_1,type="l",axes=F,xlab="",ylab="Energy sub metering")

box(lty=1) #adds solid box around plot
lines(twodaywatts$Sub_metering_2,col="RED")  #adds 2nd variable & specific color
lines(twodaywatts$Sub_metering_3,col="BLUE") #adds 3rd variable & specific color

# x axis labels determination#
tick=60*24                                                 #mins * hours in 1 day
day1=weekdays(twodaywatts$Date[1],abbreviate=T)              #looks up Day           
day2=weekdays(twodaywatts$Date[tick+1],abbreviate=T)
dayafter=weekdays((twodaywatts$Date[tick+1])+1,abbreviate=T)
axis(1,at=c(1,tick,tick*2),c(day1,day2,dayafter))           #adds x labels to plot

axis(2,at=c(0,10,20,30),c("0","10","20","30"))              #specifically set y axis
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("Black","RED","BLUE"), lty=1, bty="o")

dev.off()   # copy plot to file
