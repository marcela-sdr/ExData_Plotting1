## ## Course Project 1: Plot 4

plot4 <- function () {
        ## Set working directory to avoid issues where files are downloaded.
        setwd("C:/Users/Israel.MARCE/Documents/R/4_ExData")
        
        ## Download Data & UNZIP
        if(!file.exists("household_power_consumption.txt")) {
                temp <- tempfile()
                URL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(URL1, temp, mode="wb")
                unzip(temp, "household_power_consumption.txt")
                unlink(temp)
        }
        
        ## Read Data, Careful: NAs are = ?
        hpcons <- read.table("household_power_consumption.txt", sep=";", 
                             col.names=c("Date", "Time", "Global_active_power", 
                                         "Global_reactive_power", 
                                         "Voltage", "Global_intensity", 
                                         "Sub_metering_1", "Sub_metering_2", 
                                         "Sub_metering_3"), na.strings="?", 
                             skip = 66500, nrow = 4000)
        hpcons[, 1] <- as.character(hpcons[, 1])
        hpcons[, 1] <- as.Date(hpcons[, 1], "%d/%m/%Y")
        hpcons[, 2] <- as.character(hpcons[, 2])
        timeTemp <- paste(hpcons[, 1], hpcons[, 2])
        timeTemp <- strptime(timeTemp, "%Y-%m-%d %H:%M:%S")
        hpcons[, 2] <- seq(as.POSIXlt(timeTemp[1]), length = 4000, by = 60)
        
        ## Take information only from Feb. 1st and 2nd, 2007
        sub_hpcons <- subset(hpcons,subset=(hpcons[, 2]>='2007-02-01' & hpcons[, 2]< '2007-02-03'))
        
        ## Open PNG file: 480 x 480 pixels by default 
        png(filename = "plot2.png", bg = "transparent")
        
        ## Create Graph
        gapower <- transform(sub_hpcons, Date = factor(Date))
        plot(gapower$Time, gapower$Sub_metering_1, type="l", 
             ylab=" Global Active Power (kilowatts)", xlab=" ")
        lines(gapower$Time, gapower$Sub_metering_2, col = "red")
        lines(gapower$Time, gapower$Sub_metering_3, col = "blue")
                
        ## Close PNG file
        dev.off()
    
}
