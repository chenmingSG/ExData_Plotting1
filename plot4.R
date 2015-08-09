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
##plot 4 ss
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2)) # create 2 by 2 plot frames
#plot the 1st chart
plot(house_power_filter$Global_active_power,type="l",xaxt="n",yaxt="n",xlab="",ylab="Global Active Power")
alabelloc<-c(1,match("Friday",house_power_filter$WeekDay),length(house_power_filter$WeekDay))
axis(1, at=alabelloc,labels=c("Thu","Fri","Sat"),las=0)
axis(2, yaxp=c(0, 6,3), las=0)
#plot the 2nd chart
plot(house_power_filter$Voltage,type="l",xaxt="n",yaxt="n",xlab="datetime",ylab="Voltage")
alabelloc<-c(1,match("Friday",house_power_filter$WeekDay),length(house_power_filter$WeekDay))
axis(1, at=alabelloc,labels=c("Thu","Fri","Sat"),las=0)
axis(2, yaxp=c(234,246,6), las=0)
#plot the 3rd chart
plot(house_power_filter$Sub_metering_1,type="n",xaxt="n",yaxt="n",xlab="",ylab="Energy sub metering")
lines(house_power_filter$Sub_metering_1)
lines(house_power_filter$Sub_metering_2,col="red")
lines(house_power_filter$Sub_metering_3,col="blue")
alabelloc<-c(1,match("Friday",house_power_filter$WeekDay),length(house_power_filter$WeekDay))
axis(1, at=alabelloc,labels=c("Thu","Fri","Sat"),las=0)
axis(2, yaxp=c(0, 30,3), las=0)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c("solid","solid","solid"), pch = c(" ", " ", " "),
       col = c("black","red", "blue"),lwd = c(1,1),bty="n",cex=0.95)
#plot the 4th chart
plot(house_power_filter$Global_reactive_power,type="l",xaxt="n",yaxt="n",xlab="datetime",ylab="Global_reactive_powe")
alabelloc<-c(1,match("Friday",house_power_filter$WeekDay),length(house_power_filter$WeekDay))
axis(1, at=alabelloc,labels=c("Thu","Fri","Sat"),las=0)
axis(2, yaxp=c(0,0.5,5), las=0)
dev.off()

##plot 4 ee        