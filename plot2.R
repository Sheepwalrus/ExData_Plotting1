library("data.table")

# Reads in data file, only reads in data that has a valid entry
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Allows Histogram to be display numbers in decimal format
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Cuts the selection of data to values for February 1st and 2nd
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

# Second Plot
plot(x = powerDT[,dateTime],y = powerDT[,Global_active_power],type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()
