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
date_range <- seq(as.Date('2024-01-01'), as.Date('2024-12-31'), by="day")
time_range <- seq(from = as.POSIXct("00:00", format = "%H:%M"),
                  to = as.POSIXct("23:59", format = "%H:%M"), by = "mins")

# Generate Data
set.seed(302)  
subway_ids <- sample(subway_id_range, n, replace = TRUE)
dates <- sample(date_range, n, replace = TRUE)
days <- weekdays(dates)
times <- sample(time_range, n, replace = TRUE)
delay_durations <- 1:20

# Combine into a data frame
subway_delays <- data.frame(SubwayID = subway_ids,
                            Date = dates,
                            Day = days,
                            Time = format(times, format = "%H:%M"),
                            DelayInMinutes = delay_durations)
# View the first few rows of the data set
head(subway_delays)

# Test 1: Check the frequency of delay in each day
subway_delays$Day <- factor(subway_delays$Day, 
                            levels = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                       "Friday", "Saturday", "Sunday"), 
                            ordered = TRUE)

# Group and summarize to get frequency of delay for each day
total_delay_by_day <- subway_delays %>%
  group_by(Day) %>%
  summarize(Delay_Frequency = n())  # Count the number of delays for each day

# Plot the data
ggplot(total_delay_by_day, aes(x = Day, y = Delay_Frequency, fill = Day)) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency of TTC Subway Delays by Day of the Week",
       x = "Day of the Week",
       y = "Frequency of Delays",
       fill = "Day of the Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Test 2: Check the frequency of time in the day of delay
subway_delays$Time <- as.POSIXct(subway_delays$Time, format = "%H:%M")

# Extract Hour from Time
subway_delays$Hour <- hour(subway_delays$Time)

# Group and summarize to get frequency of delay for each hour
total_delay_by_hour <- subway_delays %>%
  group_by(Hour) %>%
  summarize(Delay_Frequency = n())  # Count the number of delays for each hour

# Plot the data
ggplot(total_delay_by_hour, aes(x = Hour, y = Delay_Frequency, fill = as.factor(Hour))) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency of TTC Subway Delays by Hour of Day",
       x = "Hour of Day",
       y = "Frequency of Delays",
       fill = "Hour of Day") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_continuous(breaks = 0:23)  
