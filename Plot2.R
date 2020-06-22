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

png("plot2.png", width=480, height=480)

plot(x = Data[, dateTime]
     , y = Data[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
