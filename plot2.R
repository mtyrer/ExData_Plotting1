# This function is used to create plot 2 of the  required plots for the first project
# in the 5th edition of the Exploratory Data Analysis MOOC from coursera / 
# John Hopkins university
#
# The plots center around the information from the power consumption dataset 
# available from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 
# Dataset first down loaded on 7th of August 2014 
# Written by Mark Tyrer
#
plot2 <- function () {
    
    zipFileName <- "../exdata-data-household_power_consumption.zip"
    fileName <- "../household_power_consumption.txt"
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    plotfile <-  "plot2.png"
    
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
    
    DT <- data.frame(DT, DateTime = paste(DT$Date, DT$Time, sep = " "))
     
    DT$DateTime <- strptime(DT$DateTime, format="%Y-%m-%d %H:%M:%S")
    # open the graphics device
    png(filename = plotfile)
    
    # plot the graph
    with (DT, plot(DateTime, Global_active_power, main = "", 
         ylab = "Global Active Power (kilowatts)", xlab="", type = "l"))
    
    # Close the graphics device 
    dev.off()
    
}