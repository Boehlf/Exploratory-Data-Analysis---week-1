#Read in the table via its URL in a dataframe called df

if (!file.exists("household_power_consumption.txt")) {
  print("File household_power_consumption.txt not found in working directory")
  stop()
}

df <- read.table("household_power_consumption.txt", header= TRUE, sep= ";", stringsAsFactors = FALSE)

# Set the df$Date to type Date and df$Global_active_power to double
df$Date <- as.Date(strptime(df$Date,format = "%d/%m/%Y"))
df$Global_active_power<-as.double(df$Global_active_power)

#Subset the dateframe to the two days needed
df<-subset(df,df$Date == "2007-02-01" | df$Date == "2007-02-02")

# Concatenate df$Date and df$Time and make it of type POSIXct
df$datetime<-as.POSIXct(paste(df$Date,df$Time,sep =" "))

# Open the graphic device, create the plot and close it.
png(filename = "Plot2.png")

plot(df$datetime, df$Global_active_power, xlab="",ylab= "Global Active Power (kilowatts)", bg = NA, type = "l")

dev.off()