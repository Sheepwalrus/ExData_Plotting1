library("data.table")

# Reads in data file, only reads in data that has a valid entry
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Allows Histogram to be display numbers in decimal format
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Cuts the selection of data to values for February 1st. 
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Creates empty plot
png("plot1.png", width=480, height=480)

# First Plot
hist(powerDT[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
