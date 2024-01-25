# Load necessary libraries
# install.packages("lubridate")
# install.packages("dplyr")
# install.packages("ggplot2")

library(lubridate)
library(dplyr)
library(ggplot2)

# Parameters
n <- 1000  # number of records
subway_id_range <- 1:10
date_range <- seq(as.Date('2023-01-01'), as.Date('2023-12-31'), by="day")
time_range <- seq(from = as.POSIXct("00:00", format = "%H:%M"),
                  to = as.POSIXct("23:59", format = "%H:%M"), by = "mins")

# Generate Data
set.seed(302)  
subway_ids <- sample(subway_id_range, n, replace = TRUE)
dates <- sample(date_range, n, replace = TRUE)
days <- weekdays(dates)
time <- sample(time_range, n, replace = TRUE)
delay_durations <- 1:20

# Combine into a data frame
subway_delays <- data.frame(SubwayID = subway_ids,
                            Date = dates,
                            Day = days,
                            Time = format(time, format = "%H:%M"),
                            Delay_Durations = delay_durations)
write_csv(
  x=subway_delays,
  file="./inputs/data/simulate_subway_data.csv"
)

# View the first few rows of the data set
head(subway_delays)
