# Regression Prediction Problem----
# Training best model - Rf model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(bonsai)

# loading necessary data
load(here("12_attempt/results/bt_tune_2.rda"))
load(here("12_attempt/data/testing_data.rda"))
load(here("12_attempt/results/air_bnb_final.rda"))

# trained ensemble model
set.seed(120)
final_fit <- testing_data |>
  bind_cols(predict(air_bnb_final, testing_data, members = TRUE)) |>
  rename(ensemble = .pred)


