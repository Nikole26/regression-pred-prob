# Regression Problem ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("07_attempt/data/testing_data.rda"))
load(here("07_attempt/results/final_fit.rda"))
load(here("07_attempt/results/final_fit_1.rda"))

# producing predictions
attempt_07_bt_02 <- testing_data |>
  bind_cols(predict(final_fit, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_07_bt_02, here("submissions/attempt_07_bt_02.csv"))

# producing predictions 1
attempt_07_bt_01 <- testing_data |>
  bind_cols(predict(final_fit_1, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_07_bt_01, here("submissions/attempt_07_bt_01.csv"))
