library("dplyr")
library(lubridate)
f <- read.table("household_power_consumption.txt",header = TRUE, sep = ";",stringsAsFactors = FALSE)
f <- within(f, DT <- paste(Date, Time, sep = " "))
f <- mutate(f,Date = dmy(Date))
data <- filter(f, year(Date) == 2007, month(Date) == 02, day(Date) < 3)
data <- mutate(data, DT = dmy_hms(DT))

data <- mutate(data, Global_active_power = as.numeric(Global_active_power))
data <- mutate(data, Global_reactive_power = as.numeric(Global_reactive_power))
data <- mutate(data, Voltage = as.numeric(Voltage))
data <- mutate(data, Sub_metering_1 = as.numeric(Sub_metering_1))
data <- mutate(data, Sub_metering_2 = as.numeric(Sub_metering_2))
data <- mutate(data, Sub_metering_3 = as.numeric(Sub_metering_3))

par(mfrow = c(2,2))
plot(data$DT, data$Global_active_power, type = "l",xlab = "", ylab = "Global Active Power")
plot(data$DT, data$Voltage, type = "l",xlab = "datatime", ylab = "Voltage")
plot(data$DT, data$Sub_metering_1, type = "n",xlab = "", ylab = "Energy sub metering", col = "black")
points(data$DT, data$Sub_metering_1, type = "l",xlab = "", ylab = "Energy sub metering", col = "black")
points(data$DT, data$Sub_metering_2, type = "l",xlab = "", ylab = "Energy sub metering", col = "red")
points(data$DT, data$Sub_metering_3, type = "l",xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"))
plot(data$DT, data$Global_reactive_power, type = "l",xlab = "datatime", ylab = "Global_reactive_power")

dev.copy(png,file = "plot4.png")
dev.off()


