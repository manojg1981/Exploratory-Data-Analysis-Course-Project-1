zipfilename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt"))
{
        unzip(zipfilename)
}

## Pull data from fiel to memory
powerConsumptionData <- read.table("household_power_consumption.txt",header = TRUE ,sep=";", na.string = "?")

## Subset the data to only get 2 days of data
#subsetConsumptionData <- powerConsumptionData[powerConsumptionData$Date %in% c("1/2/2007","2/2/2007"),] 
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format = "%d/%m/%Y")
subsetConsumptionData <- subset(powerConsumptionData,subset = (Date >=  "2007-02-01" & Date <=  "2007-02-02" ))

# datetime <- strptime(paste(as.Date(subsetConsumptionData$Date),subsetConsumptionData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
datetime <- paste(as.Date(subsetConsumptionData$Date),subsetConsumptionData$Time)
subsetConsumptionData$datetime <- as.POSIXct(datetime)

# head(subsetConsumptionData)


## Plot 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subsetConsumptionData, {
        plot(Global_active_power~datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
         legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()