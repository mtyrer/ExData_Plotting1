# This function is used to create plot 4 of the  required plots for the first project
# in the 5th edition of the Exploratory Data Analysis MOOC from coursera / 
# John Hopkins university
#
# The plots center around the information from the power consumption dataset 
# available from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 
# Dataset first down loaded on 7th of August 2014 
# Written by Mark Tyrer
#
plot4 <- function () {
    
    zipFileName <- "../exdata-data-household_power_consumption.zip"
    fileName <- "../household_power_consumption.txt"
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    plotfile <-  "plot4.png"
    
    # Step one. unzip the file, if it does not exist then fail. 
    # if the data needs to be downloaded it can be retreive the data 
    # from the address :-
    # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
    # When I have more time I will figure a way around the proxy
    # storing the zip file in the parent directory
    
    if (!file.exists(zipFileName)) {
        
        stop (paste(zipFileName, ": File does not exist: look for it at ", 
                    fileURL, sep = " " ))
    } 
    
    # unzip the file
    unzip (zipFileName, exdir="..")
    
    # load the tale 
    if (!file.exists(fileName)) {
        
        stop (paste(fileName, ": File does not exist: look for it at ", 
                    fileURL, sep = " " ))
    }
    
    # load the data into memory
    DT <- read.table (fileName, sep=";", header=TRUE, na.strings = "?")
    
    #Set the Date column to a date type
    DT$Date <- as.Date(DT$Date, format="%d/%m/%Y")
    
    library("data.table")
    
    # get the date subset
    DT <- DT[DT$Date >= "2007-02-01" & DT$Date < "2007-02-03",]
    
    # Add the datetime column
    DT <- data.frame(DT, datetime = paste(DT$Date, DT$Time, sep = " "))
     
    DT$datetime <- strptime(DT$datetime, format="%Y-%m-%d %H:%M:%S")
    
    # open the graphics device
    #png(filename = plotfile)
    
    #Create a 2 x 2 matrix for the plots
    par(mfrow = c(2, 2))
    
    # plot the graphs
    
    # Graph 1
    # plot the graph
    with ( 
        DT, {
            # Plot top left
            plot(datetime, Global_active_power, main = "", 
                 ylab = "Global Active Power (kilowatts)", xlab="", type = "l")
    
            # plot top right
            plot(datetime, Voltage, main = "", type = "l")

            # plot bottom left
            plot(datetime, Sub_metering_1, main = "", 
                 ylab = "Energy sub metering", xlab = "", type = "l")
            lines(datetime, Sub_metering_3, main = "", col = "blue")
            lines(datetime, Sub_metering_2, main = "", col = "red")
            
            # Add the legend
            legend("topright", col = c("black", "red", "blue"), lty =c(1, 1, 1), 
                   legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), bty = "n")
            
            # plot bottom right
            plot(datetime, Global_reactive_power, main = "", type = "l")
        }
    )
    
    
    # Close the graphics device 
    #dev.off()
    
}