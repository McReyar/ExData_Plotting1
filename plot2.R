# download files, if it is missing
if(sum(list.files() == "household_power_consumption.txt") == 0) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  unzip(temp)
  unlink(temp)
  rm(temp)  
}

# read data
hpc <- read.csv("household_power_consumption.txt"
               ,sep=";", comment.char="", na.strings="?"
               ,colClasses=c(rep("character",2),"numeric",rep("NULL",6)))
hpc <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time),"%d/%m/%Y %H:%M:%S")

# create Plot
png(filename = "plot2.png", width = 480, height = 480, units ="px")
with(hpc,plot(datetime, Global_active_power, type ="l", xlab =NA, ylab="Global Active Power (kilowatts)"))
dev.off()
