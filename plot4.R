## Simon Hobbs
## 09-Oct-2022
## Coursera JHU Data Science with R
## Course 4 EDA, Assig 1 Plotting

## plot4.R

###################

# IMPORT DATA

###################

## Unzip the data
if (!exists("household_power_consumption.txt")) {
    unzip("./data/exdata_data_household_power_consumption.zip", 
          junkpaths = T)
}


## Read the whole dang lot in
df_data <- read.table("household_power_consumption.txt", 
                   header=T, 
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   comment.char = "",
                   na.strings=c("?"),
                   nrows = 3e6)

## Drop everything except the dates of interest
df_data <- df_data[grep("(^1/2/2007$)|(^2/2/2007$)",df_data$Date),]

## Convert Time to proper Time class
df_data$DateTime <- paste(df_data$Date, df_data$Time)

## Convert Date to proper date class
df_data$DateTime <- as.POSIXct(df_data$DateTime, "%d/%m/%Y %H:%M:%S", tz="GMT")




###################

# GENERATE PLOT

###################

png("plot4.png")

par(mfrow=c(2,2))

plot(x=df_data$DateTime, 
     y=df_data$Global_active_power,
     col='black', 
     main="Time vs Global Active Power", 
     ylab ='Global Active Power (kilowatts)',
     xlab = "",
     type = 'l'
)

plot(x=df_data$DateTime, 
     y=df_data$Voltage,
     col='black', 
     main="Time vs Voltage", 
     ylab ='Voltage (Volts)',
     xlab = "",
     type = 'l'
)

plot(x=df_data$DateTime, 
     y=df_data$Sub_metering_1,
     col='black', 
     main="Time vs Sub metering", 
     ylab ='Energy sub metering',
     xlab = "",
     type = 'n'
)

with(df_data, {
    lines(DateTime, Sub_metering_1, col='black');
    lines(DateTime, Sub_metering_2, col='red');
    lines(DateTime, Sub_metering_3, col='blue');
    legend("topright", 
           col = c("black","red","blue"),
           legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
           lty = 1,
           bty = 'n'
    )
})

plot(x=df_data$DateTime, 
     y=df_data$Global_reactive_power,
     col='black', 
     main="Time vs Global Reactive Power", 
     ylab ='Global Reactive Power (kilowatts)',
     xlab = "",
     type = 'l'
)

dev.off()



