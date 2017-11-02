#Read in the table via its URL in a dataframe called df

if (!file.exists("household_power_consumption.txt")) {
  print("File household_power_consumption.txt not found in working directory")
  stop()
}

df <- read.table("household_power_consumption.txt", header= TRUE, sep= ";", stringsAsFactors = FALSE)

# Set the df$Date to type Date anddf$Global_active_power to double
df$Date <- as.Date(strptime(df$Date,format = "%d/%m/%Y"))
df$Global_active_power<-as.double(df$Global_active_power)

#Subset the dateframe to the two days needed
df<-subset(df,df$Date == "2007-02-01" | df$Date == "2007-02-02")

# Open the graphic device, create the plot and close it.
png(filename = "Plot1.png")
hist(df$Global_active_power, main = "Global Active Power", xlab= "Global Active Power (kilowatts)",bg = NA, col="red", ylim = range(0:1200), plot = TRUE)

dev.off()