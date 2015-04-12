library(data.table)
library(lubridate)
library(dplyr)

hpc <- fread("./ExData_Plotting1/data/household_power_consumption.txt", sep="auto", header="auto", na.strings=c("?"), stringsAsFactors=FALSE, verbose=TRUE)
hpc$Date <- as.Date(dmy(hpc$Date))
hpcPlotData <- filter(hpc, Date == "2007-02-01" | Date ==  "2007-02-02")

#Coerce all other vectors from 'char' to 'numeric' class
hpcPlotData$Global_active_power <- as.numeric(as.character(hpcPlotData$Global_active_power))
hpcPlotData$Global_reactive_power <- as.numeric(as.character(hpcPlotData$Global_reactive_power))
hpcPlotData$Voltage <- as.numeric(as.character(hpcPlotData$Voltage))
hpcPlotData$Sub_metering_1 <- as.numeric(as.character(hpcPlotData$Sub_metering_1))
hpcPlotData$Sub_metering_2 <- as.numeric(as.character(hpcPlotData$Sub_metering_2))
hpcPlotData$Sub_metering_3 <- as.numeric(as.character(hpcPlotData$Sub_metering_3))

#Create a new timestamp vector - will make plotting easier
hpcPlotData <- transform(hpcPlotData, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

####Copy and paste the plot script you wish to check without having to source and download the data each time

##Create Plot 4 with four charts displayed at once

par(mfrow=c(2,2))

# Plot 1
plot(hpcPlotData$timestamp, hpcPlotData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(hpcPlotData$timestamp, hpcPlotData$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(hpcPlotData$timestamp, hpcPlotData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpcPlotData$timestamp, hpcPlotData$Sub_metering_2, col="red")
lines(hpcPlotData$timestamp, hpcPlotData$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1), bty="n", cex=.5)

# Plot 4
plot(hpcPlotData$timestamp,hpcPlotData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Create image file
dev.copy(png, file="./ExData_Plotting1/plot4.png", width=480, height=480)
dev.off()

