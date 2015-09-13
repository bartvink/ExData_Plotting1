
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

# Subset data
HouseholdPowerCon <- HouseholdPowerCon[grep("^1/2/2007$|^2/2/2007$",HouseholdPowerCon$Date),]

# Convert Date and Time column to Date class and store it in Date column
HouseholdPowerCon$Date <- strptime(paste(HouseholdPowerCon$Date,HouseholdPowerCon$Time), "%d/%m/%Y %H:%M:%S")

# Set english locale to get weekdays in english
Sys.setlocale("LC_ALL", "en_US")

# Set layout
par(mfcol=c(2,2))

# Make plot in top left corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Global_active_power, 
     type="l",
     ylab="Global Active Power",
     xlab="")

# Make plot in bottom left, legend border not visible, legend font adjusted
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_2, 
      type="l", col="red")
lines(HouseholdPowerCon$Date,HouseholdPowerCon$Sub_metering_3, 
      type="l", col="blue")
legend("topright", box.lwd=0, legend=names(data[7:9]), lty=1, col=c("black","red","blue"), cex=0.7)

# Make plot in top right corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")

# Make plot in bottom right corner
plot(HouseholdPowerCon$Date,HouseholdPowerCon$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

# Store the plot in a png file
dev.copy(png,file="plot4.png")
dev.off()