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
                ,colClasses=c(rep("character",2),rep("NULL",4),rep("numeric",3)))
hpc <- subset(hpc, Date %in% c("1/2/2007","2/2/2007"))
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time),"%d/%m/%Y %H:%M:%S")

# create Plots
png(filename = "plot3.png", width = 480, height = 480, units ="px")
par(bg=NA)
with(hpc, plot(datetime, Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering"))
with(hpc,lines(datetime, Sub_metering_2, col="red"))
with(hpc,lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=names(hpc)[7:9], lty=c(1,1), col=c("black","red","blue"), cex=0.95)
dev.off()
