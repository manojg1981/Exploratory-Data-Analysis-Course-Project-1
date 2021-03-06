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
dataGlobalActivePower <- as.numeric(subsetConsumptionData$Global_active_power,rm=FALSE)

plot(subsetConsumptionData$datetime,dataGlobalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png",  height=480, width=480)
dev.off()
