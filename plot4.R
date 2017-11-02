#Read in the table via its URL in a dataframe called df

if (!file.exists("household_power_consumption.txt")) {
  print("File household_power_consumption.txt not found in working directory")
  stop()
}

df <- read.table("household_power_consumption.txt", header= TRUE, sep= ";", stringsAsFactors = FALSE)

# Set the df$Date to type Date and df$Global_active_power and Sub_metering variables to double
df$Date <- as.Date(strptime(df$Date,format = "%d/%m/%Y"))
df$Global_active_power<-as.numeric(df$Global_active_power)

df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)

#Subset the dateframe to the two days needed
df<-subset(df,df$Date == "2007-02-01" | df$Date == "2007-02-02")

# Concatenate df$Date and df$Time and make it of type POSIXct
df$datetime<-as.POSIXct(paste(df$Date,df$Time,sep =" "))

# Open the graphic device and set the canvass for four plots and background transparant
png(filename = "Plot4.png")
par(mfrow = c(2, 2), bg = NA)

# Create first plot
plot(df$datetime, df$Global_active_power, xlab="",ylab= "Global Active Power (kilowatts)"  ,type = "l")

# Create second plot
plot(df$datetime, df$Voltage, xlab="datetime",ylab= "Voltage"  ,type = "l")

# Create third plot
with(df, plot(datetime,Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "n"))
with(df, points(datetime,Sub_metering_3, col = "blue", type="l"))
with(df, points(datetime,Sub_metering_1, col = "black", type="l"))
with(df, points(datetime,Sub_metering_2, col = "red", type="l"))
legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

# Create fourth plot
plot(df$datetime, df$Global_reactive_power, xlab="datetime",ylab= "Voltage"  ,type = "l")

# Close graphic device
dev.off()