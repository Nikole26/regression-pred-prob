#### Initial EDA

# Load package(s) 
library(tidymodels)
library(tidyverse)
library(here)

# Load data
load(here("01_attempt/data/training_data.rda"))
load(here("01_attempt/data/testing_data.rda"))

# Exploring data-----
skimr::skim_without_charts(training_data)

# Target variable distribution --------
ggplot(data = training_data, aes(x = 10^(log_price))) +
  geom_histogram() +
  ylab("Price") +
  ggtitle("Box Plot of Price Distribution")

## With log applied
ggplot(data = training_data, aes(x = log_price)) +
  geom_histogram() +
  ylab("Price") +
  ggtitle("Box Plot of Price Distribution")

# Check correlations-----------
cor_matrix <- air_bnb_data |>
  select (where(is.numeric) | where(is.logical)) |>
  na.omit() |> 
  cor() |>
  as_tibble( )
