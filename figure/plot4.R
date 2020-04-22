##### Plotting Four Graphs #####
### 1 - Global Active Power ###
### 2 - Energy Sub Metering and Day ###
### 3 - Voltage and Day ###
### 4 - Global Reactive Power and Day ###

data_raw <-  read.delim("Week 1/Data/household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";")
head(data_raw)
dim(data_raw)
str(data_raw)

data <- data_raw

#Converting Date attribute to Date from Factor
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#data$Time <- strptime(data$Time, format = "%H:%M:%S")
str(data)
class(data)

#Subsetting the Dataset from "2007-02-01" to "2007-02-02"
data <-  data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Converting Date and Time
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

#Converting Global Active Power to numeric
(data$Global_active_power <- as.numeric(as.character(data$Global_active_power)))

#Converting Sub Metering to numeric
(data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1)))
(data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2)))
(data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3)))

#Converting Voltage to numeric
(data$Voltage <- as.numeric(as.character(data$Voltage)))

#Converting Global Active Power to numeric
(data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power)))

#Saving Graph to PNG
png("plot4.png", width = 480, height = 480)

#Creating Frame for 4 Graphs
par(mfrow = c(2,2))

#Plot 1
plot(data$datetime,data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Plot 2
plot(data$datetime,data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#Plot 3
plot(data$datetime,data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$datetime,data$Sub_metering_2, col = "Red")
lines(data$datetime,data$Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col = c("Black","Red","Blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")

#Plot 4
plot(data$datetime,data$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")

dev.off()
