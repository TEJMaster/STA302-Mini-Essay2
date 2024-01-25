# install.packages("dplyr")
# install.packages("readr")
# install.packages("lubridate")
# install.packages("here")

library(readr)
library(dplyr)
library(lubridate)

# Load the cleaned subway delay data
file_path <- here("outputs", "data", "cleaned_subway_delay_data_2023.csv")
subway_delay_data <- read_csv(file_path)

# Test 1: All Date columns are from year 2023
test_year_2023 <- all(year(ymd(subway_delay_data$Date)) == 2023)

# Test 2: Min Delay column is >= 0
test_min_delay_non_negative <- all(subway_delay_data$Min_Delay >= 0)

# Test 3: Line column only includes specific data points
allowed_lines <- c("BD", "YU", "SHP", "SRT")
test_line_inclusion <- all(subway_delay_data$Line %in% allowed_lines)

list(
  test_year_2023 = test_year_2023,
  test_min_delay_non_negative = test_min_delay_non_negative,
  test_line_inclusion = test_line_inclusion
)
