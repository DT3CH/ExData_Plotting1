##read data.txt file and use only feb 1 - feb 2 2007 records

initialdata <- read.table("household_power_consumption.txt", header = TRUE 
                          ,sep = ";" , na.strings = "?", 
                          colClasses = c("character","character", "numeric", "numeric", 
                                         "numeric", "numeric", "numeric","numeric",
                                         "numeric"), comment.char = "")
#format Date column
initialdata$Date <- as.Date(initialdata$Date, format = "%d/%m/%Y")

#subset table
subData <- subset(initialdata, subset = (Date >="2007-02-01" & Date <= "2007-02-02"))
rm(initialdata)

#create full date / time column
fullDate <- paste(as.Date(subData$Date), subData$Time)
subData$DateTime <- as.POSIXct(fullDate)



## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subData, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
