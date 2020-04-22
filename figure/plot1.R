##### Plotting Histogram between Global Active Power and Frequency #####

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

#Converting Global Active Power to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
tail(data)

#Saving Graph to PNG
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
