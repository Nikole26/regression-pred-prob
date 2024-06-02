# Regression Problem ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("04_attempt/data/testing_data.rda"))
load(here("04_attempt/results/final_fit.rda"))
load(here("04_attempt/results/final_fit_2.rda"))

# producing predictions
attempt_04_rf_01 <- testing_data |>
  bind_cols(predict(final_fit, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_04_rf_01, here("submissions/attempt_04_rf_01.csv"))

# producing predictions 2
attempt_04_bt_02 <- testing_data |>
  bind_cols(predict(final_fit_2, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_04_bt_02, here("submissions/attempt_04_bt_02.csv"))
