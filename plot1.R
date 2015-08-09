##read the data set
library(data.table)
house_power<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",dec=".",fill=
                          TRUE,stringsAsFactor=FALSE,skip=0)
house_power$Date<-as.Date(house_power$Date,format="%d/%m/%Y")
##filter the data set to include only 01/02/2007 and 02/02/2007
library(dplyr)
house_power_filter<-filter(house_power, Date >= as.Date("01/02/2007",format="%d/%m/%Y"), Date < as.Date("03/02/2007",format="%d/%m/%Y"))
house_power_filter<-mutate(house_power_filter,WeekDay=weekdays(house_power_filter$Date))
house_power_filter<-mutate(house_power_filter,DateTime=paste(Date, Time))
house_power_filter$DateTime <-strptime(house_power_filter$DateTime,format="%d/%m/%Y %H:%M:%S")#can not compare on the Datetime format

## plot the chart 
##plot1 ss
png("plot1.png", width = 480, height = 480)
hist(house_power_filter$Global_active_power,ylim=c(0,1200),axes=FALSE,yaxt="n",
     col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
axis(1, xaxp=c(0,6,3), las=0)
axis(2, yaxp=c(0, 1200,6), las=0)
dev.off()
##plot1 ee