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

subMetering1 <- as.numeric(subsetConsumptionData$Sub_metering_1,rm=FALSE)
subMetering2 <- as.numeric(subsetConsumptionData$Sub_metering_2,rm=FALSE)
subMetering3 <- as.numeric(subsetConsumptionData$Sub_metering_3,rm=FALSE)

with(subsetConsumptionData, {
                plot(subMetering1~subsetConsumptionData$datetime, type="l",
                ylab="Energy Submetering", xlab="")
                lines(subMetering2~subsetConsumptionData$datetime,col='Red')
                lines(subMetering3~subsetConsumptionData$datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()