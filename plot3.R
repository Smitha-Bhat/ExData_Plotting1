plot3 <- function(){
  
  # Reading the data rom the dates 2007-02-01 and 2007-02-02
  con <- file ("household_power_consumption.txt")
  data <- read.table(text = grep("^[1,2]/2/2007", readLines(con), value = TRUE), 
                     col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                   "Voltage", "Global_intensity", "Sub_metering_1", 
                                   "Sub_metering_2", "Sub_metering_3"), 
                     header=TRUE , sep=";", na.strings ="?")
  
  # conveting to datetime
  data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  
  png(filename = "plot3.png", width = 480, height = 480)
  with(data, {
    plot(data$Datetime, data$Sub_metering_1, type = "l", 
          ylab = "Energy sub metering",xlab = "")
    lines(data$Datetime, data$Sub_metering_2, col = 'Red')
    lines(data$Datetime, data$Sub_metering_3, col = 'Blue')
  })
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
  close(con)
  
}