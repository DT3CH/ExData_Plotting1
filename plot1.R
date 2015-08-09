## Project 1 Exploratory Analysis
## Graph 1 Generate bar plot for Machine Learning Data
##Plot1.R


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

##create bar plot of x- Global Active Power and y - Frequency.

hist(subData$Global_active_power, col= "red", xlab = "Global Active Power (kilowatts)",ylab = "Frequency"
      , main = "Global Active Power")

## Saving to png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
