
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
HouseholdPowerCon$Date <- as.Date(HouseholdPowerCon$Date, format="%d/%m/%Y")
HouseholdPowerCon$Datetime <- strptime(paste(HouseholdPowerCon$Date,HouseholdPowerCon$Time),
                          format="%Y-%m-%d %H:%M:%S")

# Subset dates between 2007-02-01 and 2007-02-02.
HouseholdPowerCon <- HouseholdPowerCon[HouseholdPowerCon$Date == "2007-02-01" | HouseholdPowerCon$Date == "2007-02-02", ]

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
