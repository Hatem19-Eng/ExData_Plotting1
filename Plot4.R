# Reading data using data.table
Data <- data.table::fread(input = "household_power_consumption.txt"
                          , na.strings="?"
)
#Forcing data to be numeric
Data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Changing the data type.
Data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Filtering dates 

Data <- Data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(Data[, dateTime], Data[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(Data[, dateTime],Data[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(Data[, dateTime], Data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Data[, dateTime], Data[, Sub_metering_2], col="red")
lines(Data[, dateTime], Data[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(Data[, dateTime], Data[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
