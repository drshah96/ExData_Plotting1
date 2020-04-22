##### Plotting Line Chart between Energy Sub Metering and Day #####

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
(data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1)))
(data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2)))
(data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3)))

#Saving Graph to PNG
png("plot3.png", width = 480, height = 480)
plot(data$datetime,data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$datetime,data$Sub_metering_2, col = "Red")
lines(data$datetime,data$Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col = c("Black","Red","Blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
