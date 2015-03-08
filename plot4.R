plot4 <- function(){
 
  # Reading the data rom the dates 2007-02-01 and 2007-02-02
  con <- file ("household_power_consumption.txt")
  data <- read.table(text = grep("^[1,2]/2/2007", readLines(con), value = TRUE), 
                     col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                   "Voltage", "Global_intensity", "Sub_metering_1", 
                                   "Sub_metering_2", "Sub_metering_3"), 
                     header=TRUE , sep=";", na.strings ="?")
  
  # conveting to datetime
  data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  
  png(filename = "plot4.png", width = 480, height = 480)
  par(mfrow = c(2, 2))
  
  #Top Left Plot
  plot(data$Datetime, data$Global_active_power, type = "l", 
       ylab = "Global Active Power", xlab = "")
  
  #Top Right Plot
  plot(data$Datetime, data$Voltage, type = "l", 
       ylab = "Voltage", xlab = "datetime")
  
  #Bottom Left Plot 
  plot(data$Datetime, data$Sub_metering_1, type = "l", 
       ylab = "Energy sub metering",xlab = "")
  lines(data$Datetime, data$Sub_metering_2, col = 'Red')
  lines(data$Datetime, data$Sub_metering_3, col = 'Blue')
  legend("topright", lty = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", )
  
  # Bottom Right Plot
  plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", 
       ylab = "Global_reactive_power", ylim = c(0, 0.5))
  
  dev.off()
  close(con)
  
}