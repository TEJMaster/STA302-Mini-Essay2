# Load necessary libraries
library(readr)
library(dplyr)

# Read the raw dataset
subway_delay_data <- read_csv("inputs/data/subway_delay_data_2023.csv")

# Clean the data by removing records with 'NA' in the 'Line' column and data point not in the 4 subway lines in Toronto
clean_subway_delay_data <- subway_delay_data %>%
  filter(!is.na(Line))  %>%
  filter(Line %in% c("BD", "YU", "SHP", "SRT"))

# Save the cleaned data to a new CSV file
write_csv(x = clean_subway_delay_data, file = "outputs/data/cleaned_subway_delay_data_2023.csv")
