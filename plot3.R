library("data.table")

# Reads in data file, only reads in data that has a valid entry
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Forces Decimal Notation
powerDT[,Global_active_power := lapply(.SD, as.numeric),.SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Cuts the selection of data to values for February 1st and 2nd
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Creates Empty Plot
png("plot3.png", width=480, height=480)

# Third Plot
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()
