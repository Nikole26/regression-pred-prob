# Regression Problem ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("12_attempt/data/testing_data.rda"))
load(here("12_attempt/results/final_fit.rda"))

# producing predictions
attempt_12_ensemble <- testing_data |>
  bind_cols(predict(air_bnb_final, testing_data, members = TRUE)) |>
  rename(ensemble = .pred) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_12_ensemble, here("submissions/attempt_12_ensemble.csv"))
