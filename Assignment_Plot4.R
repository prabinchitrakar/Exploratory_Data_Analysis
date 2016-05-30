library(sqldf)

dataFile   <- "household_power_consumption.txt"
sqlCommand <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

data <- read.csv.sql(dataFile, sqlCommand, sep=";", stringsAsFactors=FALSE, header=TRUE)

dt <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalActivePower   <- as.numeric(data$Global_active_power)
globalReactivePower <- as.numeric(data$Global_reactive_power)
voltage             <- as.numeric(data$Voltage)

sm1 <- as.numeric(data$Sub_metering_1)
sm2 <- as.numeric(data$Sub_metering_2)
sm3 <- as.numeric(data$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(dt, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(dt, voltage, type="l", xlab="datetime", ylab="Voltage")

line.colors = c("red", "blue", "black")
legend.labels= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot (dt, sm1, type="l", col=line.colors[1], ylab="Energy Sub metering", xlab="")
lines(dt, sm2, type="l", col=line.colors[2])
lines(dt, sm3, type="l", col=line.colors[3])
legend("topright", legend.labels, lty=1, col=line.colors)

plot(dt, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()