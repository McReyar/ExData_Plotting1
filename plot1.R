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
               ,colClasses=c("character","NULL","numeric",rep("NULL",6)))
hpc <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))

# create Plots
png(filename = "plot1.png", width = 480, height = 480, units ="px")
par(bg=NA)
hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()