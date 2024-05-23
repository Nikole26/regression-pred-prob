# Final Project ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("10_attempt/data/testing_data.rda"))
load(here("10_attempt/results/final_fit.rda"))

# producing predictions
attempt_10_bt_01 <- testing_data |>
  bind_cols(predict(final_fit, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_10_bt_01, here("submissions/attempt_10_bt_01.csv"))
