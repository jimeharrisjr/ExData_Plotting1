library(data.table)
library(lubridate)

dt<-fread('unzip -p exdata_data_household_power_consumption.zip') # use efficient fread to load the data
# If previous line fails on your platform (because unzip is not set up correctly), comment the above unzip the file manually and use instead:
#dt<-fread('household_power_consumption.txt')

dt[,Date:=dmy(Date)] # use lubridate to convert Date from character to date
dt[,Global_active_power:=as.numeric(Global_active_power)] # convert Global_active_power to numeric
dt<-dt[Date<=ymd('2007-02-02') & Date>=ymd('2007-02-01')] # find all entried between 2/1/2007 and 2/2/2007
hist(dt$Global_active_power, main="Global Active Power", xlab = 'Global Active Power (kilowatts)', col='red') # create a histogram
dev.copy(device=png,file='plot1.png') # copy plot to a png
dev.off() # finish the png (save)