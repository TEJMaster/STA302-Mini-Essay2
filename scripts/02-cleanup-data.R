# Load necessary libraries
# install.packages("dplyr")
# install.packages("readr")
# install.packages("here")

library(readr)
library(dplyr)
library(here)

# Use the `here` function to specify file paths relative to the project root
input_file_path <- here("inputs", "data", "subway_delay_data_2023.csv")
output_file_path <- here("outputs", "data", "cleaned_subway_delay_data_2023.csv")

# Read the raw dataset
subway_delay_data <- read_csv(input_file_path)

# Clean the data by removing records with 'NA' in the 'Line' column and data point not in the 4 subway lines in Toronto
clean_subway_delay_data <- subway_delay_data %>%
  filter(!is.na(Line))  %>%
  filter(Line %in% c("BD", "YU", "SHP", "SRT"))

# Save the cleaned data to a new CSV file
write_csv(x = clean_subway_delay_data, file = output_file_path)
