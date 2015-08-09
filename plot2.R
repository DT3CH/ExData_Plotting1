



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



##create plot of Global active power vs DateTime


plot(subData$Global_active_power~subData$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
