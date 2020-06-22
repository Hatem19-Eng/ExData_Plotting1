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


png("plot3.png", width=480, height=480)

# Plot 3
plot(Data[, dateTime], Data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Data[, dateTime], Data[, Sub_metering_2],col="red")
lines(Data[, dateTime], Data[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()