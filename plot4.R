library(dplyr)
library(lubridate)
library(stringr)

## First of all we will load the data. 
setwd("E:\\Online_courses\\Data_Science_Specialization_Coursera\\Course4_Exploratory_Data_Analysis\\Week1\\Assignment\\household_power_consumption")
getwd()

stats <- read.table(file = "household_power_consumption.txt",
                    header = TRUE,
                    sep = ";",
                    na.strings = "?")
stats<- as.data.frame(stats)
head(stats, n = 5)
## Subsetting the data.
## we need to subset the data and we will use the data only for the
## dates 2007-02-01 and 2007-02-02

stats_new <- stats %>%mutate(full_date_time = dmy_hms(str_c(Date, Time, 
                                                            sep = "-")))%>%
        select(full_date_time,Global_active_power:Sub_metering_3)%>%
        filter(full_date_time >= as.Date("2007-02-01 00:00:00") & full_date_time < as.Date("2007-02-03 00:00:00"))

rm(stats)
stats <- stats_new
rm(stats_new)


## Plot # 4
# Opening the graphics device
png(file = "plot4.png", 
    height = 480, 
    width = 480)
## 4. A matrix of plots (2 X 2)
# setting the parameters
par(mfrow = c(2,2))
with(stats, {
        plot(full_date_time, Global_active_power, type = "l",
             ylab = "Global Active Power", 
             xlab = "")
        plot(full_date_time, Voltage, type = "l",
             ylab = "Voltage",
             xlab = "datetime")
        plot(full_date_time, Sub_metering_1, type = "n",
             ylab = "Energy Sub metering",
             xlab = "")
        lines(full_date_time, Sub_metering_1,
              col = "black")
        lines(full_date_time, Sub_metering_2, 
              col = "red")
        lines(full_date_time, Sub_metering_3, 
              col = "blue")
        legend("topright", lty = 1, col = c("black","red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Submetering_3"))
        plot(full_date_time, Global_reactive_power,type = "l",
             col = "black",
             xlab = "datetime", 
             ylab = "Global Reactive Power")
})
dev.off()
