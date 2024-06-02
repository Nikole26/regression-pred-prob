# Regression Problem ----
# Assessing final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# loading necessary data
load(here("06_attempt/data/testing_data.rda"))
load(here("06_attempt/results/final_fit.rda"))

# producing predictions
attempt_06_bt_02 <- testing_data |>
  bind_cols(predict(final_fit, testing_data)) |>
  mutate(predicted = 10^.pred) |>
  select(id, predicted) 

write_csv(attempt_06_bt_02, here("submissions/attempt_06_bt_02.csv"))
