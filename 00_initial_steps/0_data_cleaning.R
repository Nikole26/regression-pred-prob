#### Initial Cleaning

# Load package(s) 
library(tidymodels)
library(tidyverse)
library(here)

#Loading data-------
air_bnb_data <- read_csv(here("data/train_regression.csv"),
                         col_types = cols(id = col_character()))
air_bnb_test_data <- read_csv(here("data/test_regression.csv"),
                              col_types = cols(id = col_character()))
air_bnb_dictionary <- readxl::read_excel(here("data/data_dictionary.xlsx"))

# Checking missingness-------
skimr::skim_without_charts(air_bnb_data)
skimr::skim_without_charts(air_bnb_test_data)

## Most missingness in host_variables and review_scores_variables

# Dealing with missingness-----
summary(air_bnb_data$beds)

air_bnb_data |>
  count(bathrooms_text) |>
  arrange(-n) |>
  view()

# training data tidy-----
training_data <- air_bnb_data |>
  mutate(
    ### creating factors -----
    host_response_time = factor(host_response_time),
    room_type = factor(room_type),
    host_verifications = factor(host_verifications),
    neighbourhood_cleansed = factor(neighbourhood_cleansed),
    property_type = factor(property_type),
    
    ### managing numbers ------
    host_response_rate = as.numeric(sub("%", "", host_response_rate)),
    host_acceptance_rate = as.numeric(sub("%", "", host_acceptance_rate)),
    bathrooms = if_else(str_detect(bathrooms_text, "alf"), 0.5, parse_number(bathrooms_text)),
    price = as.numeric(gsub("[$,]", "", price)),
    
    ### managing dates -----
    host_since = year(host_since),
    year_since = factor(host_since - 0),
    last_review = year(last_review),
    last_review_year = factor(last_review - 0),
    first_review = year(first_review),
    first_review_year = factor(first_review - 0)) |>
  
  select(-c(bathrooms_text, host_neighbourhood, host_since, last_review, first_review, host_location))

# testing data tidy-------
testing_data <- air_bnb_test_data |>
  mutate(host_acceptance_rate = as.numeric(sub("%","", host_acceptance_rate)),
         room_type = factor(room_type),
         property_type = factor (property_type),
         neighbourhood_cleansed = factor(neighbourhood_cleansed),
         bathrooms = if_else(str_detect(bathrooms_text, "alf"), 0.5, parse_number (bathrooms_text)),
         host_since = year (host_since),
         host_verifications = factor(host_verifications),
         host_response_time = factor(host_response_time),
         host_response_rate = as.numeric(sub("%", "", host_response_rate)),
         year_since = factor (host_since - 0),
         last_review = year (last_review),
         first_review = year(first_review),
         first_review_year = factor(first_review - 0)) |>

  select(-c(bathrooms_text, host_neighbourhood, host_since, last_review, first_review, host_location))

# Save out Cleaned Data
save(training_data, file = here("data/training_data.rda"))
save(testing_data, file = here("data/testing_data.rda"))
