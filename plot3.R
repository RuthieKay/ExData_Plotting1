##Download and load file
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data/powerconsumption.zip")
unzip(zipfile="./data/powerconsumption.zip",exdir="./data")
power <- read.table("./data/household_power_consumption.txt", header=T, sep=";")

##Convert date to date format and create a subset that only contains data for 2/1/2007-2/2/2007
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
set <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

##Convert Sub_metering 1-3 to numeric values and create DateTime variable
set$Sub_metering_1 <- as.numeric(as.character(set$Sub_metering_1))
set$Sub_metering_2 <- as.numeric(as.character(set$Sub_metering_2))
set$Sub_metering_3 <- as.numeric(as.character(set$Sub_metering_3))
set <- transform(set, DateTime=as.POSIXct(paste(Date, Time)))

#Graph DateTime and Sub_Metering 1-3
plot(set$DateTime, set$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
lines(set$DateTime, set$Sub_metering_2, col="red")
lines(set$DateTime, set$Sub_metering_3, col="blue")
legend("topright", pch="--", col=c("black","red","blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Save as png file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
