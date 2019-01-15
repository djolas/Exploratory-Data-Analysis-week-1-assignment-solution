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

## Plot number 3
#3. plot of the Energy sub metering Vs Weekdays for different 
# submeterings i.e. Submetering_1, submetering_2 and submetering_3
# Opening the Graphics device
png(file = "plot3.png",
    height = 480, 
    width = 480)
# make an empty plot

with(stats, plot(full_date_time, Sub_metering_1, type = "n",
                 ylab = "Energy Sub metering",
                 xlab = "",
                 main = "Energy Sub metering as a function of time"))
with(stats, lines(full_date_time, Sub_metering_1,
                  col = "black"))
with(stats, lines(full_date_time, Sub_metering_2, 
                  col = "red"))
with(stats, lines(full_date_time, Sub_metering_3, 
                  col = "blue"))
legend("topright", lty = 1, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Submetering_3"))

dev.off()
