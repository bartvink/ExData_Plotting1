
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

#Create a Histogram
hist(HouseholdPowerCon$Global_active_power, col = "red", 
           main = "Global Active Power", 
           xlab = "Global Active Power (kilowatts)")

# Store the Histogram in a png file. 
dev.copy(png,file="plot1.png")
dev.off()
