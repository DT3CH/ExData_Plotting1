##read data.txt file and use only feb 1 - feb 2 2007 records

initialData <- read.table("household_power_consumption.txt", header = TRUE 
                          ,sep = ";" , na.strings = "?", 
                          colClasses = c("character","character", "numeric", "numeric", 
                                         "numeric", "numeric", "numeric","numeric",
                                         "numeric"), comment.char = "")
#format Date column
initialData$Date <- as.Date(initialData$Date, format = "%d/%m/%Y")

#subset table
subData <- subset(initialData, subset = (Date >="2007-02-01" & Date <= "2007-02-02"))
rm(initialData)

#create full date / time column
fullDate <- paste(as.Date(subData$Date), subData$Time)
subData$DateTime <- as.POSIXct(fullDate)


#line plot of Global Active power vs Sub_metering
with(subData, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
