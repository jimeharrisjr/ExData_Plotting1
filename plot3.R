library(data.table)
library(lubridate)

dt<-fread('unzip -p exdata_data_household_power_consumption.zip') # use efficient fread to load the data
# If previous line fails on your platform (because unzip is not set up correctly), comment the above unzip the file manually and use instead:
#dt<-fread('household_power_consumption.txt')

dt[,datetime:=paste(Date,Time)] # create a combined datetime column
dt[,Date:=dmy(Date)] # use lubridate to convert Date from character to date
dt[,Global_active_power:=as.numeric(Global_active_power)] # convert Global_active_power to numeric
dt<-dt[Date<=ymd('2007-02-02') & Date>=ymd('2007-02-01')] # find all entried between 2/1/2007 and 2/2/2007
dt[,datetime:=dmy_hms(datetime)] # convert datetime to date class
plot(x=dt$datetime,y=dt$Sub_metering_1, type = 'l', ylab = 'Energy sub_metering', xlab = '') # plot sub_metering_1
lines(x=dt$datetime,y=dt$Sub_metering_2, col='red', type = 'l') # add sub_metering_2 in red
lines(x=dt$datetime,y=dt$Sub_metering_3, col='blue', type = 'l') # add sub_metering_3 in blue
legend('topright', col=c('black','red','blue'),c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty = 1) # add legend
dev.copy(device=png,file='plot3.png') # copy plot to a png
dev.off() # finish the png (save)