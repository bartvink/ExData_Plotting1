
# Download the file and put in the 'data' folder.
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")

# Unzip the file
unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")

# Read data from the files into the variables.
HouseholdPowerCon <- read.table("./data/household_power_consumption.txt",
                                header = TRUE,
                                sep = ";",
                                na.strings = "?")

# Convert date and time.
HouseholdPowerCon$Date <- as.Date(HouseholdPowerCon$Date, format = "%d/%m/%Y")

# Subset dates between 2007-02-01 and 2007-02-02.
HouseholdPowerCon <- HouseholdPowerCon[HouseholdPowerCon$Date == "2007-02-01" | HouseholdPowerCon$Date == "2007-02-02", ]

#set layout
par(mfcol=c(2,2))

#make plot in top left corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Global_active_power, 
     type="l",
     ylab="Global Active Power",
     xlab="")

#make plot in bottom left, legend border not visible, legend font adjusted
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_2, 
      type="l", col="red")
lines(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_3, 
      type="l", col="blue")
legend("topright", box.lwd=0, legend=names(data[7:9]), lty=1, col=c("black","red","blue"), cex=0.7)

#make plot in top right corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")

#make plot in bottom right corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

# Store the plot in a png file
dev.copy(png,file="plot4.png")
dev.off()