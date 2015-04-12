library(data.table)
library(lubridate)
library(dplyr)

# download file, unzip, and load and filter data
if (!file.exists("./ExData_Plotting1/data/household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                method='curl', 
                destfile="./ExData_Plotting1/data/exdata-data-household_power_consumption.zip"
  )
  allData <-  unzip("./ExData_Plotting1/data/exdata-data-household_power_consumption.zip",exdir = "./data")
} 
hpc <- fread(allData, sep="auto", header="auto", na.strings=c("?"), stringsAsFactors=FALSE, verbose=FALSE)
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

#Create Plot 1 Histogram
hist(hpcPlotData$Global_active_power, main = paste("Global Active Power"), col="red", ylab = "Frequency", xlab="Global Active Power (kilowatts)")

# Create image file
dev.copy(png, file="./ExData_Plotting1/plot1.png", width=480, height=480)
dev.off()
