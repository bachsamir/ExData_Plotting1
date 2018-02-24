# Plot4

rm(list = ls(all = TRUE))
setwd("H:/2016_Samsung/Coursera_Video/Data Sciences/R_Exemples/Graphs")

###Download the zip file in Graphs folder
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="H:/2016_Samsung/Coursera_Video/Data Sciences/R_Exemples/Graphs/power_consumption.zip")
unzip(zipfile="H:/2016_Samsung/Coursera_Video/Data Sciences/R_Exemples/Graphs/power_consumption.zip",
      exdir="H:/2016_Samsung/Coursera_Video/Data Sciences/R_Exemples/Graphs")

list.files()

###Enable packages to use
library(data.table) # a prockage that handles dataframe better
library(dplyr) # for fancy data table manipulations and organization

###Read household power consumption data
consumption <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")

### Create 2 new variables with by transforning Date
consumption$Date_2 <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")
consumption$Date_3 <- as.Date(consumption$Date_2)

###Subsetting household power consumption data
consumption1 <- subset(consumption, Date_3 >= as.Date("2007-02-01") & Date_3 <= as.Date("2007-02-02"))

#Plot4
png(file = "Plot4.png",  width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,4,4))

with(consumption1, plot(Date_2, Global_active_power, type = "l",
                        xlab = "", ylab = "Global Active Power"))

with(consumption1, plot(Date_2, Voltage, type = "l",
                        xlab = "datetime", ylab = "Voltage"))

with(consumption1, plot(Date_2, Sub_metering_1, type = "l",
                        xlab = "", ylab = "Energy sub metering"))
with(consumption1, points(Date_2, Sub_metering_2, type = "l", col = "red"))
with(consumption1, points(Date_2, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(consumption1, plot(Date_2, Global_reactive_power, type = "l",
                        xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
