# Import opendatatoronto package
# install.packages("opendatatoronto")
# install.packages("here")

library(opendatatoronto)
library(here)

ttc_packages <- search_packages("ttc")
subway_delay_data <- list_package_resources("996cfe8d-fb35-40ce-b569-698d51fc683b") |> 
  filter(name == "ttc-subway-delay-data-2023") |>
  get_resource()
write_csv(
  x=subway_delay_data,
  file=here("inputs", "data", "subway_delay_data_2023.csv")
)