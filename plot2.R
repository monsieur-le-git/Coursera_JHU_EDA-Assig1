## Simon Hobbs
## 09-Oct-2022
## Coursera JHU Data Science with R
## Course 4 EDA, Assig 1 Plotting

## plot2.R

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

png("plot2.png") 

plot(x=df_data$DateTime, 
     y=df_data$Global_active_power,
     col='black', 
     main="Time vs Global Active Power", 
     ylab ='Global Active Power (kilowatts)',
     xlab = "",
     type = 'l'
     )

dev.off()
