##Download and load file
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data/powerconsumption.zip")
unzip(zipfile="./data/powerconsumption.zip",exdir="./data")
power <- read.table("./data/household_power_consumption.txt", header=T, sep=";")

##Convert date to date format and create a subset that only contains data for 2/1/2007-2/2/2007
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
set <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]

##Convert Global Active Power to a numeric value and create DateTime variable
set$Global_active_power <- as.numeric(as.character(set$Global_active_power))
set <- transform(set, DateTime=as.POSIXct(paste(Date, Time)))

#Graph DateTime and Global Active Power
plot(set$DateTime, set$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l")

##Save as png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
