
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

#convert Date and Time column to Date class and store it in Date column
HouseholdPowerCon$Date <- strptime(paste(HouseholdPowerCon$Date,HouseholdPowerCon$Time), "%d/%m/%Y %H:%M:%S")

#set english locale to get weekdays in english
Sys.setlocale("LC_ALL", "en_US")

# Create a plot
plot(HouseholdPowerCon$Date, HouseholdPowerCon$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

# Store the Plot in a png file. 
dev.copy(png,file="plot2.png")
dev.off()
